import 'package:flutter/material.dart';

Widget buildAuthApi({BuildContext context, String text}) {
  return Row(children: [
    Container(
        padding: EdgeInsets.only(left: 40, right: 125),
        child: Text(
          text,
          style: Theme.of(context).textTheme.bodyText1,
        )),
    //google logo
    GestureDetector(
      child: Container(
        padding: EdgeInsets.only(right: 5),
        width: 30,
        height: 30,
        child: Image.asset('assets/images/google-logo.png'),
      ),
      onTap: () {},
    ),
    //facebook logo
    GestureDetector(
      child: Container(
        padding: EdgeInsets.only(right: 5),
        width: 30,
        height: 30,
        child: Image.asset('assets/images/facebook-logo.png'),
      ),
      onTap: () {},
    ),
    //twitter logo
    GestureDetector(
      child: Container(
        padding: EdgeInsets.only(right: 5),
        width: 30,
        height: 30,
        child: Image.asset('assets/images/twitter-logo.png'),
      ),
      onTap: () {},
    ),
  ]);
}
