import 'package:beautify/View/widgets/shopproduct_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Model/tools/Color/color.dart';
import '../../Model/tools/Entities/entities.dart';
import '../../Model/tools/Font/font.dart';
import '../../Model/tools/JsonParse/product_parse.dart';



class ProductGrideView extends StatelessWidget {
  const ProductGrideView({
    Key? key,
    required this.productList,
    required this.uiDuplicate,
    required this.colors,
    required this.textStyle,
  }) : super(key: key);

  final List<ProductEntity> productList;
  final UiDuplicate uiDuplicate;
  final CustomColors colors;
  final CustomTextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.mediaQuery.size.width,
      height: Get.mediaQuery.size.height,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: productList.length,
        physics: uiDuplicate.defaultScroll,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, crossAxisSpacing: 15, mainAxisSpacing: 15),
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: colors.captionColor,
                borderRadius: BorderRadius.circular(15)),
            child: ShopProductView(
              product: productList[index],
              textStyle: textStyle,
              colors: colors,
            ),
          );
        },
      ),
    );
  }
}
