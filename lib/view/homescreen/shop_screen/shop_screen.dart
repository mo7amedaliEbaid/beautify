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
    final uiDuplicate = duplicateController.uiDuplicate;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
        ),
      ),
      body: gridViewScreensContainer(
        child: ProductGrideView(
            productList: productList,
            uiDuplicate: uiDuplicate,
  ),
      ),
    );
  }
}
