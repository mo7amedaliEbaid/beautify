import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../model/tools/colors/color.dart';
import '../../model/tools/fonts/font.dart';
import '../../model/tools/jsonparse/product_parse.dart';
import 'networkimage_widget.dart';
class BannerListView extends StatelessWidget {
  const BannerListView(
      {super.key,
        required this.produtList,
       // required this.colors,
        //required this.textStyle,
        required this.callback});
  final List<ProductEntity> produtList;
 // final CustomColors colors;
  //final CustomTextStyle textStyle;
  final GestureTapCallback callback;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15, top: 10, bottom: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top deals",
               // style: textStyle.titleLarge
                 //   .copyWith(fontWeight: FontWeight.normal),
              ),
              CupertinoButton(
                onPressed: callback,
                child: Row(
                  children: [
                    Text(
                      "See all",
                      //style:
                     // textStyle.bodyNormal.copyWith(color: colors.primary),
                    ),
                    Icon(
                      Icons.keyboard_double_arrow_right,
                 //     color: colors.primary,
                    )
                  ],
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          CarouselSlider.builder(
              itemCount: produtList.length - 20,
              itemBuilder: (context, index, realIndex) {
                return networkImage(
                  imageUrl: produtList[index].imageUrl,
                );
              },
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayCurve: Curves.easeInCubic,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ))
        ],
      ),
    );
  }
}
