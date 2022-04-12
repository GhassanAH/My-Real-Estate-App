import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/homeWidget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var loading = false;

  Widget build(BuildContext context) {
    return HomeWidget();
  }
}
