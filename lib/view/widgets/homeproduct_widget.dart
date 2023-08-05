import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:badges/badges.dart'as badges;


import '../../model/tools/colors/color.dart';
import '../../model/tools/fonts/font.dart';
import '../../model/tools/jsonparse/product_parse.dart';
import '../../viewmodel/profile/profile.dart';
import '../homescreen/homedetails_screen/detail_screen.dart';
import 'favouritebadge_widget.dart';
import 'networkimage_widget.dart';
class HomeProductView extends StatelessWidget {
  const HomeProductView(
      {Key? key,
        required this.product,
    //    required this.textStyle,
      //  required this.colors,
        required this.profileFunctions})
      : super(key: key);

  final ProductEntity product;
 // final CustomTextStyle textStyle;
  //final CustomColors colors;
  final ProfileFunctions profileFunctions;
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: profileFunctions.favoriteListenable(),
      builder: (context, value, child) {
        return InkWell(
          onTap: () {
            Get.to(DetailScreen(productEntity: product));
          },
          child: badges.Badge(
                position: badges.BadgePosition.custom(end: 0, top: 0), //BadgePosition(end: 0, top: 0),
            badgeStyle: badges.BadgeStyle(/*badgeColor:colors.blackColor */),
            //  badgeColor: colors.blackColor,

            badgeContent: FavoriteBadge(
              product: product,
              badgeBackgroundColor: Colors.white,
              activeColor: Colors.black54,
              inActive:Colors.white
            ),
            child: Column(
              children: [
                SizedBox(
                    width: 100,
                    height: 100,
                    child: networkImage(imageUrl: product.imageUrl)),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  product.name.split("Maybelline").last.substring(0, 7),
                //  style: textStyle.bodyNormal,
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  "€${product.price}",
               //   style: textStyle.bodyNormal,
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
