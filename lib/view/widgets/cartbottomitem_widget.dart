import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import 'package:beautify/configs/configs.dart';

class CartBottomItem extends StatelessWidget {
  const CartBottomItem({
    Key? key,

    this.widget,
    required this.callback,
    required this.navigateName,
  }) : super(key: key);


  final GestureTapCallback callback;
  final Widget? widget;
  final String navigateName;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: Container(
          width: Get.mediaQuery.size.width,
          height: AppDimensions.normalize(35),
          decoration: BoxDecoration(
          color: Colors.green,
              borderRadius:
               BorderRadius.vertical(top: Radius.circular(AppDimensions.normalize(10)))),
          padding:
           Space.all(1,.7),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget != null ? widget! : Container(),
              Expanded(
                child: SizedBox(
                  height: AppDimensions.normalize(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppDimensions.normalize(4)),
                    child: ElevatedButton(
                        onPressed: callback,
                        child: Text(
                          navigateName,
                        )),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
