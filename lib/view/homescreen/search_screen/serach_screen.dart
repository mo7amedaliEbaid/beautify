import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../model/controllers/duplicate_controller.dart';
import '../../../model/controllers/home_controller.dart';
import '../../../model/tools/colors/color.dart';
import '../../../model/tools/constants/assets.dart';
import '../../../model/tools/fonts/font.dart';
import '../../widgets/customloading_widget.dart';
import '../../widgets/emptyscreen_widget.dart';
import '../../widgets/exception_widget.dart';
import '../../widgets/gridviewcontainer_widget.dart';
import '../../widgets/productgrid_widget.dart';
import '../../widgets/snackbar_widget.dart';
import 'bloc/search_bloc.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  SearchBloc? searchBloc;
  final homeController = Get.find<HomeController>();
  final duplicateController = Get.find<DuplicateController>();
  late CustomColors colors = duplicateController.colors;
  late CustomTextStyle textStyle = duplicateController.textStyle;
  @override
  void dispose() {
    searchBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) {
          final bloc =
              SearchBloc(homeRepository: homeController.homeRepository);
          searchBloc = bloc;
          bloc.add(InitialSearchScreen());
          return bloc;
        },
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            if (state is SearchingScreen) {
              final TextEditingController searchController =
                  TextEditingController();
              final GlobalKey<FormState> formKey = GlobalKey();
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: colors.whiteColor,
                  foregroundColor: colors.blackColor,
                  title: Form(
                      key: formKey,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          } else {
                            snackBar(
                                title: "Search",
                                message: "please type somethings ...",
                                textStyle: textStyle,
                                colors: colors);
                            return "";
                          }
                        },
                        controller: searchController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: "Search by brand name..",
                          hintStyle: textStyle.bodyNormal,
                        ),
                      )),
                  actions: [
                    CupertinoButton(
                      child: Icon(
                        Icons.search,
                        color: colors.blackColor,
                      ),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          searchBloc!.add(SearchStart(
                              searchKeyWord: searchController.text));
                        }
                      },
                    )
                  ],
                ),
                body: Center(
                  child: LottieBuilder.network(searchLottie),
                ),
              );
            } else if (state is SearchSuccess) {
              return Scaffold(
                backgroundColor: colors.blackColor,
                appBar: AppBar(
                  foregroundColor: colors.whiteColor,
                  backgroundColor: colors.blackColor,
                  title: Text(
                    "Search Result",
                    style:
                        textStyle.titleLarge.copyWith(color: colors.whiteColor),
                  ),
                ),
                body: gridViewScreensContainer(
                    colors: colors,
                    child: ProductGrideView(
                        productList: state.productList,
                        uiDuplicate: duplicateController.uiDuplicate,
                        colors: colors,
                        textStyle: textStyle)),
              );
            } else if (state is SearchEmptyScreen) {
              return EmptyScreen(
                  colors: colors,
                  textStyle: textStyle,
                  title: "Search Result",
                  content: "Nothing found",
                  lottieName: emtySearchLottie);
            } else if (state is SearchLoading) {
              return const CustomLoading();
            } else if (state is SearchError) {
              return AppException(
                callback: () {
                  searchBloc!.add(InitialSearchScreen());
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
