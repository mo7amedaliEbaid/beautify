import 'package:beautify/view/homescreen/search_screen/serach_screen.dart';
import 'package:beautify/view/homescreen/shop_screen/shop_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beautify/configs/configs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../configs/app.dart';
import '../../model/controllers/duplicate_controller.dart';
import '../../model/controllers/home_controller.dart';
import '../../model/controllers/profile_controller.dart';

import '../../model/controllers/theme_controller.dart';
import '../../model/tools/jsonparse/product_parse.dart';
import '../widgets/bannerlistview_widget.dart';
import '../widgets/customloading_widget.dart';
import '../widgets/duplicatecontainer_widget.dart';
import '../widgets/exception_widget.dart';
import '../widgets/productlistview_widget.dart';

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
  void dispose() {
    homeBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    App.init(context);

    final ThemeController themeController = Get.find();

    return BlocProvider(
      create: (context) {
        final bloc = HomeBloc(homeRepository: homeController.homeRepository);
        bloc.add(HomeStart());
        homeBloc = bloc;
        return bloc;
      },
      child: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          final ScrollPhysics physics =
              duplicateController.uiDuplicate.defaultScroll;
          if (state is HomeLoading) {
            return const CustomLoading();
          } else if (state is HomeSuccess) {
            final List<ProductEntity> productList = state.productList;
            final profileFunctions =
                Get.find<ProfileController>().profileFunctions;
            return Scaffold(
              appBar: AppBar(
                elevation: 0,
                centerTitle: true,
                title: Text(
                  "Beautify",
                ),
                leading: Obx(
                      () => Switch(
                    value: themeController.isDarkMode.value,
                    onChanged: (value) {
                      themeController.toggleTheme();
                    },
                  ), /*InkWell(
                  hoverColor: Colors.transparent,
                  onTap: () {
                    themeProvider.theme = !themeProvider.theme;
                  },*/
                 /* child: Container(
                    margin: Space.all(.5, .5),
                    decoration: BoxDecoration(
                      color: themeProvider.isDark
                          ? Colors.grey[800]
                          : Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.brightness_6_outlined,
                      color: themeProvider.isDark ? Colors.yellow : Colors.grey,
                      size: AppDimensions.normalize(10),
                    ),
                  ),*/
                ),
                actions: [
                  CupertinoButton(
                    child: Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      Get.to(const SearchScreen());
                    },
                  )
                ],
              ),
              body: duplicateContainer(
                child: ListView.builder(
                  physics: physics,
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    switch (index) {
                      case 1:
                        return Padding(
                          padding: Space.v!,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Maybelline Collection",
                              ),
                              Space.y!,
                              Text(
                                "Find the perfect makeup product",
                              )
                            ],
                          ),
                        );
                      case 2:
                        return BannerListView();

                      case 3:
                        return ProductListView(
                            profileFunctions: profileFunctions,
                            reverse: false,
                            physics: physics,
                            productList: productList,
                            callback: () {
                              Get.to(ShopScreen(
                                  title: "Latest", productList: productList));
                            },
                            title: "Latest");


                      case 4:
                        return ProductListView(
                            profileFunctions: profileFunctions,
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
