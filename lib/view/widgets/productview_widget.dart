import 'package:auto_size_text/auto_size_text.dart';
import 'package:beautify/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:provider/provider.dart';

import '../../model/tools/jsonparse/product_parse.dart';
import '../homescreen/homedetails_screen/detail_screen.dart';
import 'networkimage_widget.dart';
class HorizontalProductView extends StatelessWidget {
  const HorizontalProductView({
    Key? key,
    required this.product,
    required this.widget,
    required this.margin,
  }) : super(key: key);

  final ProductEntity product;
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
        padding: Space.all(.2,.2),
        decoration: BoxDecoration(
          color:Color(0xffbbd591),
     borderRadius: BorderRadius.circular(AppDimensions.normalize(7))),
        child: Row(
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(AppDimensions.normalize(5)),
                child: SizedBox(
                    width: AppDimensions.normalize(40),
                    height:AppDimensions.normalize(40),
                    child: networkImage(imageUrl: product.imageUrl))),
            Space.x1!,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: AppDimensions.normalize(90),
                  child: AutoSizeText(
                    product.name,
                    style: AppText.b1b,
                    overflow: TextOverflow.clip,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                SizedBox(
                  width: AppDimensions.normalize(85),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            product.productType,
                          ),
                          Space.y!,
                          Text(
                            "€${product.price}",
                       style: AppText.b1b,
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
