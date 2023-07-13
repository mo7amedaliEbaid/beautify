import 'package:beautify/view/onboarding_screen/onboarding_screen.dart';
import 'package:beautify/view/rootscreen/root.dart';
import 'package:beautify/viewmodel/initial/initial.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'model/controllers/binding/initial_binding.dart';
import 'model/controllers/duplicate_controller.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HighPriorityInitial.initial();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    bool isFirst =
        Get.find<DuplicateController>().introFunctions.getLaunchStatus();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: InitialBinding(),
      title: 'Beautify',
      home: isFirst
          ? const IntroScreen()
          : const RootScreen(
              index: 0,
            ),
    );
  }
}
