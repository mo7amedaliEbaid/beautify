import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:lottie/lottie.dart';
import 'package:beautify/configs/configs.dart';
import 'duplicatecontainer_widget.dart';
class EmptyScreen extends StatelessWidget {
  const EmptyScreen({
    Key? key,
    required this.title,
    required this.content,
    required this.lottieName,
  }) : super(key: key);
  final String title;
  final String content;
  final String lottieName;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          title,
        ),
      ),
      body: duplicateContainer(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LottieBuilder.network(
                lottieName,
                fit: BoxFit.cover,
              ),
             Space.y2!,
              SizedBox(
                width: AppDimensions.normalize(120),
                child: AutoSizeText(
                  content,
               style: AppText.h2,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
    );
  }
}

