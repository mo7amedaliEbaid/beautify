import 'package:beautify/configs/app_dimensions.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:beautify/configs/configs.dart';
import '../../../model/controllers/duplicate_controller.dart';
import '../../../model/tools/jsonparse/product_parse.dart';
import '../../widgets/duplicatetempelate_widget.dart';
import '../../widgets/networkimage_widget.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.productList});
  final List<ProductEntity> productList;
  @override
  Widget build(BuildContext context) {
    final duplicateController = Get.find<DuplicateController>();
    return DuplicateTemplate(
      title: "Order detail",
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height:AppDimensions.normalize(250),
            margin:
               Space.all(1.5,1.5),
            child: AlignedGridView.count(
              physics: duplicateController.uiDuplicate.defaultScroll,
              crossAxisCount: 2,
              mainAxisSpacing: AppDimensions.normalize(2),
              crossAxisSpacing: AppDimensions.normalize(2),
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Container(
                  height: AppDimensions.normalize(90),
                  child: Column(
                    children: [
                      Container(
                          margin: Space.v,
                          width:  AppDimensions.normalize(47),
                          child: networkImage(imageUrl: product.imageUrl)),
                      Column(
                        children: [
                          Text(
                            product.name,
                           style: AppText.b1b,
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            textAlign: TextAlign.center,
                          ),
                         Space.y!,
                          Text(
                            "€${product.price}",
                            style: AppText.h3b,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
