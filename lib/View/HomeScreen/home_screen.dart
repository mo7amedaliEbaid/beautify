import 'package:beautify/Model/tools/JsonParse/product_parse.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../Model/controllers/duplicate_controller.dart';
import '../../Model/controllers/home_controller.dart';
import '../../Model/controllers/profile_controller.dart';
import '../../Model/tools/Color/color.dart';
import '../../Model/tools/Font/font.dart';
import '../widgets/bannerlistview_widget.dart';
import '../widgets/customloading_widget.dart';
import '../widgets/duplicatecontainer_widget.dart';
import '../widgets/exception_widget.dart';
import '../widgets/productlistview_widget.dart';
import 'SerachScreen/serach_screen.dart';
import 'ShopScreen/shop_screen.dart';
import 'bloc/home_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

HomeBloc? homeBloc;

class _HomeScreenState extends State<HomeScreen>
    with AutomaticKeepAliveClientMixin {
  final duplicateController = Get.find<DuplicateController>();
  final homeController = Get.find<HomeController>();
  final getContext = Get.context!;
  @override
  void initState() {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        systemNavigationBarColor: duplicateController.colors.whiteColor));
    super.initState();
  }

  @override
  void dispose() {
    homeBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return BlocProvider(
      create: (context) {
        final bloc = HomeBloc(homeRepository: homeController.homeRepository);
        bloc.add(HomeStart());
        homeBloc = bloc;
        return bloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final CustomColors colors = duplicateController.colors;
          final CustomTextStyle textStyle = duplicateController.textStyle;
          final ScrollPhysics physics =
              duplicateController.uiDuplicate.defaultScroll;
          if (state is HomeLoading) {
            return const CustomLoading();
          } else if (state is HomeSuccess) {
            final List<ProductEntity> productList = state.productList;
            final profileFunctions =
                Get.find<ProfileController>().profileFunctions;
            return Scaffold(
              backgroundColor: colors.blackColor,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: colors.blackColor,
                centerTitle: true,
                title: Text(
                  "Beautify",
                  style:
                      textStyle.titleLarge.copyWith(color: colors.whiteColor),
                ),
                actions: [
                  CupertinoButton(
                    child: Icon(
                      Icons.search,
                      color: colors.whiteColor,
                    ),
                    onPressed: () {
                      Get.to(const SearchScreen());
                    },
                  )
                ],
              ),
              body: duplicateContainer(
                colors: colors,
                child: ListView.builder(
                  physics: physics,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 1:
                        return Padding(
                          padding: const EdgeInsets.only(top: 10, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Maybelline Collection",
                                style: textStyle.titleLarge.copyWith(
                                  overflow: TextOverflow.clip,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                "Find the perfect watch for your wrist",
                                style: textStyle.bodyNormal,
                              )
                            ],
                          ),
                        );
                      case 2:
                        return ProductListView(
                            colors: colors,
                            profileFunctions: profileFunctions,
                            reverse: false,
                            physics: physics,
                            textStyle: textStyle,
                            productList: productList,
                            callback: () {
                              Get.to(ShopScreen(
                                  title: "Latest", productList:productList));
                            },
                            title: "Latest");

                      case 3:
                        return BannerListView(
                            callback: () {
                              Get.to(ShopScreen(
                                  title: "Top deals",
                                  productList: productList));
                            },
                            produtList: productList,
                            colors: colors,
                            textStyle: textStyle);

                      case 4:
                        return ProductListView(
                            profileFunctions: profileFunctions,
                            colors: colors,
                            textStyle: textStyle,
                            productList: productList.reversed.toList(),
                            title: "Featured products",
                            physics: physics,
                            callback: () {
                              Get.to(ShopScreen(
                                  title: "Featured products",
                                  productList: productList.reversed.toList()));
                            },
                            reverse: false);
                      default:
                        return Container();
                    }
                  },
                ),
              ),
            );
          } else if (state is HomeError) {
            return AppException(
              callback: () {
                homeBloc!.add(HomeStart());
              },
            );
          }
          return Container();
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
