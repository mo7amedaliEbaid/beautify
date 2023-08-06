import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:beautify/configs/configs.dart';
import '../../model/tools/constants/assets.dart';
import '../profilescreen/auth_screen/authentication_screen.dart';




void loginRequiredDialog() {
  showCupertinoDialog(
      context: Get.context!,
      builder: (context) => CupertinoAlertDialog(
            title: Text(
              "Login",
            ),
            content: Column(
              children: [
                LottieBuilder.network(
                  loginLottie,
                  width: AppDimensions.normalize(100),
                  height: AppDimensions.normalize(80),
                ),
                Text(
                  "To continue to payment please login",
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            actions: [
              CupertinoButton(
                child: Text(
                  "Cancel",
                ),
                onPressed: () {
                  Get.back();
                },
              ),
              CupertinoButton(
                  onPressed: () {
                    Get.back();
                    Get.to(const AuthenticationScreen());
                  },
                  child: Text(
                    "Login",
                  )),
            ],
          ));
}
