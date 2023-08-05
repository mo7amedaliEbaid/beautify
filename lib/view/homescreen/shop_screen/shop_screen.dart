import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../model/controllers/duplicate_controller.dart';
import '../../../model/tools/jsonparse/product_parse.dart';
import '../../widgets/gridviewcontainer_widget.dart';
import '../../widgets/productgrid_widget.dart';

class ShopScreen extends StatelessWidget {
  const ShopScreen({
    super.key,
    required this.title,
    required this.productList,
  });
  final String title;
  final List<ProductEntity> productList;

  @override
  Widget build(BuildContext context) {
    final DuplicateController duplicateController =
        Get.find<DuplicateController>();
    final colors = duplicateController.colors;
    final textStyle = duplicateController.textStyle;
    final uiDuplicate = duplicateController.uiDuplicate;
    return Scaffold(
      appBar: AppBar(
     //   foregroundColor: colors.whiteColor,
     //   backgroundColor: colors.blackColor,
        centerTitle: true,
        title: Text(
          title,
       //   style: textStyle.titleLarge.copyWith(color: colors.whiteColor),
        ),
      ),
     // backgroundColor: colors.blackColor,
      body: gridViewScreensContainer(
        colors: colors,
        child: ProductGrideView(
            productList: productList,
            uiDuplicate: uiDuplicate,
            colors: colors,
            textStyle: textStyle),
      ),
    );
  }
}
