import 'package:flutter/material.dart';
import 'package:letify/utils/theme.dart';

Widget buildIndicator() {
  return Center(
    child: CircularProgressIndicator(
      valueColor: AlwaysStoppedAnimation<Color>(letifyGreen),
    ),
  );
}
