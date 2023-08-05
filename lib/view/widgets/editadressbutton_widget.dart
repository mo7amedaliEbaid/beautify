import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/tools/colors/color.dart';
import '../../model/tools/fonts/font.dart';



Widget addressEditButton(
    {required GestureTapCallback callback,
      required CustomColors colors,
      required CustomTextStyle textStyle}) {
  return CupertinoButton(
      onPressed: callback,
      child: Icon(
        CupertinoIcons.pencil,
     //   color: colors.blackColor,
        size: 24,
      ));
}