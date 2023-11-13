import 'dart:io';

import 'package:badges/badges.dart' as badges;
import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import '../../model/controllers/profile_controller.dart';
import '../../viewmodel/profile/profile.dart';
import '../widgets/duplicatetempelate_widget.dart';
import '../widgets/logindialog_widget.dart';
import 'address_screen/address_screen.dart';
import 'auth_screen/authentication_screen.dart';
import 'favourites_screen/favorite_screen.dart';
import 'order_screen/order_screen.dart';
import 'package:beautify/configs/configs.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.find<ProfileController>();
    final ProfileFunctions profileFunctions =
        profileController.profileFunctions;
    return DuplicateTemplate(
        title: "Profile",
        child: Padding(
          padding: Space.all(.8, .8),
          child: Column(
            children: [
              badges.Badge(
                position: BadgePosition.bottomEnd(),
                badgeContent: SizedBox(
                    width: 30,
                    height: 30,
                    child: Center(
                      child: InkWell(
                        onTap: () async {
                          await profileFunctions.getUserImage();
                          profileController.userSetImageInstance
                              .update((val) {});
                        },
                        child: Icon(
                          CupertinoIcons.switch_camera,
                          size: 20,
                        ),
                      ),
                    )),
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                      color: Color(0xFC8F6E81), shape: BoxShape.circle),
                  child: profileImage(),
                ),
              ),
              Padding(
                padding: Space.all(1, 1.5),
                child: Column(
                  children: [
                    profileName(profileController: profileController),
                    Space.y!,
                    profileEmail(profileController: profileController)
                  ],
                ),
              ),
              profileItem(
                callback: () {
                  Get.to(const FavoriteScreen());
                },
                itemName: "Favourits",
              ),
              profileItem(
                callback: () {
                  bool isLogin = profileController.islogin;
                  if (isLogin) {
                    Get.to(const AddressScreen());
                  } else {
                    loginRequiredDialog();
                  }
                },
                itemName: "My Address",
              ),
              profileItem(
                callback: () {
                  bool isLogin = profileController.islogin;
                  if (isLogin) {
                    Get.to(const OrderScreen());
                  } else {
                    loginRequiredDialog();
                  }
                },
                itemName: "Order History",
              ),
              Obx(
                () => profileItem(
                  callback: () {
                    final isLogin =
                        profileController.authenticationFunctions.isUserLogin();
                    if (isLogin) {
                      showCupertinoDialog(
                        context: context,
                        builder: (context) {
                          return CupertinoAlertDialog(
                            title: Text(
                              "Log Out",
                            ),
                            content: Text(
                              "Are you sure you want log out?",
                              overflow: TextOverflow.clip,
                              textAlign: TextAlign.start,
                            ),
                            actions: [
                              CupertinoButton(
                                child: Text(
                                  "No",
                                ),
                                onPressed: () async {
                                  Get.back();
                                },
                              ),
                              CupertinoButton(
                                child: Text(
                                  "yes",
                                ),
                                onPressed: () async {
                                  await profileController
                                      .authenticationFunctions
                                      .signOut();
                                  Get.back();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    } else {
                      Get.to(const AuthenticationScreen());
                    }
                  },
                  itemName: signStatus(profileController: profileController),
                ),
              ),
            ],
          ),
        ));
  }

  Widget profileImage() {
    return GetX<ProfileController>(
      builder: (controller) {
        if (controller.userSetImage) {
          final File file = controller.profileFunctions.imageFile()!;
          return ClipRRect(
            borderRadius: BorderRadius.circular(AppDimensions.normalize(50)),
            child: Image.file(
              file,
              fit: BoxFit.cover,
            ),
          );
        } else {
          return Icon(
            CupertinoIcons.person_alt_circle,
            size: 40,
          );
        }
      },
    );
  }

  Widget profileName({required ProfileController profileController}) {
    return Obx(() {
      if (profileController.islogin) {
        return Text(
          profileController.information.name,
          style: AppText.h3b,
        );
      } else {
        return Text(
          "Mohamed Ali",
          style: AppText.h3b,
        );
      }
    });
  }

  Widget profileEmail({required ProfileController profileController}) {
    return Obx(() {
      if (profileController.islogin) {
        return Text(
          profileController.information.userName,
          style: AppText.b1b,
        );
      } else {
        return Text(
          "mo7amedaliebaid@gmail.com",
          style: AppText.b1b,
        );
      }
    });
  }

  Widget profileItem(
      {required String itemName, required GestureTapCallback callback}) {
    return Padding(
      padding: Space.all(.3, .2),
      child: Column(
        children: [
          Container(
            padding: Space.h,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemName,
                  style: AppText.b1b,
                ),
                CupertinoButton(
                  onPressed: callback,
                  child: Icon(
                    CupertinoIcons.right_chevron,
                  ),
                )
              ],
            ),
          ),
          Container(
            height: 1,
            width: Get.mediaQuery.size.width,
            color: Colors.red,
          )
        ],
      ),
    );
  }

  String signStatus({required ProfileController profileController}) {
    final bool isLogin =
        profileController.authenticationFunctions.isUserLogin();
    if (isLogin) {
      return "Log out";
    } else {
      return "Login";
    }
  }
}
