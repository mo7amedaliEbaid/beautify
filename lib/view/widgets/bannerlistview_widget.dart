import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beautify/configs/configs.dart';
import '../../configs/app.dart';
import '../../model/tools/jsonparse/product_parse.dart';
import 'networkimage_widget.dart';
class BannerListView extends StatelessWidget {
  const BannerListView(
      {super.key,
        required this.produtList,
        required this.callback});
  final List<ProductEntity> produtList;
  final GestureTapCallback callback;
  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Padding(
      padding: Space.all(1,.7),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Top deals",
                style: AppText.h2
              ),
              CupertinoButton(
                onPressed: callback,
                child: Row(
                  children: [
                    Text(
                      "See all",
                    ),
                    Icon(
                      Icons.keyboard_double_arrow_right,
                    )
                  ],
                ),
              )
            ],
          ),
          Space.y!,
          CarouselSlider.builder(
              itemCount: produtList.length - 20,
              itemBuilder: (context, index, realIndex) {
                return networkImage(
                  imageUrl: produtList[index].imageUrl,
                  width: AppDimensions.normalize(80),
                //    height: AppDimensions.normalize(250)
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
