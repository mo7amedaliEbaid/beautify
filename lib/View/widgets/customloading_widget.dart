import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../Model/tools/Color/color.dart';
class CustomLoading extends StatelessWidget {
  const CustomLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final CustomColors colors = CustomColors();
    return Scaffold(
      body: Center(
        child: LoadingAnimationWidget.staggeredDotsWave(
            color: colors.primary, size: 50),
      ),
    );
  }
}
