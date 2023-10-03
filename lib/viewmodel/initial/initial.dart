import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../../model/controllers/duplicate_controller.dart';
import '../../model/tools/entities/AddressEntity/address_entity.dart';
import '../../model/tools/entities/OrderEntity/order_entity.dart';
import '../../model/tools/jsonparse/product_parse.dart';

class HighPriorityInitial {
  static Future<void> initial() async {
    Get.put(DuplicateController());
    await GetStorage.init();
    await Hive.initFlutter();
    Hive.registerAdapter(ProductEntityAdapter());
    Hive.registerAdapter(AddressEntityAdapter());
    Hive.registerAdapter(OrderEntityAdapter());
    await Hive.openBox('app');
  }
}
