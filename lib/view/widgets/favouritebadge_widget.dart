import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../model/controllers/profile_controller.dart';
import '../../model/tools/jsonparse/product_parse.dart';


class FavoriteBadge extends StatefulWidget {
  const FavoriteBadge(
      {super.key,
        required this.product,
        required this.badgeBackgroundColor,
        required this.activeColor,
        required this.inActive});
  final ProductEntity product;
  final Color badgeBackgroundColor;
  final Color activeColor;
  final Color inActive;
  @override
  State<FavoriteBadge> createState() => _FavoriteBadgeState();
}

class _FavoriteBadgeState extends State<FavoriteBadge> {
  @override
  Widget build(BuildContext context) {
    final profileFunctions = Get.find<ProfileController>().profileFunctions;
    final isInBox =
    profileFunctions.isInFavoriteBox(productEntity: widget.product);
    return SizedBox(
      width: 20,
      height: 20,
      child: CircleAvatar(
        backgroundColor: widget.badgeBackgroundColor,
        child: GestureDetector(
          onTap: () async {
            if (isInBox) {
              profileFunctions.removeFavorite(productEntity: widget.product);
              setState(() {});
            } else {
              await profileFunctions.addToFavorite(
                  productEntity: widget.product);
              setState(() {});
            }
          },
          child: isInBox
              ? Icon(
            CupertinoIcons.heart_fill,
            size: 20,
            color: widget.activeColor,
          )
              : Icon(
            CupertinoIcons.heart,
            color: widget.inActive,
            size: 20,
          ),
        ),
      ),
    );
  }
}