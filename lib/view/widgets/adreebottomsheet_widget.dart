import 'package:beautify/view/widgets/textfield_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:beautify/configs/configs.dart';

void addAddressBottomSheet(
    {
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
    context: Get.context!,
    builder: (context) {
      return Container(
        height: AppDimensions.normalize(250),
        child: Scaffold(
          floatingActionButtonLocation:
          FloatingActionButtonLocation.centerFloat,
          floatingActionButton: SizedBox(
              width:AppDimensions.normalize(100),
              child: FloatingActionButton.extended(
                  onPressed: osSaveClicked,
                  label: Text(
                    "Save",
                  ))),
          body: SingleChildScrollView(
            physics: scrollPhysics,
            child: Column(
              children: [
                CupertinoButton(
                  child: Container(
                    width: AppDimensions.normalize(20),
                    height: AppDimensions.normalize(2),
                    decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(AppDimensions.normalize(2))),
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
                SizedBox(
                  height: AppDimensions.normalize(170),
                  child: SingleChildScrollView(
                    physics: scrollPhysics,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        dropDown,
                        textField(
                          context: context,
                            inputType: TextInputType.streetAddress,
                            controller: stateController,
                            formKey: stateKey,
                            lable: "State",
                            edgeInsetsGeometry: Space.all(1,.2)),
                        textField(
                          context: context,
                            inputType: TextInputType.streetAddress,
                            controller: addressController,
                            formKey: addressKey,
                            lable: "Address detail",
                            edgeInsetsGeometry: Space.all(1,.2)),
                        textField(
                          context: context,
                            inputType: TextInputType.streetAddress,
                            controller: adNameController,
                            formKey: adNameKey,
                            lable: "Address name",
                            edgeInsetsGeometry: Space.all(1,.2)),
                        textField(
                          context: context,
                            controller: postalController,
                            formKey: postalKey,
                            lable: "Postal code",
                            edgeInsetsGeometry: Space.all(1,.2),
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