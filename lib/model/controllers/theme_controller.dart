import 'package:beautify/configs/app_theme.dart';
import 'package:beautify/configs/core_theme.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeController extends GetxController {
  RxBool isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(isDarkMode.value ? themeLight : themeDark);
  }
}
