import 'package:beautify/view/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../model/tools/colors/color.dart';
import '../../model/tools/fonts/font.dart';


void addAddressBottomSheet(
    {required CustomTextStyle textStyle,
      required CustomColors colors,
      required ScrollPhysics scrollPhysics,
      required GestureTapCallback osSaveClicked,
      required TextEditingController adNameController,
      required GlobalKey<FormState> adNameKey,
      required TextEditingController stateController,
      required GlobalKey<FormState> stateKey,
      required TextEditingController addressController,
      required GlobalKey<FormState> addressKey,
      required TextEditingController postalController,
      required GlobalKey<FormState> postalKey,
      required Widget dropDown}) {
  showModalBottomSheet(
    isScrollControlled: true,
    shape: const OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
    ),
    context: Get.context!,
    builder: (context) {
      return Container(
        height: Get.size.height * 0.8,
        padding: const EdgeInsets.fromLTRB(15, 4, 15, 15),
        decoration: BoxDecoration(
            color: colors.whiteColor,
            borderRadius:
            const BorderRadius.vertical(top: Radius.circular(15))),
        child: Scaffold(
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
              width: Get.size.width * 0.5,
              child: FloatingActionButton.extended(
                  backgroundColor: colors.primary,
                  onPressed: osSaveClicked,
                  label: Text(
                    "Save",
                    style:
                    textStyle.bodyNormal.copyWith(color: colors.whiteColor),
                  ))),
          body: SingleChildScrollView(
            physics: scrollPhysics,
            child: Column(
              children: [
                CupertinoButton(
                  child: Container(
                    width: 40,
                    height: 7,
                    decoration: BoxDecoration(
                        color: colors.captionColor,
                        borderRadius: BorderRadius.circular(3)),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: Get.size.height * 0.6,
                  child: SingleChildScrollView(
                    physics: scrollPhysics,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        dropDown,
                        textField(
                            inputType: TextInputType.streetAddress,
                            textStyle: textStyle,
                            controller: stateController,
                            formKey: stateKey,
                            lable: "State",
                            colors: colors,
                            edgeInsetsGeometry: const EdgeInsets.all(12)),
                        textField(
                            inputType: TextInputType.streetAddress,
                            textStyle: textStyle,
                            controller: addressController,
                            formKey: addressKey,
                            lable: "Address detail",
                            colors: colors,
                            edgeInsetsGeometry: const EdgeInsets.all(12)),
                        textField(
                            inputType: TextInputType.streetAddress,
                            textStyle: textStyle,
                            controller: adNameController,
                            formKey: adNameKey,
                            lable: "Address name",
                            colors: colors,
                            edgeInsetsGeometry: const EdgeInsets.all(12)),
                        textField(
                            textStyle: textStyle,
                            controller: postalController,
                            formKey: postalKey,
                            lable: "Postal code",
                            colors: colors,
                            edgeInsetsGeometry: const EdgeInsets.all(12),
                            inputType: TextInputType.number),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}