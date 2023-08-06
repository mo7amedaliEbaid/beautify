import 'package:beautify/model/tools/constants/assets.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beautify/configs/configs.dart';
import '../../configs/app.dart';
import '../../model/tools/jsonparse/product_parse.dart';
import 'networkimage_widget.dart';

class BannerListView extends StatelessWidget {
  const BannerListView();

  @override
  Widget build(BuildContext context) {
    App.init(context);
    return Padding(
      padding: Space.all(1, .7),
      child: Column(
        children: [
          Space.y!,
          CarouselSlider.builder(
              itemCount: 5,
              itemBuilder: (context, index, realIndex) {
                return Image.asset(
                  makeupimgs[index],
                  width: AppDimensions.normalize(100),
                  height: AppDimensions.normalize(100),
                  fit: BoxFit.fill,
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
