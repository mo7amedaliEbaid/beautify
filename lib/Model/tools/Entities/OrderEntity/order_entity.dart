import 'package:hive/hive.dart';

import '../../JsonParse/product_parse.dart';

part 'order_entity.g.dart';

@HiveType(typeId: 2)
class OrderEntity {
  @HiveField(0)
  final List<ProductEntity> productList;
  @HiveField(1)
  final String totalPrice;
  @HiveField(2)
  final DateTime time;

  OrderEntity(
      {required this.productList,
      required this.totalPrice,
      required this.time});
}
