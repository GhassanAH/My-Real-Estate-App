import 'package:flutter/material.dart';


class HeaderCurveLinee extends CustomPainter {
  @override

  void paint(Canvas canvas,Size size){
    Paint paint = Paint()..color=Colors.blueAccent;
    Path path =Path()..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width/2, 255, size.width, 150)
      ..relativeLineTo(0, -150)..close();
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(CustomPainter oldDelegate)=> false;
}