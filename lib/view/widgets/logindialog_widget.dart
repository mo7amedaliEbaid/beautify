import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../model/tools/constants/assets.dart';
import '../../model/tools/fonts/font.dart';
import '../profilescreen/auth_screen/authentication_screen.dart';




void loginRequiredDialog({required CustomTextStyle textStyle}) {
  showCupertinoDialog(
      context: Get.context!,
      builder: (context) => CupertinoAlertDialog(
            title: Text(
              "Login",
              style: textStyle.titleLarge,
            ),
            content: Column(
              children: [
                LottieBuilder.network(
                  loginLottie,
                  width: 200,
                  height: 200,
                ),
                Text(
                  "To continue to payment please login",
                  style: textStyle.bodyNormal,
                  overflow: TextOverflow.clip,
                  textAlign: TextAlign.start,
                ),
              ],
            ),
            actions: [
              CupertinoButton(
                child: Text(
                  "Cancel",
                  style: textStyle.bodyNormal,
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
                    style: textStyle.bodyNormal,
                  )),
            ],
          ));
}
