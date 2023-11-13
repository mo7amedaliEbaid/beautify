import 'package:beautify/configs/app_dimensions.dart';
import 'package:beautify/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:badges/badges.dart' as badges;
import 'package:provider/provider.dart';
import '../../model/tools/jsonparse/product_parse.dart';
import '../../viewmodel/profile/profile.dart';
import '../homescreen/homedetails_screen/detail_screen.dart';
import 'favouritebadge_widget.dart';
import 'networkimage_widget.dart';

class HomeProductView extends StatelessWidget {
  const HomeProductView(
      {Key? key, required this.product, required this.profileFunctions})
      : super(key: key);

  final ProductEntity product;
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
            position: badges.BadgePosition.custom(end: 0, top: 0),
            badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
            badgeContent: FavoriteBadge(
              product: product,
              badgeBackgroundColor: Colors.green,
              activeColor: Colors.red,
              inActive: Colors.white,
            ),
            child: Column(
              children: [
                SizedBox(
                    width: AppDimensions.normalize(50),
                    height: AppDimensions.normalize(50),
                    child: networkImage(imageUrl: product.imageUrl)),
                Space.y!,
                Text(
                  product.name.split("Maybelline").last.substring(0, 7),
                ),
                Space.y!,
                Text(
                  "€${product.price}",
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
