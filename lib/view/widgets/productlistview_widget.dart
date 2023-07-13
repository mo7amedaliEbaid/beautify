import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/tools/colors/color.dart';
import '../../model/tools/fonts/font.dart';
import '../../model/tools/jsonparse/product_parse.dart';
import '../../viewmodel/profile/profile.dart';
import 'homeproduct_widget.dart';
class ProductListView extends StatelessWidget {
  const ProductListView(
      {super.key,
        required this.colors,
        required this.textStyle,
        required this.productList,
        required this.title,
        required this.physics,
        required this.reverse,
        required this.callback,
        required this.profileFunctions});
  final CustomColors colors;
  final CustomTextStyle textStyle;
  final List<ProductEntity> productList;
  final String title;
  final ScrollPhysics physics;
  final bool reverse;
  final GestureTapCallback callback;
  final ProfileFunctions profileFunctions;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Container(
                  width: 200,
                  height: 30,
                  child: AutoSizeText(
                    title,
                    style: textStyle.titleLarge.copyWith(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              CupertinoButton(
                onPressed: callback,
                child: Row(
                  children: [
                    Text(
                      "See all",
                      style:
                      textStyle.bodyNormal.copyWith(color: colors.primary),
                    ),
                    Icon(
                      Icons.keyboard_double_arrow_right,
                      color: colors.primary,
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              reverse: reverse,
              physics: physics,
              scrollDirection: Axis.horizontal,
              itemCount: productList.length,
              itemBuilder: (context, index) {
                final product = productList[index];
                return Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: HomeProductView(
                    profileFunctions: profileFunctions,
                    product: product,
                    textStyle: textStyle,
                    colors: colors,
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
