import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beautify/configs/configs.dart';
import 'package:get/get.dart';
import '../../configs/app.dart';
import '../../model/controllers/duplicate_controller.dart';
import '../../model/controllers/initial_controller.dart';
import '../cartscreen/cart_screen.dart';
import '../homescreen/home_screen.dart';
import '../profilescreen/profile_screen.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key, required this.index});
  final int index;
  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> with WidgetsBindingObserver {
  final duplicateController = Get.find<DuplicateController>();
  final initialController = Get.find<InitialController>();
  late int slectedIndex = widget.index;
  late PageController pageController =
      PageController(initialPage: slectedIndex, keepPage: true);
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    duplicateController.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.detached) {
      await initialController.closeHive();
      pageController.dispose();
    }
  }

  @override
  Widget build(BuildContext context) {
    App.init(context);


    return Scaffold(
      body: PageView(
        physics: duplicateController.uiDuplicate.defaultScroll,
        controller: pageController,
        children: const [HomeScreen(), CartScreen(), ProfileScreen()],
        onPageChanged: (value) {
          setState(() {
            slectedIndex = value;
          });
        },
      ),
      bottomNavigationBar: BottomNavyBar(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        curve: Curves.easeInOut,
        selectedIndex: slectedIndex,
        items: [
          BottomNavyBarItem(
              textAlign: TextAlign.center,
              icon: const Icon(
                CupertinoIcons.home,
              ),
              title: Text(
                "Home",
              )),
          BottomNavyBarItem(
              textAlign: TextAlign.center,
              icon: const Icon(
                CupertinoIcons.cart,
              ),
              title: Text(
                "Cart",
              )),
          BottomNavyBarItem(
              textAlign: TextAlign.center,
              icon: const Icon(CupertinoIcons.person_alt_circle),
              title: Text(
                "Profile",
              )),
        ],
        onItemSelected: (value) {
          setState(() {
            slectedIndex = value;
            pageController.jumpToPage(slectedIndex);
          });
        },
      ),
    );
  }
}
