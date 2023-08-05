import 'package:barcode/barcode.dart';

class PaymentFunctions {
  String createBarcode() {
    final bar = Barcode.qrCode();
    final svg = bar.toSvg("mo7amedaliebaid@gmail.com", width: 300, height: 100);
    return svg;
  }
}
