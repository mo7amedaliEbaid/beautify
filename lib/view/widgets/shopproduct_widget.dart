import 'package:beautify/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:badges/badges.dart'as badges;
import 'package:provider/provider.dart';

import '../../model/tools/jsonparse/product_parse.dart';
import '../homescreen/homedetails_screen/detail_screen.dart';
import 'favouritebadge_widget.dart';
import 'networkimage_widget.dart';
class ShopProductView extends StatelessWidget {
  const ShopProductView({
    Key? key,
    required this.product,
  }) : super(key: key);

  final ProductEntity product;
  @override
  Widget build(BuildContext context) {


    return InkWell(
      onTap: () async {
        Get.to(DetailScreen(productEntity: product));
      },
      child: badges.Badge(
        position: badges.BadgePosition.custom(end: 0, top: 0),
        badgeStyle: badges.BadgeStyle(badgeColor:Colors.red),
        badgeContent: FavoriteBadge(
          product: product,
          badgeBackgroundColor:Colors.green,
          activeColor: Colors.red,
          inActive:Colors.white,
        ),
        child: Column(
          children: [
            Space.y!,
            SizedBox(
                width: AppDimensions.normalize(40),
                height: AppDimensions.normalize(40),
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimensions.normalize(6),),
                    child: networkImage(imageUrl: product.imageUrl))),
            const SizedBox(
              height: 5,
            ),
            Text(
              product.name.split("Maybelline").last.substring(0, 7),
            ),
            Space.yf(.1),
            Text(
              "€${product.price}",
            )
          ],
        ),
      ),
    );
  }
}
