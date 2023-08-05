import 'package:beautify/view/widgets/shopproduct_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:beautify/configs/configs.dart';
import '../../model/tools/entities/entities.dart';
import '../../model/tools/jsonparse/product_parse.dart';

class ProductGrideView extends StatelessWidget {
  const ProductGrideView({
    Key? key,
    required this.productList,
    required this.uiDuplicate,
  }) : super(key: key);

  final List<ProductEntity> productList;
  final UiDuplicate uiDuplicate;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.mediaQuery.size.width,
      height: Get.mediaQuery.size.height,
      child: GridView.builder(
        scrollDirection: Axis.vertical,
        itemCount: productList.length,
        physics: uiDuplicate.defaultScroll,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: .7,
            crossAxisCount: 3,
            crossAxisSpacing: AppDimensions.normalize(2),
            mainAxisSpacing: AppDimensions.normalize(2)),
        itemBuilder: (context, index) {
          return Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppDimensions.normalize(2))),
            child: ShopProductView(
              product: productList[index],
            ),
          );
        },
      ),
    );
  }
}
