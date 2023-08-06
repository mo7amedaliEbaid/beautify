import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../model/controllers/duplicate_controller.dart';

Widget imageLoading() {
  return LoadingAnimationWidget.halfTriangleDot(
      color: Colors.white, size: 20);
}
