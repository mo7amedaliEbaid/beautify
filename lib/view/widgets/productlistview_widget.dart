import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/tools/jsonparse/product_parse.dart';
import '../../viewmodel/profile/profile.dart';
import 'homeproduct_widget.dart';
import 'package:beautify/configs/configs.dart';
class ProductListView extends StatelessWidget {
  const ProductListView(
      {super.key,
        required this.productList,
        required this.title,
        required this.physics,
        required this.reverse,
        required this.callback,
        required this.profileFunctions});
  final List<ProductEntity> productList;
  final String title;
  final ScrollPhysics physics;
  final bool reverse;
  final GestureTapCallback callback;
  final ProfileFunctions profileFunctions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: Space.all(1,1),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  width: AppDimensions.normalize(20),
                  height: AppDimensions.normalize(8),
                  child: AutoSizeText(
                    title,
                    style: AppText.h2,
                    ),
                  ),
                ),
            //  ),
              CupertinoButton(
                onPressed: callback,
                child: Row(
                  children: [
                    Text(
                      "See all",
                    ),
                    Icon(
                      Icons.keyboard_double_arrow_right,
                    ),
                  ],
                ),
              )
            ],
          ),
           Space.y!,
          SizedBox(
            height: AppDimensions.normalize(70),
            child: ListView.builder(
              reverse: reverse,
              physics: physics,
              scrollDirection: Axis.horizontal,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Padding(
                  padding: Space.h!,
                  child: HomeProductView(
                    profileFunctions: profileFunctions,
                    product: product,
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
