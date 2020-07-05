import 'package:flutter/material.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/models/house.dart';
import 'package:letify/utils/theme.dart';

class HomeCard extends StatelessWidget {
  final Apartment apartment;
  final House house;
  final bool doubleTap;
  final bool tap;
  HomeCard(
      {@required this.apartment,
      @required this.house,
      @required this.doubleTap,
      @required this.tap});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Material(
        elevation: 6,
        //margin: EdgeInsets.only(left: 9, right: 1)
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: 160,
                    height: 109,
                    child: Image.network(
                      apartment == null ? house.images[0] : apartment.images[0],
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: Stack(
                      children: [
                        Positioned(
                          top: 7,
                          left: 8.7,
                          child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                  color: letifyWhite, shape: BoxShape.circle)),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                            color: letifyPink,
                          ),
                          onPressed: null,
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Container(
                padding: EdgeInsets.only(
                  left: 5,
                  top: 8,
                  right: 5,
                  bottom: 2,
                ),
                child: Row(
                  children: [
                    Text(
                      apartment == null ? 'House' : 'Apartment',
                      style: TextStyle(color: Colors.black45),
                    ),
                    apartment == null
                        ? SizedBox(width: 80)
                        : SizedBox(width: 59),
                    Icon(
                      Icons.star,
                      color: letifyPink,
                      size: 14,
                    ),
                    Text(
                      apartment == null
                          ? house.reviews['ratings'].toString()
                          : apartment.reviews['ratings'].toString(),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 2, left: 5),
                child: Text(
                  apartment == null
                      ? house.location['district']
                      : apartment.location['district'],
                  style: TextStyle(color: Colors.black45),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 0, left: 5),
                child: Text(
                  apartment == null ? house.name : apartment.name,
                  // style: TextStyle(color: Colors.black87),
                ),
              )
            ],
          ),
          onDoubleTap: doubleTap
              ? () {
                  Navigator.pushNamed(context, 'player',
                      arguments: apartment == null ? house : apartment);
                }
              : null,
          onTap: tap
              ? () {
                  Navigator.pushNamed(context, 'detailsScreen',
                      arguments: apartment == null ? house : apartment);
                }
              : null,
        ),
      ),
      margin: EdgeInsets.only(top: 3, bottom: 5, left: 9, right: 1),
    );
  }
}
