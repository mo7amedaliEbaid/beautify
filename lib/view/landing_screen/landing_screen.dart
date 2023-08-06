import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beautify/configs/configs.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import '../../configs/app.dart';
import '../../model/controllers/duplicate_controller.dart';
import '../../model/tools/constants/assets.dart';
import '../../viewmodel/onboarding/onboarding.dart';
import '../rootscreen/root.dart';

class LandingScreen extends StatelessWidget {
   LandingScreen({super.key});
  final duplicateController = Get.find<DuplicateController>();


  @override
  Widget build(BuildContext context) {

    App.init(context);
    List<ContentConfig> contentList = [
      ContentConfig(
          styleTitle: AppText.h1b,
          styleDescription: AppText.b1b,
          title: "Beautify",
          description:
          "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
          pathImage: makeupimgs.first),
      ContentConfig(
          styleTitle: AppText.h1b,
          styleDescription: AppText.b1b,
          title: "Beautify",
          description:
          "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
          pathImage: makeupimgs[1]),
      ContentConfig(
          styleTitle: AppText.h1b,
          styleDescription: AppText.b1b,
          title: "Beautify",
          description:
          "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
          pathImage: makeupimgs[2])
    ];
    final duplicateController = Get.find<DuplicateController>();
    IntroFunctions splashFunctions = duplicateController.introFunctions;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IntroSlider(
              indicatorConfig: IndicatorConfig(colorActiveIndicator: Colors.red,colorIndicator: Colors.yellow),
              renderNextBtn: Container(
                alignment: Alignment.center,
                width: AppDimensions.normalize(12),
                height: AppDimensions.normalize(5),
                child: Icon(
                  CupertinoIcons.right_chevron,
                ),
              ),
              renderSkipBtn: Container(
                  alignment: Alignment.center,
                  width: AppDimensions.normalize(12),
                  height: AppDimensions.normalize(5),
                  child: Icon(
                    Icons.skip_next,
                  )),
              renderDoneBtn: Container(
                  alignment: Alignment.center,
                  width: AppDimensions.normalize(12),
                  height: AppDimensions.normalize(5),
                  child: Icon(
                    CupertinoIcons.check_mark,
                  )),
              listContentConfig: contentList,
              onDonePress: () async {
                await splashFunctions.saveLaunchStatus(status: false);
                Navigator.pop(Get.context!);
                Get.to(const RootScreen(
                  index: 0,
                ));
              },
              onSkipPress: () async {
                await splashFunctions.saveLaunchStatus(status: false);
                Navigator.pop(Get.context!);
                Get.to(const RootScreen(
                  index: 0,
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}
