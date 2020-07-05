import 'package:flutter/material.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/models/house.dart';
import 'package:letify/utils/theme.dart';

class HomeAndLocation extends StatelessWidget {
  final Apartment apartment;
  final House house;
  HomeAndLocation({this.apartment, this.house});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 18.0, top: 25, bottom: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            apartment == null
                ? house.name
                : apartment.building.isEmpty
                    ? apartment.name
                    : apartment.building['name'],
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          apartment != null
              ? Visibility(
                  visible: apartment.building.isEmpty ? false : true,
                  child: Text(
                    apartment.name,
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                  ))
              : SizedBox.shrink(),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.star,
                color: letifyPink,
                size: 19,
              ),
              Padding(
                padding: const EdgeInsets.only(right: 5.0),
                child: Text(
                    apartment == null
                        ? house.reviews['ratings'].toString()
                        : apartment.reviews['ratings'].toString(),
                    style: TextStyle(fontSize: 16)),
              ),
              Text(
                apartment == null
                    ? '${house.location['city']}, ${house.location['district']}, ${house.location['street']}'
                    : '${apartment.location['city']}, ${apartment.location['district']}, ${apartment.location['street']}',
                style: TextStyle(color: Colors.black87, fontSize: 16),
              ),
            ],
          )
        ],
      ),
    );
  }
}
