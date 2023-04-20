import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final Color color;
  const CustomText({Key? key, required this.text, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return   Text(text,style:  TextStyle(fontSize: 14.0,fontWeight:FontWeight.bold,color: color),);
  }
}
