import 'dart:io';
import 'package:promdifarm_app/data/models/index.dart';
import 'package:promdifarm_app/data/models/parcel/parcel.model.dart';

abstract class DeliverySource {
  static List<Delivery> list = [];
  Future<List<Delivery>> fetchAvailableDeliveries();
  List<Delivery> getDeliveries();
  Future<AcceptDelivery> acceptDelivery(String id);
  Future<AcceptDelivery> retryDelivery(Destination destination);
  Future<AcceptDelivery> getDelivery(String id);
  Future<bool> launchMap();
  Future<AcceptDelivery> addCompletedDelivery(
    Destination destination,
    File image,
  );
  Future<AcceptDelivery> addFailedDelivery(Destination destination);
  Future<AcceptDelivery> finishPickup(Destination destination);
  Future<Response> pickupParcel(Parcel parcel);
  Future<AcceptDelivery> cancelPickup(List<Parcel> parcels);
  Future<Response> updateParcelTracking({
    required String type,
    required String comment,
    required Destination destination,
    String from = "",
    String to = "",
  });
  Future<Response> updateSingleParcel({
    required String type,
    required String comment,
    required String parcel,
    String from = "",
    String to = "",
    String image = "",
  });
  AcceptDelivery getAcceptedDelivery();
  void setAcceptedDelivery(AcceptDelivery value);
  Future<Response> updateDestinationStatus({
    required List<String> destinations,
    required String status,
    required String id,
  });
  Future<List<Delivery>> endDelivery(String id);
  Future<List> getRiderDeliveries();
}
