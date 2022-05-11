import 'package:flutter/material.dart';
import 'package:promdifarm_app/core/const/color.dart';
import 'package:promdifarm_app/data/models/destination.model.dart';

class DestinationDropdown extends StatelessWidget {
  final List<Destination> destinations;
  final bool alignedDropdown;

  DestinationDropdown({
    this.destinations = const [],
    this.alignedDropdown = true,
  });

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      alignedDropdown: alignedDropdown,
      child: Container(
        width: 600.0,
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: PRIMARY, width: 1.4),
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: DropdownButtonHideUnderline(
          child: DropdownButton(
            value: destinations.first,
            isExpanded: true,
            dropdownColor: TEXT_LIGHT,
            isDense: false,
            alignment: Alignment.centerRight,
            style: TextStyle(color: NEUTRAL_PRIMARY_NORMAL),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
            items: destinations
                .map<DropdownMenuItem<Destination>>(
                  (Destination value) => DropdownMenuItem<Destination>(
                    value: value,
                    child: Column(
                      children: [
                        Expanded(
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(.0),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    color: NEUTRAL_PRIMARY_NORMAL,
                                    size: 19,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    value.address,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
                .toList()
                .sublist(0, 3),
            onChanged: (dynamic value) {},
          ),
        ),
      ),
    );
  }
}
