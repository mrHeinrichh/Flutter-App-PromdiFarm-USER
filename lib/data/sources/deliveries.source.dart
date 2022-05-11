import 'dart:io';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:promdifarm_app/core/const/index.dart';
import 'package:promdifarm_app/core/errors/failures.dart';
import 'package:promdifarm_app/core/services/index.dart';
import 'package:promdifarm_app/core/utils/index.dart';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/data/models/parcel/parcel.model.dart';
import 'package:promdifarm_app/domain/sources/index.dart';
import 'package:collection/collection.dart';

class DeliverySourceImp extends DeliverySource {
  static List<Delivery> list = [];
  static List<LatLng> waypoints = [];
  static List<Destination> destinations = [];
  AcceptDelivery acceptedDelivery = AcceptDelivery(
    id: "",
    pending: [],
    completed: [],
    failed: [],
  );
  static Location end = Location(type: "Point", coordinates: []);
  final ApiService api;
  final DirectionsService dirService;
  final LocationService locService;
  final LocalStorageService localStorage;
  final populate =
      "populate=destinations.parcels-populate=shippingAddress.address,destinations.parcels-populate=pickupAddress.address,destinations.parcels-populate=consignee,destinations.parcels-populate=tenant";

  DeliverySourceImp({
    required this.api,
    required this.dirService,
    required this.locService,
    required this.localStorage,
  });

  @override
  AcceptDelivery getAcceptedDelivery() {
    return acceptedDelivery;
  }

  @override
  void setAcceptedDelivery(AcceptDelivery value) {
    this.acceptedDelivery = value;
  }

  @override
  Future<List<Delivery>> fetchAvailableDeliveries() async {
    LatLng cLoc = await locService.getCurrentLocation();

    final response = await api.get(
      endpoint:
          "deliveries?loc=${cLoc.latitude},${cLoc.longitude}&status=Pending,Accepted&$populate",
    );

    if (response.status != "success") {
      throw RequestFailure(response.message);
    }

    if (response.data.length == 0) {
      list = [];
      return list;
    }

    list = response.data.map((e) => Delivery.fromJson(e)).toList();
    return list;
  }

  @override
  Future<AcceptDelivery> acceptDelivery(String id) async {
    try {
      final token = localStorage.getToken();
      final rider = Utils.parseJwt(token)["_id"];

      var bodyReq = {
        "rider": rider,
      };

      final response = await api.patch(
        body: bodyReq,
        endpoint: "deliveries/$id/accept?$populate",
      );

      if (response.status != "success") {
        throw RequestFailure("Delivery not found!");
      }

      Delivery delivery = Delivery.fromJson(response.data[0]);
      this.acceptedDelivery = parseAcceptedDelivery(delivery: delivery, id: id);
      return this.acceptedDelivery;
    } catch (e) {
      throw NetworkFailure("Can't accept delivery!");
    }
  }

  @override
  Future<AcceptDelivery> getDelivery(String id) async {
    try {
      final response = await api.get(endpoint: "deliveries/$id$populate");

      if (response.status != "success") {
        throw RequestFailure("Delivery not found!");
      }

      Delivery delivery = Delivery.fromJson(response.data[0]);
      this.acceptedDelivery = parseAcceptedDelivery(delivery: delivery, id: id);
      return this.acceptedDelivery;
    } catch (e) {
      throw NetworkFailure("Can't complete request!");
    }
  }

  parseAcceptedDelivery({required Delivery delivery, required String id}) {
    destinations = delivery.destinations;
    end = delivery.end;
    waypoints = destinations
        .where((e) => !(delivery.end.coordinates[1] == e.loc.coordinates[1] &&
            delivery.end.coordinates[0] == e.loc.coordinates[0]))
        .map(
      (e) {
        return LatLng(
          e.loc.coordinates[1],
          e.loc.coordinates[0],
        );
      },
    ).toList();

    List<Destination> pending = [];
    List<Destination> completed = [];
    List<Destination> failed = [];
    List<Destination> started = [];
    List<Destination> arrived = [];
    List<Destination> waiting = [];

    destinations.forEach((e) {
      if (e.status.toLowerCase() == "pending" && e.parcels.length > 0)
        pending.add(e);
      if (e.status.toLowerCase() == "completed" && e.parcels.length > 0)
        completed.add(e);
      if (e.status.toLowerCase() == "failed" && e.parcels.length > 0)
        failed.add(e);
      if (e.status.toLowerCase() == "started" && e.parcels.length > 0)
        started.add(e);
      if (e.status.toLowerCase() == "arrived" && e.parcels.length > 0)
        arrived.add(e);
      if (e.status.toLowerCase() == "waiting" && e.parcels.length > 0)
        waiting.add(e);
    });

    return AcceptDelivery(
      id: id,
      pending: pending,
      completed: completed,
      failed: failed,
      started: started,
      arrived: arrived,
      waiting: waiting,
    );
  }

  @override
  Future<List<Delivery>> endDelivery(String id) async {
    try {
      final response = await api.patch(
        body: {},
        endpoint: "deliveries/$id/complete",
      );

      if (response.status != "success") {
        throw RequestFailure("Delivery not found!");
      }

      return list.where((element) {
        return element.id != id;
      }).toList();
    } catch (e) {
      throw NetworkFailure("Can't complete delivery!");
    }
  }

  @override
  Future<AcceptDelivery> retryDelivery(Destination destination) async {
    try {
      final body = {
        "parcels": destination.parcels.map((e) => e.id.toString()).toList(),
        "type": "RetryDelivery",
        "comment": 'Rider is retrying to deliver the parcel.',
        "destinations": [destination.id],
        "status": 'Pending'
      };

      final response = await api.patch(
        body: body,
        endpoint: "deliveries/${this.acceptedDelivery.id}/retry",
      );

      if (response.status != "success") {
        throw RequestFailure("Failed to retry delivery!");
      }

      this.acceptedDelivery.pending.insert(0, destination);

      this.acceptedDelivery.failed.forEachIndexed((index, element) {
        if (element.id == destination.id) {
          this.acceptedDelivery.failed.removeAt(index);
        }
      });

      this.acceptedDelivery.waiting.forEachIndexed((index, element) {
        if (element.id == destination.id) {
          this.acceptedDelivery.waiting.removeAt(index);
        }
      });

      return this.acceptedDelivery;
    } catch (e) {
      throw NetworkFailure("Can't retry delivery!");
    }
  }

  @override
  launchMap() async {
    await this.locService.init();
    LatLng origin = await this.locService.getCurrentLocation();

    return this.dirService.launchGoogleMap(
          origin: origin,
          waypoints: waypoints,
          destination: LatLng(end.coordinates[1], end.coordinates[0]),
        );
  }

  @override
  List<Delivery> getDeliveries() {
    return list;
  }

  @override
  Future<AcceptDelivery> addCompletedDelivery(
    Destination destination,
    File image,
  ) async {
    final response = await api.postFile(image: image);

    if (response.status != "success") throw RequestFailure(response.message);

    await updateParcelTracking(
      destination: destination,
      type: 'Delivered',
      comment: 'Parcel successfully Delivered.',
      image: response.data[0]['image'],
    );

    this.acceptedDelivery.completed.add(destination);
    updatePendingWaitingLists(destination.id);

    return this.acceptedDelivery;
  }

  @override
  Future<AcceptDelivery> addFailedDelivery(Destination destination) async {
    final isPickup = destination.status.toLowerCase().contains("pickup");
    await updateParcelTracking(
      destination: destination,
      type: isPickup ? 'NotPickup' : 'NotDelivered',
      comment: 'Parcel was not ${isPickup ? 'pickup' : 'deliver'}.',
    );

    this.acceptedDelivery.failed.add(destination);
    updatePendingWaitingLists(destination.id);

    return this.acceptedDelivery;
  }

  @override
  Future<AcceptDelivery> finishPickup(Destination destination) async {
    final myDestination = destinations
        .where((e) {
          return destination.id == e.id;
        })
        .toList()[0]
        .filterParcelsStatus(RIDER_NOT_PICKUP);

    await updateParcelTracking(
      destination: myDestination,
      type: RIDER_PICKUP,
      comment: 'Rider picked up at ${destination.address}.',
    );

    this.acceptedDelivery.completed.add(myDestination);
    updatePendingWaitingLists(destination.id);

    return this.acceptedDelivery;
  }

  @override
  Future<Response> updateParcelTracking({
    required String type,
    required String comment,
    required Destination destination,
    String from = "",
    String to = "",
    String image = "",
  }) async {
    final body = {
      "parcels": destination.parcels.map((e) => e.id.toString()).toList(),
      "type": type,
      "comment": comment,
      "image": image
    };

    final response = await api.patch(
      body: body,
      endpoint: "parcels/tracking",
    );

    if (response.status != "success") {
      throw RequestFailure("Update parcel tracking failed!");
    }

    return response;
  }

  @override
  Future<Response> updateSingleParcel({
    required String type,
    required String comment,
    required String parcel,
    String from = "",
    String to = "",
    String image = "",
  }) async {
    final body = {"type": type, "comment": comment, "image": image};

    final response = await api.patch(
      body: body,
      endpoint: "parcels/$parcel/tracking",
    );

    if (response.status != "success") {
      throw RequestFailure("Update parcel tracking failed!");
    }

    return response;
  }

  @override
  Future<Response> pickupParcel(Parcel parcel) async {
    if (parcel.image == null) throw RequestFailure("Parcel has no image");

    final uploadRes = await api.postFile(image: parcel.image ?? File(""));

    if (uploadRes.status != "success") throw RequestFailure(uploadRes.message);
    Response response = await updateSingleParcel(
      type: RIDER_ACCEPT_ITEM,
      comment: 'Rider accepted parcel ${parcel.refNum}.',
      parcel: parcel.id,
      image: uploadRes.data[0]["image"],
    );

    return response;
  }

  @override
  Future<AcceptDelivery> cancelPickup(List<Parcel> parcels) async {
    final myParcels = parcels.map((parcel) => parcel.id.toString()).toList();
    Map<String, dynamic> body = {
      "type": RIDER_NOT_PICKUP,
      "parcels": myParcels,
      "comment": "Rider did not pickup the parcel.",
    };

    Response response = await api.patch(
      body: body,
      endpoint: "deliveries/${this.acceptedDelivery.id}/cancel-pickup",
    );

    if (response.status != "success") {
      throw RequestFailure("Cancel parcel tracking failed!");
    }

    Delivery delivery = Delivery.fromJson(response.data[0]);
    this.acceptedDelivery = parseAcceptedDelivery(
      delivery: delivery.updateDestParcelStatus(myParcels, RIDER_NOT_PICKUP),
      id: this.acceptedDelivery.id,
    );
    return this.acceptedDelivery;
  }

  @override
  Future<Response> updateDestinationStatus({
    required List<String> destinations,
    required String status,
    required String id,
  }) async {
    final body = {"destinations": destinations, "status": status};

    final response = await api.patch(
      body: body,
      endpoint: "deliveries/$id/destinations",
    );

    if (response.status != "success") {
      throw RequestFailure("Update destination status failed!");
    }

    return response;
  }

  void updatePendingWaitingLists(String id) {
    this.acceptedDelivery.pending.forEachIndexed((index, element) {
      if (element.id == id) this.acceptedDelivery.pending.removeAt(index);
    });

    this.acceptedDelivery.waiting.forEachIndexed((index, element) {
      if (element.id == id) this.acceptedDelivery.waiting.removeAt(index);
    });

    this.acceptedDelivery.arrived.forEachIndexed((index, element) {
      if (element.id == id) this.acceptedDelivery.arrived.removeAt(index);
    });

    this.acceptedDelivery.started.forEachIndexed((index, element) {
      if (element.id == id) this.acceptedDelivery.started.removeAt(index);
    });
  }

  @override
  Future<List> getRiderDeliveries() async {
    try {
      final token = localStorage.getParseToken();
      final response = await api.get(
        endpoint: 'deliveries?rider=${token['_id']}',
      );

      if (response.status != "success")
        throw RequestFailure("Update destination status failed!");

      if (response.data.length == 0 || response.data[0] == null) {
        return [];
      }

      return response.data;
    } catch (e) {
      throw NetworkFailure("Can't find user credentials!");
    }
  }
}
