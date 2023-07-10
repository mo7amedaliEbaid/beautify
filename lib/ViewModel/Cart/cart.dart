import 'package:hive_flutter/adapters.dart';

import '../../Model/tools/JsonParse/product_parse.dart';

class CartFunctions {
  final String boxName = "CartBox";
  Future<void> openCartBox() async {
    await Hive.openBox<ProductEntity>(boxName);
  }

  Future<bool> addToCart({required ProductEntity productEntity}) async {
    final box = Hive.box<ProductEntity>(boxName);
    await box.add(productEntity);
    return true;
  }

  Future<List<ProductEntity>> getProductFromHive() async {
    final box = Hive.box<ProductEntity>(boxName);
    List<ProductEntity> productList = [];
    productList = box.values.toList();

    return productList;
  }

  Future<bool> deleteProduct({required int index}) async {
    final box = Hive.box<ProductEntity>(boxName);
    await box.deleteAt(index);
    return true;
  }

  String calculateTotalPrice({required List<ProductEntity> productList}) {
    double equ = 0;
    String result;
    for (var element in productList) {
      equ = equ + double.parse(element.price);
    }
    result = equ.toString();
    return result;
  }

  Future<bool> clearCartBox() async {
    final box = Hive.box<ProductEntity>(boxName);
    await box.clear();
    return true;
  }
}
