import 'package:beautify/providers.dart';
import 'package:beautify/view/landing_screen/landing_screen.dart';
import 'package:beautify/view/rootscreen/root.dart';
import 'package:beautify/viewmodel/initial/initial.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'configs/core_theme.dart' as theme;
import 'package:get/get.dart';

import 'model/controllers/binding/initial_binding.dart';
import 'model/controllers/duplicate_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HighPriorityInitial.initial();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => ThemeProvider()),
    ],
    child: Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MyApp(
          provider: themeProvider,
        );
      },
    ),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.provider});

  final ThemeProvider provider;

  @override
  Widget build(BuildContext context) {
    bool isFirst =
        Get.find<DuplicateController>().introFunctions.getLaunchStatus();
   // bool isdark = Get.find<DuplicateController>().introFunctions.isDark;
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      themeMode: provider.isDark ? ThemeMode.dark : ThemeMode.light,
      theme: theme.themeLight,
      darkTheme: theme.themeDark,
      title: 'Beautify',
      home: isFirst
          ? const LandingScreen()
          : const RootScreen(
              index: 0,
            ),
    );
  }
}
