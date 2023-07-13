import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../model/tools/jsonparse/product_parse.dart';
import '../../../../viewmodel/home/homerepository/home_repo.dart';


part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final HomeRepository homeRepository;
  SearchBloc({required this.homeRepository}) : super(SearchInitial()) {
    on<SearchEvent>((event, emit) async {
      try {
        if (event is InitialSearchScreen) {
          emit(SearchingScreen());
        } else if (event is SearchStart) {
          emit(SearchLoading());
          final productList = await homeRepository.getProductsWithKeyWord(
              keyWord: event.searchKeyWord);
          if (productList.isNotEmpty) {
            emit(SearchSuccess(productList:productList));
          } else {
            emit(SearchEmptyScreen());
          }
        }
      } catch (e) {
        emit(SearchError());
      }
    });
  }
}
