import 'package:flutter/material.dart';
import 'package:letify/utils/theme.dart';

class LetifyCircularProgressIndicator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(letifyGreen),
      ),
    );
  }
}
