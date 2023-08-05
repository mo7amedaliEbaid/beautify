import 'package:flutter/material.dart';
import 'package:beautify/configs/configs.dart';

Widget gridViewScreensContainer(
    {required Widget child}) {
  return Container(
    alignment: Alignment.center,
    margin: Space.all(1,1),
    decoration: BoxDecoration(
        borderRadius:  BorderRadius.vertical(top: Radius.circular(AppDimensions.normalize(2)))),
    child: child,
  );
}
