import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';

import '../../model/tools/colors/color.dart';
import '../../model/tools/fonts/font.dart';
import 'duplicatecontainer_widget.dart';
class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    Key? key,
    required this.colors,
    required this.textStyle,
    required this.title,
    required this.content,
    required this.lottieName,
  }) : super(key: key);

  final CustomColors colors;
  final CustomTextStyle textStyle;
  final String title;
  final String content;
  final String lottieName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colors.blackColor,
      appBar: AppBar(
        backgroundColor: colors.blackColor,
        centerTitle: true,
        title: Text(
          title,
          style: textStyle.titleLarge.copyWith(color: colors.whiteColor),
        ),
      ),
      body: duplicateContainer(
          colors: colors,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.network(
                lottieName,
                fit: BoxFit.cover,
              ),
              const SizedBox(
                height: 20,
              ),
              SizedBox(
                width: Get.mediaQuery.size.width * 0.6,
                child: Center(
                  child: Text(
                    content,
                    style: textStyle.bodyNormal
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}

