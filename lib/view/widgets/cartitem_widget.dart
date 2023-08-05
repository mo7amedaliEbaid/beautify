import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../model/tools/colors/color.dart';
import '../../model/tools/fonts/font.dart';


class CartBottomItem extends StatelessWidget {
  const CartBottomItem({
    Key? key,
  //  required this.colors,
    //required this.textStyle,
    this.widget,
    required this.callback,
    required this.navigateName,
  }) : super(key: key);

//  final CustomColors colors;
  //final CustomTextStyle textStyle;
  final GestureTapCallback callback;
  final Widget? widget;
  final String navigateName;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: 0,
        child: Container(
          width: Get.mediaQuery.size.width,
          height: 100,
          decoration: BoxDecoration(
            //  color: colors.gray,
              borderRadius:
              const BorderRadius.vertical(top: Radius.circular(15))),
          padding:
          const EdgeInsets.only(top: 10, right: 20, left: 20, bottom: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              widget != null ? widget! : Container(),
              Expanded(
                child: SizedBox(
                  height: 50,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: ElevatedButton(
                        style: ButtonStyle(
                          //  backgroundColor:
                            //MaterialStatePropertyAll(colors.blackColor)
                          ),
                        onPressed: callback,
                        child: Text(
                          navigateName,
                       //   style: textStyle.bodyNormal
                         //     .copyWith(color: colors.whiteColor),
                        )),
                  ),
                ),
              )
            ],
          ),
        ));
  }
}
