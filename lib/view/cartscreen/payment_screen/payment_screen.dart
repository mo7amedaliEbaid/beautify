import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beautify/configs/configs.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../model/controllers/duplicate_controller.dart';
import '../../../model/controllers/profile_controller.dart';
import '../../../model/tools/entities/OrderEntity/order_entity.dart';
import '../../../model/tools/jsonparse/product_parse.dart';
import '../../rootscreen/root.dart';
import '../../widgets/snackbar_widget.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen(
      {super.key,
      required this.totalPrice,
      required this.productList,
      required this.addressDetail});
  final String totalPrice;
  final List<ProductEntity> productList;
  final String addressDetail;
  @override
  Widget build(BuildContext context) {
    final duplicateController = Get.find<DuplicateController>();
    final profileController = Get.find<ProfileController>();
    final paymentFunctions = duplicateController.paymentFunctions;
    final DateTime dateTime = DateTime.now();

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        height: AppDimensions.normalize(20),
        width: Get.mediaQuery.size.width * 0.6,
        child: FloatingActionButton.extended(
            onPressed: () {
              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(
                      "Pay",
                    ),
                    content: Text(
                      "Do you want pay?",
                    ),
                    actions: [
                      CupertinoButton(
                        child: const Text("No"),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                      CupertinoButton(
                        child: const Text("Yes"),
                        onPressed: () async {
                          await profileController.orderFunctions.addToOrderBox(
                              orderEntity: OrderEntity(
                                  time: dateTime,
                                  totalPrice: totalPrice,
                                  productList: productList));
                          bool isCommpleated = await duplicateController
                              .cartFunctions
                              .clearCartBox();

                          if (isCommpleated) {
                            Get.offAll(const RootScreen(
                              index: 1,
                            ));

                            snackBar(
                                title: "Pay",
                                message: "Successfully payed",
                         );
                          }
                        },
                      ),
                    ],
                  );
                },
              );
            },
            label: Text(
              "Pay",
            )),
      ),
      appBar: AppBar(
        centerTitle: true,
        automaticallyImplyLeading: true,
        title: Text(
          "E-Payment",
        ),
      ),
      body: Padding(
        padding:Space.v1!,
        child: SingleChildScrollView(
          physics: duplicateController.uiDuplicate.defaultScroll,
          child: Column(
            children: [
              Space.y1!,
              Align(
                alignment: Alignment.center,
                child: SvgPicture.string(
                  paymentFunctions.createBarcode(),
                ),
              ),
              Space.y1!,
              duplicateContainer(
                widget: Column(
                  children: [
                    SizedBox(
                      height: AppDimensions.normalize(40),
                      width: Get.mediaQuery.size.width * 0.8,
                      child: GridView.builder(
                        physics: duplicateController.uiDuplicate.defaultScroll,
                        itemCount: productList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 5,
                                mainAxisSpacing: 10,
                                crossAxisSpacing: 10),
                        itemBuilder: (context, index) {
                          return SizedBox(
                            height: AppDimensions.normalize(20),
                            child: CircleAvatar(
                              foregroundImage: CachedNetworkImageProvider(
                                  productList[index].imageUrl),
                            ),
                          );
                        },
                      ),
                    ),
                   Space.y!,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                            width: AppDimensions.normalize(100),
                            child: Row(
                              children: [
                                Text(
                                  productList[0].name.substring(0, 10),
                                  overflow: TextOverflow.clip,
                                  textAlign: TextAlign.start,
                                  style: AppText.b1b,
                                ),
                                Space.x!,
                                Text(
                                  "and more",
                                ),
                              ],
                            )),
                        Column(
                          children: [
                            Icon(
                              CupertinoIcons.number_circle,
                              size: 20,
                            ),
                            Text(
                              "Count : ${productList.length}",
                             style: AppText.h3b
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
              duplicateContainer(
                  widget: Column(
                    children: [
                      duplicateRowItem(
                          prefix: Text(
                            "Recipient Name",
                          ),
                          suffix: Text(
                            profileController.information.name,
                          )),
                      duplicateRowItem(
                          prefix: Text(
                            "Address",
                          ),
                          suffix: Text(
                            addressDetail,
                          )),
                      duplicateRowItem(
                          prefix: Text(
                            "Payment Methods",
                          ),
                          suffix: Text(
                            "My E-Wallet",
                          )),
                      duplicateRowItem(
                          prefix: Text(
                            "Date",
                          ),
                          suffix: Text(
                            dateTime.toString().substring(0, 16),
                          )),
                      duplicateRowItem(
                          prefix: Text(
                            "Total",
                          ),
                          suffix: Text(
                            "€$totalPrice",
                            style: AppText.h3b,
                          )),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget duplicateContainer(
      {required Widget widget}) {
    return Container(
        width: AppDimensions.size?.width,
        margin: Space.all(.5,.5),
        padding: Space.all(.5,.5),
        child: widget);
  }

  Widget duplicateRowItem(
      {required Widget prefix,
      required Widget suffix,
   }) {
    return Column(
      children: [
        Padding(
          padding: Space.all(.5,.5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [prefix, suffix],
          ),
        ),
        Space.y!,
        Divider(
          thickness: 0.5,
          height: 1,
        //  color: colors.captionColor,
        )
      ],
    );
  }
}
