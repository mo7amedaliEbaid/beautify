import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Model/tools/Color/color.dart';
import '../../Model/tools/Font/font.dart';

Widget addressEditButton(
    {required GestureTapCallback callback,
      required CustomColors colors,
      required CustomTextStyle textStyle}) {
  return CupertinoButton(
      onPressed: callback,
      child: Icon(
        CupertinoIcons.pencil,
        color: colors.blackColor,
        size: 24,
      ));
}