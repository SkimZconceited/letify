import 'package:flutter/material.dart';
import 'package:letify/utils/theme.dart';

Widget buildAuthRow({BuildContext context, Function toggleView,String text1,String text2}) {
  return Row(
    children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 40),
        child: Text(
          text1,
          style: Theme.of(context).textTheme.bodyText1,
        ),
      ),
      SizedBox(
        width: 10,
      ),
      GestureDetector(
        child: Text(text2,
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                fontWeight: FontWeight.bold, fontSize: 15, color: letifyGreen)),
        onTap: toggleView,
      )
    ],
  );
}
