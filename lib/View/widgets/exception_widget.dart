import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Model/controllers/duplicate_controller.dart';

class AppException extends StatelessWidget {
  const AppException({super.key, this.callback, this.errorMessage});
  final GestureTapCallback? callback;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<DuplicateController>();
    final textStyle = controller.textStyle;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            errorMessage == null
                ? Text(
              "Undefined Error",
              style: textStyle.titleLarge,
            )
                : Text(
              errorMessage!,
              style: textStyle.titleLarge,
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: callback,
                child: Text(
                  "try Again",
                  style: textStyle.bodyNormal,
                ))
          ],
        ),
      ),
    );
  }
}
