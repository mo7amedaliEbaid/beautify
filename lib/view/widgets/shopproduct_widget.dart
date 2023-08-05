import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:badges/badges.dart'as badges;

import '../../model/tools/colors/color.dart';
import '../../model/tools/fonts/font.dart';
import '../../model/tools/jsonparse/product_parse.dart';
import '../homescreen/homedetails_screen/detail_screen.dart';
import 'favouritebadge_widget.dart';
import 'networkimage_widget.dart';
class ShopProductView extends StatelessWidget {
  const ShopProductView({
    Key? key,
    required this.product,
 //   required this.textStyle,
   // required this.colors,
  }) : super(key: key);

  final ProductEntity product;
  //final CustomTextStyle textStyle;
  //final CustomColors colors;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        Get.to(DetailScreen(productEntity: product));
      },
      child: badges.Badge(
        badgeStyle: badges.BadgeStyle(/*badgeColor: colors.whiteColor*/),
        //badgeColor: colors.whiteColor,
        position: badges.BadgePosition.custom(top: 0, end: 0),
        // position: const BadgePosition(top: 0, end: 0),
        badgeContent: FavoriteBadge(
          product: product,
          badgeBackgroundColor: Colors.white,
          activeColor: Colors.white,
          inActive: Colors.white,
        ),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            SizedBox(
                width: 100,
                height: 100,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: networkImage(imageUrl: product.imageUrl))),
            const SizedBox(
              height: 5,
            ),
            Text(
              product.name.split("Maybelline").last.substring(0, 7),
            //  style: textStyle.bodyNormal.copyWith(color: colors.whiteColor),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              "€${product.price}",
            //  style: textStyle.bodyNormal.copyWith(color: colors.whiteColor),
            )
          ],
        ),
      ),
    );
  }
}
