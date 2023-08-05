import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart'as badges;

import '../../model/controllers/duplicate_controller.dart';
class CartLengthBadge extends StatelessWidget {
  const CartLengthBadge({
    Key? key,
    required this.duplicateController,
 //   required this.colors,
   // required this.textStyle,
    required this.badgeCallback,
  }) : super(key: key);

  final DuplicateController duplicateController;
//  final CustomColors colors;
//  final CustomTextStyle textStyle;
  final GestureTapCallback badgeCallback;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: duplicateController.cartBoxListenable,
      builder: (context, value, child) {
        return badges.Badge(
          badgeStyle: badges.BadgeStyle(/*badgeColor: colors.primary*/),
          //  badgeColor: colors.primary,
             position:  badges.BadgePosition.custom(bottom: 5, end: 10),//BadgePosition(bottom: 5, end: 10),
          badgeContent: Container(
            alignment: Alignment.center,
            decoration:
            BoxDecoration(shape: BoxShape.circle, /*color: colors.primary*/),
            child: Text(
              value.values.length.toString(),
              //style: textStyle.bodySmall.copyWith(color: colors.whiteColor),
            ),
          ),
          child: CupertinoButton(
            onPressed: badgeCallback,
            child: Icon(
              CupertinoIcons.bag,
              //color: colors.blackColor,
            ),
          ),
        );
      },
    );
  }
}
