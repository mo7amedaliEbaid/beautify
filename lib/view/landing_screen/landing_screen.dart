import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:beautify/configs/configs.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import '../../configs/app.dart';
import '../../model/controllers/duplicate_controller.dart';
import '../../model/tools/constants/assets.dart';
import '../../viewmodel/onboarding/onboarding.dart';
import '../rootscreen/root.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final duplicateController = Get.find<DuplicateController>();
  late List<ContentConfig> contentList = [
    ContentConfig(
        //backgroundColor: colors.primary,
      styleTitle: AppText.h1?.copyWith(color: Colors.red),
        styleDescription: AppText.h2?.copyWith(color: Colors.red),
        title: "Beautify",
        description:
            "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
        pathImage: manImage),
    ContentConfig(
        //backgroundColor: colors.primary,
        styleTitle: AppText.h1?.copyWith(color: Colors.red),
        styleDescription: AppText.h2?.copyWith(color: Colors.red),

        title: "Beautify",
        description:
            "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
        pathImage: aboutImage),
    ContentConfig(
    //    backgroundColor: colors.primary,
        styleTitle: AppText.h1?.copyWith(color: Colors.red),
        styleDescription: AppText.h2?.copyWith(color: Colors.red),

        title: "Beautify",
        description:
            "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
        pathImage: contentImage)
  ];
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(/*systemNavigationBarColor: colors.primary)*/));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);
    final duplicateController = Get.find<DuplicateController>();
    IntroFunctions splashFunctions = duplicateController.introFunctions;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: IntroSlider(
              renderNextBtn: Container(
                alignment: Alignment.center,
                width: 40,
                height: 30,
                decoration: BoxDecoration(
                   /* color: colors.whiteColor,*/ borderRadius: BorderRadius.circular(12)),
                child: Icon(
                  CupertinoIcons.right_chevron,
                 // color: colors.blackColor,
                ),
              ),
              renderSkipBtn: Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                    //  color: colors.whiteColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                    Icons.skip_next,
                 //   color: colors.blackColor,
                  )),
              renderDoneBtn: Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
                 //     color: colors.whiteColor,
                      borderRadius: BorderRadius.circular(12)),
                  child: Icon(
                    CupertinoIcons.check_mark,
                  //  color: colors.blackColor,
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