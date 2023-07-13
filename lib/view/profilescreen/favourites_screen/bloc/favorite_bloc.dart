import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../model/controllers/profile_controller.dart';
import '../../../../model/tools/jsonparse/product_parse.dart';



part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc() : super(FavoriteInitial()) {
    on<FavoriteEvent>((event, emit)async {
      final profileFunctions = Get.find<ProfileController>().profileFunctions;
      if (event is FavoriteStart) {
        final List<ProductEntity> productList =await
            profileFunctions.getFavoriteProducts();
        if (productList.isNotEmpty) {
          emit(FavoriteSuccess(productList));
        } else {
          emit(FavoriteEmpty());
        }
      }
    });
  }
}
