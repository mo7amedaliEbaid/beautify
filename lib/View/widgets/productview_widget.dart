import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


import '../../Model/tools/Color/color.dart';
import '../../Model/tools/Font/font.dart';
import '../../Model/tools/JsonParse/product_parse.dart';
import '../../View/HomeScreen/HomeDetailScreen/detail_screen.dart';
import 'networkimage_widget.dart';
class HorizontalProductView extends StatelessWidget {
  const HorizontalProductView({
    Key? key,
    required this.colors,
    required this.product,
    required this.textStyle,
    required this.widget,
    required this.margin,
  }) : super(key: key);

  final CustomColors colors;
  final ProductEntity product;
  final CustomTextStyle textStyle;
  final Widget widget;
  final EdgeInsetsGeometry margin;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(DetailScreen(productEntity: product));
      },
      child: Container(
        margin: margin,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: colors.blackColor, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: SizedBox(
                    width: 100,
                    height: 100,
                    child: networkImage(imageUrl: product.imageUrl))),
            const SizedBox(
              width: 20,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: Get.mediaQuery.size.width * 0.57,
                  child: Text(
                    product.name,
                    style: textStyle.bodyNormal.copyWith(
                        fontWeight: FontWeight.bold, color: colors.whiteColor),
                    overflow: TextOverflow.clip,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: Get.mediaQuery.size.width * 0.55,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            product.productType,
                            style: textStyle.bodyNormal
                                .copyWith(color: colors.whiteColor),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "€${product.price}",
                            style: textStyle.bodyNormal.copyWith(
                                color: colors.whiteColor,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      widget
                    ],
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
