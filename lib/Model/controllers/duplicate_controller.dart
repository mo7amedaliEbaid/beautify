import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../ViewModel/Cart/cart.dart';
import '../../ViewModel/Cart/payment.dart';
import '../../ViewModel/Intro/intro.dart';
import '../tools/Color/color.dart';
import '../tools/Entities/entities.dart';
import '../tools/Font/font.dart';
import '../tools/JsonParse/product_parse.dart';

class DuplicateController extends GetxController {
  final CustomColors colorsInstance = CustomColors();
  CustomColors get colors => colorsInstance;

  final CustomTextStyle textStyleInstance = CustomTextStyle();
  CustomTextStyle get textStyle => textStyleInstance;

  final UiDuplicate uiDuplicateInstance = UiDuplicate();
  UiDuplicate get uiDuplicate => uiDuplicateInstance;

  final IntroFunctions introFunctionsInstance = IntroFunctions();
  IntroFunctions get introFunctions => introFunctionsInstance;

  final CartFunctions cartFunctionsInstance = CartFunctions();
  CartFunctions get cartFunctions => cartFunctionsInstance;

  final PaymentFunctions paymentFunctionsInstance = PaymentFunctions();
  PaymentFunctions get paymentFunctions => paymentFunctionsInstance;

  late var cartBoxListenableInstance =
      Hive.box<ProductEntity>(cartFunctions.boxName).listenable();
  ValueListenable<Box<ProductEntity>> get cartBoxListenable =>
      cartBoxListenableInstance;
}
