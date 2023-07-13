import 'package:flutter/material.dart';

import '../../model/tools/colors/color.dart';

Widget gridViewScreensContainer(
    {required Widget child, required CustomColors colors}) {
  return Container(
    alignment: Alignment.center,
    margin: const EdgeInsets.only(top: 30),
    padding: const EdgeInsets.all(15),
    decoration: BoxDecoration(
        color: colors.whiteColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(15))),
    child: child,
  );
}
