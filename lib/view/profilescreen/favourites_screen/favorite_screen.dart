import 'package:beautify/configs/configs.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../model/controllers/duplicate_controller.dart';
import '../../../model/controllers/profile_controller.dart';
import '../../../model/tools/constants/assets.dart';
import '../../../viewmodel/profile/profile.dart';
import '../../widgets/duplicatetempelate_widget.dart';
import '../../widgets/emptyscreen_widget.dart';
import '../../widgets/productview_widget.dart';
import 'bloc/favorite_bloc.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  FavoriteBloc? favoriteBloc;
  @override
  void dispose() {
    favoriteBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duplicateController = Get.find<DuplicateController>();
    final profileController = Get.find<ProfileController>();
    final ProfileFunctions profileFunctions =
        profileController.profileFunctions;
    return BlocProvider(
      create: (context) {
        final bloc = FavoriteBloc();
        bloc.add(FavoriteStart());
        favoriteBloc = bloc;
        return bloc;
      },
      child: BlocBuilder<FavoriteBloc, FavoriteState>(
        builder: (context, state) {
          if (state is FavoriteSuccess) {
            return DuplicateTemplate(
              title: "Favorite Screen",
              child: ListView.builder(
                padding: Space.v,
                physics: duplicateController.uiDuplicate.defaultScroll,
                itemCount: state.productList.length,
                itemBuilder: (context, index) {
                  final product = state.productList[index];
                  return HorizontalProductView(
                      product: product,
                      widget: CupertinoButton(
                        child: Icon(
                          Icons.delete,
                        ),
                        onPressed: () async {
                          bool isDeleted = await profileFunctions
                              .removeFavorite(productEntity: product);
                          if (isDeleted) {
                            favoriteBloc!.add(FavoriteStart());
                          }
                        },
                      ),
                      margin: Space.all(.5,.5));
                },
              ),
            );
          } else if (state is FavoriteEmpty) {
            return EmptyScreen(
                title: "Favorite Screen",
                content: "you're favorite list is empty",
                lottieName: emptyListLottie);
          }
          return Container();
        },
      ),
    );
  }
}
