import 'dart:ui';

import 'package:bright_kid/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class MyLoader extends StatefulWidget {
  @override
  MyLoaderState createState() => MyLoaderState();
}

class MyLoaderState extends State<MyLoader> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
          child: spinkit,
        ),
      ),
    );
  }

  final spinkit = SpinKitCubeGrid(
    color: themeColor,
    size: 50.0,
  );
}
