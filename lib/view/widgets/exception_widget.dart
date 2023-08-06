import 'package:beautify/configs/configs.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../model/controllers/duplicate_controller.dart';


class AppException extends StatelessWidget {
  const AppException({super.key, this.callback, this.errorMessage});
  final GestureTapCallback? callback;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            errorMessage == null
                ? Text(
              "Undefined Error",
            )
                : Text(
              errorMessage!,
            ),
           Space.y!,
            ElevatedButton(
                onPressed: callback,
                child: Text(
                  "try Again",
                ))
          ],
        ),
      ),
    );
  }
}
