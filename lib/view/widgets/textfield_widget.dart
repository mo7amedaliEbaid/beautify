import 'package:flutter/material.dart';

import '../../model/tools/colors/color.dart';
import '../../model/tools/fonts/font.dart';


Widget textField(
    {/*required CustomTextStyle textStyle,*/
      required TextEditingController controller,
      required GlobalKey<FormState> formKey,
      required String lable,
  //    required CustomColors colors,
      required EdgeInsetsGeometry edgeInsetsGeometry,
      TextInputType inputType = TextInputType.emailAddress,
      bool obscureText = false,Widget? suffix}) {
  return Padding(
      padding: edgeInsetsGeometry,
      child: Theme(
        data: ThemeData(
            colorScheme: ColorScheme.light(
                /*primary: colors.captionColor, onSurface: colors.captionColor*/)),
        child: Form(
          key: formKey,
          child: TextFormField(
              obscureText: obscureText,
              keyboardType: inputType,
              validator: (value) {
                if (value!.isEmpty) {
                  return "this item required";
                } else if (value.length < 4) {
                  return "item less than 4 characters ";
                } else {
                  return null;
                }
              },
              controller: controller,
            //  cursorColor: colors.captionColor,
              focusNode: FocusNode(),
              decoration: InputDecoration(
                  labelText: lable,
              //    labelStyle: textStyle.bodyNormal,
                  suffix: suffix,
                  //floatingLabelStyle:
                 // textStyle.bodySmall.copyWith(fontWeight: FontWeight.w700),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)
                  )
              )
          ),
        ),
      ));
}