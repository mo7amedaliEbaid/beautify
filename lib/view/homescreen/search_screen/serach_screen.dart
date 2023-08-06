import 'package:beautify/configs/app_dimensions.dart';
import 'package:beautify/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../model/controllers/duplicate_controller.dart';
import '../../../model/controllers/home_controller.dart';
import '../../../model/tools/constants/assets.dart';
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

  @override
  void dispose() {
    searchBloc?.close();
    super.dispose();
  }

  List<String> availablebrands = [
    "almay",
    "alva",
    "anna sui",
    "annabelle",
    "benefit",
    "boosh",
    "clinique",
    "colourpop",
    "covergirl",
    "dalish",
    "deciem",
    "dior",
    "sante",
    "stila"
  ];

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
                            );
                            return "";
                          }
                        },
                        controller: searchController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: "Search by brand name..",
                        ),
                      )),
                  actions: [
                    CupertinoButton(
                      child: Icon(
                        Icons.search,
                        color: Colors.white,
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
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        height: AppDimensions.normalize(120),
                        width: AppDimensions.normalize(200),
                        margin: Space.all(1, 1),
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 5,
                                  crossAxisSpacing: 3,
                                  mainAxisSpacing: 3),
                          itemCount: availablebrands.length,
                          itemBuilder: (context, index) => Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      colors: [Colors.redAccent, Colors.greenAccent])),
                              child: Center(
                                  child: Text(
                                availablebrands[index],
                                style: AppText.h2,
                              ))),
                        ),
                      ),
                      Container(
                          height: AppDimensions.normalize(100),
                          width: AppDimensions.normalize(100),
                          child: LottieBuilder.network(searchLottie)),
                    ],
                  ),
                ),
              );
            } else if (state is SearchSuccess) {
              return Scaffold(
                appBar: AppBar(
                  title: Text(
                    "Search Result",
                  ),
                ),
                body: gridViewScreensContainer(
                    child: ProductGrideView(
                  productList: state.productList,
                  uiDuplicate: duplicateController.uiDuplicate,
                )),
              );
            } else if (state is SearchEmptyScreen) {
              return EmptyScreen(
                  title: "Search Result",
                  content: "Nothing found\nPlease enter a valid brand",
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
