import 'dart:math';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:beautify/configs/configs.dart';
import '../../../model/controllers/duplicate_controller.dart';
import '../../../model/controllers/profile_controller.dart';
import '../../../model/tools/jsonparse/product_parse.dart';
import '../../../viewmodel/cart/cart.dart';
import '../../cartscreen/cart_screen.dart';
import '../../widgets/cartbadge_widget.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.productEntity});
  final ProductEntity productEntity;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  final double rate = Random.secure().nextInt(5).toDouble();
  @override
  Widget build(BuildContext context) {
    final duplicateController = Get.find<DuplicateController>();
    final profileController = Get.find<ProfileController>();
    final CartFunctions cartFunctions = duplicateController.cartFunctions;
    final profileFunctions = profileController.profileFunctions;
    final bool isInFavorite =
        profileFunctions.isInFavoriteBox(productEntity: widget.productEntity);

    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: paddingFromRL(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: IconButton(
                  icon: isInFavorite
                      ? Icon(
                          CupertinoIcons.heart_fill,
                    color: Colors.red,
                        )
                      : Icon(
                          CupertinoIcons.heart,
                        ),
                  onPressed: () async {
                    if (isInFavorite) {
                      await profileFunctions.removeFavorite(
                          productEntity: widget.productEntity);
                      setState(() {});
                    } else {
                      await profileFunctions.addToFavorite(
                          productEntity: widget.productEntity);
                      setState(() {});
                    }
                  },
                ),
              ),
              Expanded(
                child: Padding(
                  padding: Space.h1!,
                  child: CupertinoTheme(
                    data: CupertinoThemeData(primaryColor: Colors.blueAccent),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(AppDimensions.normalize(6)),
                      child: CupertinoButton.filled(
                        child: Text(
                          "Add to cart",
                        ),
                        onPressed: () async {
                          bool isAdd = await cartFunctions.addToCart(
                              productEntity: widget.productEntity);
                          if (isAdd) {
                            Get.snackbar("Add to cart", "",
                                messageText: Text(
                                  "successfully add to cart",
                                ),
                     );
                          }
                        },
                      ),
                    ),
                  ),
                ),
              ),
              CircleAvatar(
                child: IconButton(
                  icon: Icon(
                    CupertinoIcons.arrow_up_right,
                  ),
                  onPressed: () {
                    Share.shareWithResult("mohamed");
                  },
                ),
              )
            ],
          ),
        ),
        appBar: AppBar(

          centerTitle: true,
          title: Text(
            "Product Detail",
          ),
          actions: [
            CartLengthBadge(
              duplicateController: duplicateController,
              badgeCallback: () {
                Get.to(const CartScreen());
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              margin: Space.v1!,
              width: AppDimensions.normalize(100),
              height: AppDimensions.normalize(80),
              child: Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: widget.productEntity.imageUrl,
                    fit: BoxFit.fitHeight,
                  ),
                ],
              ),
            ),
            Container(
              height: AppDimensions.normalize(150),
              decoration: BoxDecoration(
                color:Colors.blue ,
                  borderRadius:
                       BorderRadius.vertical(top: Radius.circular(AppDimensions.normalize(5)))),
              child: SingleChildScrollView(
                physics: duplicateController.uiDuplicate.defaultScroll,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Space.y1!,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        paddingFromRL(
                          child: Text(
                            widget.productEntity.name,
                            style: AppText.h3b,
                            overflow: TextOverflow.clip,
                          ),
                        ),
                     Space.y!,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            RatingBar.builder(
                              initialRating: rate,
                              direction: Axis.horizontal,
                              maxRating: 5,
                              allowHalfRating: true,
                              itemBuilder: (context, index) {
                                return Icon(
                                  Icons.star,
                                 color: Colors.amber,
                                );
                              },
                              onRatingUpdate: (value) {
                                Get.dialog(CupertinoAlertDialog(
                                  title: Center(
                                    child: RatingBarIndicator(
                                      itemCount: 5,
                                      rating: value,
                                      itemBuilder: (context, index) {
                                        return Icon(
                                          Icons.star,
                                         color: Colors.amber,
                                        );
                                      },
                                    ),
                                  ),
                                  content: Text(
                                    "Thank you for rating",
                                  ),
                                ));
                              },
                            ),
                         Space.x!,
                            Text(
                              "1.248 Reviews",
                              style: AppText.b1b,
                            )
                          ],
                        )
                      ],
                    ),
                    Space.y1!,
                    paddingFromRL(
                        child: Text(
                      widget.productEntity.description,
                    )),
                 Space.y1!,
                    Text(
                      "€${widget.productEntity.price}",
                      style: AppText.b1b

                    ),
                    Space.y1!
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}

Widget paddingFromRL({required Widget child}) {
  return Padding(
    padding: Space.h1!,
    child: child,
  );
}
