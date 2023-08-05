import 'package:auto_size_text/auto_size_text.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../model/tools/colors/color.dart';
import '../../model/tools/fonts/font.dart';



void snackBar(
    {required String title,
      required String message,
      required CustomTextStyle textStyle,
      required CustomColors colors}) {
  Get.snackbar(title, "",
      messageText: AutoSizeText(
        message,
     //   style: textStyle.bodyNormal,
        maxLines: 1,
      ),
     /* backgroundColor: colors.gray*/);
}