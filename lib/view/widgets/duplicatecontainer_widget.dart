import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:beautify/configs/configs.dart';
Widget duplicateContainer(
    {required Widget child}) {
  return Container(
    width: Get.mediaQuery.size.width,
    margin:  EdgeInsets.only(top: AppDimensions.normalize(2)),
    decoration: BoxDecoration(
        borderRadius:  BorderRadius.vertical(top: Radius.circular(AppDimensions.normalize(5))),
     ),
    child: child,
  );
}