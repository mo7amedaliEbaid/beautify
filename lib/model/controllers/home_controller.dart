
import 'package:get/get.dart';

import '../../viewmodel/home/homedatasource/home_source.dart';
import '../../viewmodel/home/homerepository/home_repo.dart';
import '../tools/entities/entities.dart';

class HomeController extends GetxController {
  final HomeRepository homeRepositoryInstance = HomeRepository(
      dataSource: HomeRemoteDataSource(httpClient: HttpPackage().dio));
  HomeRepository get homeRepository => homeRepositoryInstance;
}
