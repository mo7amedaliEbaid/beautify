import 'package:flutter/cupertino.dart';

import '../Color/color.dart';

class CustomTextStyle {
  final CustomColors colors = CustomColors();
  
  late TextStyle bodyNormal =
      TextStyle(fontSize: 20, color: colors.blackColor);

  late TextStyle bodySmall =
      TextStyle(fontSize: 14, color: colors.captionColor);

  late TextStyle titleLarge =TextStyle(
      fontSize: 30, color: colors.blackColor, fontWeight: FontWeight.bold);
}
