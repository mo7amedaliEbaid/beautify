import 'dart:async';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../model/tools/constants/assets.dart';
import '../../../model/tools/entities/AddressEntity/address_entity.dart';
import '../../../model/tools/jsonparse/product_parse.dart';
import '../../profilescreen/address_screen/address_screen.dart';
import '../../widgets/adreebottomsheet_widget.dart';
import '../../widgets/cartbadge_widget.dart';
import '../../widgets/cartitem_widget.dart';
import '../../widgets/dropdowndecoration_widget.dart';
import '../../widgets/editadressbutton_widget.dart';
import '../../widgets/logindialog_widget.dart';
import '../../widgets/productview_widget.dart';
import '../../widgets/snackbar_widget.dart';
import '../cart_screen.dart';
import '../payment_screen/payment_screen.dart';
import 'bloc/checkout_bloc.dart';

class CheckoutScreen extends StatefulWidget {
  final List<ProductEntity> productList;
  final String totalPrice;

  const CheckoutScreen(
      {super.key, required this.productList, required this.totalPrice});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  CheckoutBloc? checkoutBloc;
  StreamSubscription? subscription;

  @override
  void dispose() {
    checkoutBloc?.close();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = CheckoutBloc();
        checkoutBloc = bloc;
        bloc.add(CheckoutStart());
        subscription = bloc.stream.listen((state) {
          if (state is CheckoutGetAddreesScreen) {
            final adNameController = TextEditingController();
            final GlobalKey<FormState> adNameKey = GlobalKey();
            final addressController = TextEditingController();
            final GlobalKey<FormState> addressKey = GlobalKey();
            final stateController = TextEditingController();
            final postalController = TextEditingController();
            final GlobalKey<FormState> postalKey = GlobalKey();
            final GlobalKey<FormState> stateKey = GlobalKey();
            final TextEditingController searchController =
                TextEditingController();
            String country = "";
            addAddressBottomSheet(
              scrollPhysics: state.uiDuplicate.defaultScroll,
              osSaveClicked: () {
                if (stateKey.currentState!.validate() &&
                    addressKey.currentState!.validate() &&
                    adNameKey.currentState!.validate() &&
                    postalKey.currentState!.validate()) {
                  if (country.isNotEmpty) {
                    Get.back();
                    checkoutBloc!.add(CheckoutSaveAddress(AddressEntity(
                        addressDetail: addressController.text,
                        country: country,
                        state: stateController.text,
                        addressName: adNameController.text,
                        postalCode: int.parse(postalController.text))));
                  } else {
                    snackBar(
                        title: "Country",
                        message: "Please slecet you're country",
                  );
                  }
                }
              },
              adNameController: adNameController,
              adNameKey: adNameKey,
              stateController: stateController,
              stateKey: stateKey,
              addressController: addressController,
              addressKey: addressKey,
              postalController: postalController,
              postalKey: postalKey,
              dropDown: DropdownButtonFormField2(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
                  isDense: true,
                  hint: Text(
                    "select country",
                  ),
                  dropdownStyleData: DropdownStyleData(
                    maxHeight: Get.size.height * 0.4,
                    decoration: dropDownDecoration(),
                  ),
                  onChanged: (value) {
                    country = value;
                  },
                  dropdownSearchData: DropdownSearchData(
                    searchController: searchController,
                    searchInnerWidgetHeight: 100,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.all(12),
                      child: TextField(
                        controller: searchController,
                        decoration:
                            const InputDecoration(hintText: "search here"),
                      ),
                    ),
                  ),
                  items: state.popupMenuItemList),
            );
          }
        });
        return bloc;
      },
      child: BlocBuilder<CheckoutBloc, CheckoutState>(
        builder: (context, state) {
          if (state is CheckoutInitialScreen) {
            final addresList = state.addressList;
            final duplicateController = state.duplicateController;
            final profileController = state.profileController;
            String addressDetail = "";
            return Scaffold(
              appBar: AppBar(
                centerTitle: true,
                title: Text(
                  "Checkout",
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
              body: Stack(
                children: [
                  Positioned.fill(
                    child: Padding(
                      padding: const EdgeInsets.all(7),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Shipping Address",
                          //  style: textStyle.titleLarge,
                          ),
                          Container(
                            padding: const EdgeInsets.all(12),
                            margin: const EdgeInsets.only(top: 25, bottom: 15),
                            width: Get.mediaQuery.size.width,
                            decoration: BoxDecoration(
                               // color: colors.gray,
                                borderRadius: BorderRadius.circular(15)),
                            child: Row(
                              children: [
                                LottieBuilder.network(
                                  locationLottie,
                                  fit: BoxFit.cover,
                                  alignment: Alignment.centerLeft,
                                  width: 80,
                                  height: 80,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "your address",
                                      /*  style: textStyle.bodyNormal.copyWith(
                                            fontWeight: FontWeight.bold),*/
                                      ),
                                      addresList.isNotEmpty
                                          ? SizedBox(
                                              width: Get.width * 0.45,
                                              height: 50,
                                              child: DropdownButtonFormField2(
                                                decoration: InputDecoration(
                                                    hintText:
                                                        "Select an address",
                                                 /*   hintStyle:
                                                        textStyle.bodySmall*/),
                                                dropdownStyleData:
                                                    DropdownStyleData(
                                                        maxHeight:
                                                            Get.width * 0.6,
                                                        decoration:
                                                            dropDownDecoration()),
                                                isExpanded: true,
                                                items: addresList,
                                                onChanged: (value) {
                                                  addressDetail = value;
                                                },
                                              ),
                                            )
                                          : Text(
                                              "you don't have any address",
                                            //  style: textStyle.bodySmall,
                                            ),
                                    ],
                                  ),
                                ),
                                addressEditButton(
                                    callback: () {
                                      showCupertinoDialog(
                                        context: context,
                                        builder: (context) {
                                          return CupertinoAlertDialog(
                                            title: Text(
                                              "Address",
                                           //   style: textStyle.bodyNormal,
                                            ),
                                            content: const Text(""),
                                            actions: [
                                              CupertinoButton(
                                                child: const Text(
                                                  "Edit address",
                                                ),
                                                onPressed: () {
                                                  Get.until(
                                                      (route) => route.isFirst);
                                                  Get.to(const AddressScreen(),
                                                      curve: Curves
                                                          .easeInToLinear);
                                                },
                                              ),
                                              CupertinoButton(
                                                child: const Text(
                                                  "Add new address",
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                  checkoutBloc!.add(
                                                      CheckoutGetUserAddress());
                                                },
                                              ),
                                              CupertinoButton(
                                                child: const Text(
                                                  "Cancel",
                                                ),
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              )
                                            ],
                                          );
                                        },
                                      );
                                    },
                                 /*   colors: colors,
                                    textStyle: textStyle*/)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10, bottom: 15),
                            child: Divider(
                             // color: colors.captionColor,
                              thickness: 1,
                            ),
                          ),
                          Text(
                            "Order List",
                         //   style: textStyle.titleLarge,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Expanded(
                              child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 100),
                            physics:
                                duplicateController.uiDuplicate.defaultScroll,
                            itemCount: widget.productList.length,
                            itemBuilder: (context, index) {
                              final product = widget.productList[index];
                              return HorizontalProductView(
                             //     colors: colors,
                                  margin: const EdgeInsets.only(
                                      top: 10, bottom: 10),
                                  product: product,
                                 // textStyle: textStyle,
                                  widget: Icon(
                                    CupertinoIcons.shopping_cart,
                                //    color: colors.whiteColor,
                                  ));
                            },
                          ))
                        ],
                      ),
                    ),
                  ),
                  CartBottomItem(
                    //colors: colors,
                    navigateName: "Continue to Payment",
                    //textStyle: textStyle,
                    callback: () {
                      final isLogin = profileController.islogin;
                      if (isLogin) {
                        if (addressDetail.isNotEmpty) {
                          Get.to(PaymentScreen(
                            totalPrice: widget.totalPrice,
                            productList: widget.productList,
                            addressDetail: addressDetail,
                          ));
                        } else {
                          snackBar(
                              title: "Address required",
                              message: "please select an address",
                           //   textStyle: textStyle,
                              /*colors: colors*/);
                        }
                      } else {
                        loginRequiredDialog(/*textStyle: textStyle*/);
                      }
                    },
                  ),
                ],
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
