import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Model/tools/Color/color.dart';
Widget duplicateContainer(
    {required CustomColors colors, required Widget child}) {
  return Container(
    width: Get.mediaQuery.size.width,
    margin: const EdgeInsets.only(top: 30),
    decoration: BoxDecoration(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
        color: colors.whiteColor),
    child: child,
  );
}