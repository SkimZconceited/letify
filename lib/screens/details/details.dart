import 'package:flutter/material.dart';
import 'package:letify/models/apartment.dart';
import 'package:letify/models/house.dart';
import 'package:letify/models/reserve.dart';
import 'package:letify/models/user.dart';
import 'package:letify/screens/details/details_list.dart';
import 'package:letify/services/blocs/reserve_bloc.dart';
import 'package:letify/services/blocs/reserve_provider.dart';
import 'package:letify/services/blocs/user_provider.dart';
import 'package:letify/utils/theme.dart';

class DetailsScreen extends StatefulWidget {
  final Apartment apartment;
  final House house;
  DetailsScreen({@required this.apartment, @required this.house});

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  bool showMore = false;
  @override
  Widget build(BuildContext context) {
    final reserveBloc = ReserveProvider.of(context);
    final userBloc = UserProvider.of(context);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: letifyGreen,
            ),
            onPressed: () => Navigator.pop(context)),
        title: Text(
          'Details',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: CustomScrollView(
        shrinkWrap: true,
        slivers: [
          //details list
          DetailsList(
            apartment: widget.apartment,
            house: widget.house,
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNav(
          widget.apartment, widget.house, userBloc, reserveBloc),
    );
  }

  //build bottom nav
  Widget _buildBottomNav(Apartment apartment, House house, UserBloc userBloc,
      ReserveBloc reserveBloc) {
    return Material(
      color: Colors.grey[200],
      elevation: 20,
      child: Container(
          //padding: EdgeInsets.only(top: 5),
          height: 50,
          width: double.infinity,
          //color: Colors.green,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 18.0, top: 8, bottom: 3),
                    child: Text(
                      widget.apartment == null
                          ? 'Price: ${widget.house.price} Tsh/ month'
                          : 'Price: ${widget.apartment.price} Tsh/ month',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 18.0),
                    child: Text(
                      widget.apartment == null
                          ? 'Terms: ${widget.house.terms} month(s)'
                          : 'Terms: ${widget.apartment.terms} month(s)',
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(right: 12.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.0)),
                  color: letifyPink,
                  elevation: 6,
                  onPressed: () => _reserve(
                      home: apartment == null ? house : apartment,
                      reserveBloc: reserveBloc,
                      userBloc: userBloc),
                  child: Text(
                    'Reserve',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  //reserve home function
  void _reserve(
      {dynamic home, ReserveBloc reserveBloc, UserBloc userBloc}) async {
    Reserve reserve;
    User user = await userBloc.getCurrentUser();
    //check if its apart or house
    if (home is Apartment) {
      reserve = Reserve(uid: user.uid, category: 'apartment', homeId: home.uid);
    } else if (home is House) {
      reserve = Reserve(uid: user.uid, category: 'house', homeId: home.uid);
    }
    //reserve
    await reserveBloc.createReserve(reserve);
    //direct to reserve screen
    Navigator.pop(context);
    Navigator.pushNamed(context, '/reserve');
  }
}
