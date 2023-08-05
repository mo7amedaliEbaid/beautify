import 'package:flutter/material.dart';

import '../../model/tools/colors/color.dart';
import '../../model/tools/fonts/font.dart';
import 'duplicatecontainer_widget.dart';
class DuplicateTemplate extends StatelessWidget {
  const DuplicateTemplate({
    Key? key,
  //  required this.colors,
    //required this.textStyle,
    required this.child,
    required this.title,
  }) : super(key: key);

 // final CustomColors colors;
  //final CustomTextStyle textStyle;
  final Widget child;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      //  foregroundColor: colors.whiteColor,
        //backgroundColor: colors.blackColor,
        centerTitle: true,
        title: Text(
          title,
      //    style: textStyle.titleLarge.copyWith(color: colors.whiteColor),
        ),
      ),
      body: Container(
      //  color: colors.blackColor,
        child: duplicateContainer(/*colors: colors,*/ child: child),
      ),
    );
  }
}
