
import 'package:get/get.dart';

import '../../ViewModel/Home/HomeDataSource/home_source.dart';
import '../../ViewModel/Home/HomeRepository/home_repo.dart';
import '../tools/Entities/entities.dart';

class HomeController extends GetxController {
  final HomeRepository homeRepositoryInstance = HomeRepository(
      dataSource: HomeRemoteDataSource(httpClient: HttpPackage().dio));
  HomeRepository get homeRepository => homeRepositoryInstance;
}
