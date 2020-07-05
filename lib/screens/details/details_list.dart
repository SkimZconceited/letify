import 'package:flutter/material.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/models/house.dart';
import 'package:letify/screens/details/host.dart';
import 'package:letify/screens/details/media.dart';
import 'package:letify/screens/details/name_and_location.dart';
import 'package:letify/screens/details/reviews.dart';
import 'package:letify/services/blocs/homes_provider.dart';
import 'package:letify/services/blocs/user_provider.dart';
import 'package:letify/utils/theme.dart';

class DetailsList extends StatefulWidget {
  final Apartment apartment;
  final House house;
  DetailsList({this.apartment, this.house});

  @override
  _DetailsListState createState() => _DetailsListState();
}

class _DetailsListState extends State<DetailsList> {
  @override
  Widget build(BuildContext context) {
    //blocs
    final userBloc = UserProvider.of(context);
    final homeBloc = HomesProvider.of(context);

    //amenities
    List amenities;
    amenities = widget.apartment == null
        ? widget.house.amenities
        : widget.apartment.amenities;
    List<Widget> amenityWidget = amenities.map((amenity) {
      return Container(
        width: 100,
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.only(right: 5),
              width: 10,
              height: 10,
              decoration:
                  BoxDecoration(color: letifyGreen, shape: BoxShape.circle),
            ),
            Expanded(child: Text(amenity)),
          ],
        ),
      );
    }).toList();

    return SliverList(
      delegate: SliverChildListDelegate(
        <Widget>[
          //home name and location
          HomeAndLocation(
            apartment: widget.apartment,
            house: widget.house,
          ),
          //vidz and pics
          Media(
            apartment: widget.apartment,
            house: widget.house,
          ),
          //host
          Host(
            apartment: widget.apartment,
            house: widget.house,
            userBloc: userBloc,
          ),
          //bathroom and bedroom
          _buildBathroomAndBedroom(),
          //amenities
          _buildAmenities(amenityWidget),
          //reviews
          HomeReviews(
            apartment: widget.apartment,
            house: widget.house,
            userBloc: userBloc,
            homeBloc: homeBloc,
          ),
          //availability
          _buildAvailability(),
        ],
      ),
    );
  }

  //bathroom and bedroom function
  Widget _buildBathroomAndBedroom() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 5),
      child: Row(
        children: [
          Text(widget.apartment == null
              ? '${widget.house.bedrooms} bedrooms'
              : '${widget.apartment.bedrooms} bedrooms'),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(Icons.hotel),
          ),
          SizedBox(
            width: 20,
          ),
          Text(widget.apartment == null
              ? '${widget.house.bathrooms} bathrooms'
              : '${widget.apartment.bathrooms} bathrooms'),
          Padding(
            padding: const EdgeInsets.only(left: 5),
            child: Icon(Icons.hot_tub),
          ),
        ],
      ),
    );
  }

  //amenities function builder
  Widget _buildAmenities(List<Widget> amenityWidget) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 18.0, top: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(bottom: 5),
            child: Text(
              'Amenities',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
          ),
          Wrap(
            direction: Axis.horizontal,
            children: amenityWidget,
          ),
        ],
      ),
    );
  }

  //availability builder function
  Widget _buildAvailability() {
    return Padding(
      padding: const EdgeInsets.only(left: 18.0, top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Availability ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3.0),
            child: Text(widget.apartment == null
                ? widget.house.available ? 'Available' : 'Unavailable'
                : widget.apartment.available ? 'Available' : 'Unavailable'),
          )
        ],
      ),
    );
  }
}
