import 'package:beautify/providers/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beautify/configs/configs.dart';
import 'package:get/get.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:provider/provider.dart';
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

  @override
  void initState() {

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    App.init(context);
    final  themeProvider=Provider.of<ThemeProvider>(context);

    List<ContentConfig> contentList = [
      ContentConfig(
          styleTitle: AppText.h1?.copyWith(color: themeProvider.isDark?Colors.white:Colors.black),
          styleDescription: AppText.h2?.copyWith(color: themeProvider.isDark?Colors.white:Colors.black),
          title: "Beautify",
          description:
          "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
          pathImage: makeupimgs.first),
      ContentConfig(
          styleTitle: AppText.h1?.copyWith(color: themeProvider.isDark?Colors.white:Colors.black),
          styleDescription: AppText.h2?.copyWith(color: themeProvider.isDark?Colors.white:Colors.black),

          title: "Beautify",
          description:
          "In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.",
          pathImage: makeupimgs[1]),
      ContentConfig(
          styleTitle: AppText.h1?.copyWith(color: themeProvider.isDark?Colors.white:Colors.black),
          styleDescription: AppText.h2?.copyWith(color: themeProvider.isDark?Colors.white:Colors.black),
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
              renderNextBtn: Container(
                alignment: Alignment.center,
                width: AppDimensions.normalize(10),
                height: AppDimensions.normalize(3),
                decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12)),
                child: Icon(
                  CupertinoIcons.right_chevron,
                ),
              ),
              renderSkipBtn: Container(
                  alignment: Alignment.center,
                  width: 40,
                  height: 30,
                  decoration: BoxDecoration(
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
