import 'package:dio/dio.dart';

import '../../../model/tools/constants/api_consts.dart';
import '../../../model/tools/jsonparse/product_parse.dart';

abstract class HomeDataSource {
  Future<List<ProductEntity>> getProducts();

  Future<List<ProductEntity>> getProductsWithKeyWord({required String keyWord});
}

class HomeRemoteDataSource implements HomeDataSource {
  final Dio httpClient;

  HomeRemoteDataSource({required this.httpClient});

  @override
  Future<List<ProductEntity>> getProducts() async {
    final response = await httpClient
        .get("${ApiConsts.BASE_URL}${ApiConsts.BRAND}${ApiConsts.COVERGIRL}");
    final List<ProductEntity> productList = [];
    for (var product in (response.data) as List) {
      productList.add(ProductEntity.fromJson(product));
    }
    return productList;
  }

  @override
  Future<List<ProductEntity>> getProductsWithKeyWord(
      {required String keyWord}) async {
    final response =
        await httpClient.get("${ApiConsts.BASE_URL}${ApiConsts.BRAND}$keyWord");
    final List<ProductEntity> productList = [];
    final data = (response.data) as List;
    if (data.isNotEmpty) {
      for (var element in data) {
        productList.add(ProductEntity.fromJson(element));
      }
    }
    return productList;
  }
}
