import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget addressEditButton({
  required GestureTapCallback callback,
}) {
  return CupertinoButton(
      onPressed: callback,
      child: Icon(
        CupertinoIcons.pencil,
        size: 24,
      ));
}
