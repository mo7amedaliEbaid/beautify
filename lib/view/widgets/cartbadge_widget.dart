import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart'as badges;
import 'package:beautify/configs/configs.dart';
import '../../model/controllers/duplicate_controller.dart';
class CartLengthBadge extends StatelessWidget {
  const CartLengthBadge({
    Key? key,
    required this.duplicateController,
    required this.badgeCallback,
  }) : super(key: key);

  final DuplicateController duplicateController;
  final GestureTapCallback badgeCallback;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: duplicateController.cartBoxListenable,
      builder: (context, value, child) {
        return badges.Badge(
          badgeStyle: badges.BadgeStyle(badgeColor:Colors.greenAccent),
             position:  badges.BadgePosition.custom(bottom: -5, start: 2),
          badgeContent: Container(
            alignment: Alignment.center,
            decoration:
            BoxDecoration(shape: BoxShape.circle, color: Colors.greenAccent),
            child: Text(
              value.values.length.toString(),
              style: AppText.h2,
            ),
          ),
          child: CupertinoButton(
            onPressed: badgeCallback,
            child: Icon(
              CupertinoIcons.bag_fill,
              color: Colors.white,
            ),
          ),
        );
      },
    );
  }
}
