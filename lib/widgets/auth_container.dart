import 'package:flutter/material.dart';

class AuthContainer extends StatelessWidget {
  final Alignment alignment;
  final EdgeInsets padding;
  final String text;
  final TextStyle style;
  AuthContainer({this.alignment, this.padding, this.style, this.text});
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      padding: padding,
      child: Text(
        text,
        style: style,
      ),
    );
  }
}
