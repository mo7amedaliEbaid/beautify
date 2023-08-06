import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';




void snackBar(
    {required String title,
      required String message,}) {
  Get.snackbar(title, "",
      messageText: AutoSizeText(
        message,
        maxLines: 1,
      ),
    );
}