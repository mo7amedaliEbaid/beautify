import 'package:beautify/view/landing_screen/landing_screen.dart';
import 'package:beautify/view/rootscreen/root.dart';
import 'package:beautify/viewmodel/initial/initial.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'configs/core_theme.dart' as theme;
import 'package:get/get.dart';

import 'model/controllers/binding/initial_binding.dart';
import 'model/controllers/duplicate_controller.dart';
import 'model/controllers/theme_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HighPriorityInitial.initial();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.put(ThemeController());
    bool isFirst =
        Get.find<DuplicateController>().introFunctions.getLaunchStatus();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      themeMode: ThemeMode.system,
      theme: theme.themeLight,
      darkTheme: theme.themeDark,
      title: 'Beautify',
      home: isFirst
          ? LandingScreen()
          : const RootScreen(
              index: 0,
            ),
    );
  }
}
