import 'package:flutter/material.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/data/models/destination.model.dart';

void onTapped() {}

class DestinationCard extends StatelessWidget {
  final String title;
  final Destination destination;
  final Color borderColor;
  final Color titleColor;
  final Color cardColor;
  final Color distanceColor;
  final Color nameColor;
  final Color addressColor;
  final Color countColor;
  final Color paymentIconColor;
  final Color carIconColor;
  final void Function() onTap;

  DestinationCard({
    this.title = "",
    this.borderColor = TEXT_LIGHT,
    this.titleColor = NEUTRAL_PRIMARY_NORMAL,
    this.cardColor = TEXT_LIGHT,
    this.distanceColor = NEUTRAL_PRIMARY_NORMAL,
    this.nameColor = NEUTRAL_PRIMARY_DARK,
    this.addressColor = NEUTRAL_PRIMARY_NORMAL,
    this.countColor = NEUTRAL_PRIMARY_DARK,
    this.paymentIconColor = PRIMARY,
    this.carIconColor = Colors.blueGrey,
    this.onTap = onTapped,
    required this.destination,
  });

  @override
  Widget build(BuildContext context) {
    String toBe = " to be ";
    if (title.toLowerCase().contains("complete")) toBe = " has been ";
    if (title.toLowerCase().contains("fail"))
      toBe = " ${destination.parcels.length > 1 ? 'are' : 'was'} not ";

    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: cardColor,
        shape: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: borderColor, width: 2.5),
        ),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
          alignment: Alignment(0.0, -0.79),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: titleColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      destination.eta,
                      style: TextStyle(
                        color: distanceColor,
                        fontWeight: FontWeight.w800,
                        fontSize: 13,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 3),
                child: Text(
                  destination.name,
                  style: TextStyle(
                    color: nameColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                destination.address,
                style: TextStyle(
                  color: addressColor,
                  fontSize: 14,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Row(
                  children: [
                    Text(
                      "${destination.parcels.length} item${destination.parcels.length > 1 ? 's' : ''}",
                      style: TextStyle(
                        color: countColor,
                        fontWeight: FontWeight.w900,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      toBe,
                      style: TextStyle(
                        color: addressColor,
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      "${destination.type.toLowerCase().contains('ship') ? 'deliver' : 'pickup'}${title == "PENDING" || title.contains("ACTIVE") ? "" : "ed"}",
                      style: TextStyle(
                          color: countColor,
                          fontWeight: FontWeight.w900,
                          fontSize: 14),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 3),
                child: Row(
                  children: [
                    Icon(
                      Icons.payments_outlined,
                      color: SECONDARY,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Text(
                        destination.payment,
                        style: TextStyle(
                          color: nameColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.local_shipping_outlined,
                      color: carIconColor,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OnGoingDestination extends DestinationCard {
  OnGoingDestination({
    required String title,
    required Destination destination,
    required void Function() onTap,
  }) : super(
          title: "ACTIVE ${title.toUpperCase()}",
          titleColor: SECONDARY,
          borderColor: SECONDARY,
          destination: destination,
          onTap: onTap,
        );
}

class PendingDestination extends DestinationCard {
  PendingDestination({required Destination destination})
      : super(
          title: "PENDING",
          destination: destination,
          cardColor: NEUTRAL_PRIMARY_ACCENT,
          borderColor: NEUTRAL_PRIMARY_BASE,
          titleColor: NEUTRAL_PRIMARY_BASE,
          distanceColor: NEUTRAL_PRIMARY_BASE,
          nameColor: NEUTRAL_PRIMARY_BASE,
          addressColor: NEUTRAL_PRIMARY_BASE,
          countColor: NEUTRAL_PRIMARY_BASE,
          paymentIconColor: Color.fromRGBO(200, 230, 201, 1),
          carIconColor: Color.fromRGBO(207, 216, 220, 1),
        );
}

class CompletedDestination extends DestinationCard {
  CompletedDestination({
    required Destination destination,
    required void Function() onTap,
  }) : super(
          title: "COMPLETED",
          titleColor: DARK,
          borderColor: DARK,
          destination: destination,
          onTap: onTap,
        );
}

class FailedDestination extends DestinationCard {
  FailedDestination({
    required Destination destination,
    required void Function() onTap,
  }) : super(
          title: "FAILED",
          titleColor: RED,
          borderColor: RED,
          destination: destination,
          onTap: onTap,
        );
}
