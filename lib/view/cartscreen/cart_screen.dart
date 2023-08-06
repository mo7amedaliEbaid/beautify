import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:beautify/configs/configs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../model/controllers/duplicate_controller.dart';
import '../../model/tools/constants/assets.dart';
import '../widgets/cartbottomitem_widget.dart';
import '../widgets/customloading_widget.dart';
import '../widgets/duplicatetempelate_widget.dart';
import '../widgets/emptyscreen_widget.dart';
import '../widgets/exception_widget.dart';
import '../widgets/productview_widget.dart';
import 'bloc/cart_bloc.dart';
import 'checout_screen/check_screen.dart';

CartBloc? cartBloc;

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void dispose() {
    cartBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = CartBloc();
        bloc.add(CartStart());
        cartBloc = bloc;
        return bloc;
      },
      child: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          final duplicateController = Get.find<DuplicateController>();
          final uiDuplicate = duplicateController.uiDuplicate;
          if (state is CartSuccess) {
            final productList = state.productList;
            final String totalPrice = state.totalPrice;
            return DuplicateTemplate(
                title:"Cart Screen",
                child: Stack(
                    children: [
                      Positioned.fill(
                        bottom: AppDimensions.normalize(30),
                        child: ListView.builder(
                          physics: uiDuplicate.defaultScroll,
                          itemCount: productList.length,
                          itemBuilder: (context, index) {
                            final product = productList[index];
                            return HorizontalProductView(
                                margin: Space.all(.5,.5),
                                product: product,
                                widget: CupertinoButton(
                                    child: Icon(
                                      Icons.delete,
                                    ),
                                    onPressed: () async {
                                      final bool isDeleted =
                                          await duplicateController
                                              .cartFunctions
                                              .deleteProduct(index: index);
                                      if (isDeleted) {
                                        Get.snackbar("Delete", "",
                                            messageText: Text(
                                              "Product removed successfully",
                                            ),
                                        );
                                        cartBloc!.add(CartStart());
                                      }
                                    }),
                              );
                          },
                        ),
                      ),
                      CartBottomItem(
                        navigateName: "Checkout",
                        widget: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Total price",
                          style: AppText.h2b,
                            ),
                          Space.y!,
                            SizedBox(
                              width: AppDimensions.normalize(55),
                              child: AutoSizeText(
                                "€$totalPrice",
                                maxFontSize: 25,
                                minFontSize: 16,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                        callback: () {
                          Get.to(CheckoutScreen(
                              productList: productList,
                              totalPrice: totalPrice));
                        },
                      ),
                    ],
                  ));
          } else if (state is CartLoading) {
            return const CustomLoading();
          } else if (state is CartError) {
            return AppException(
              callback: () {
                cartBloc!.add(CartStart());
              },
            );
          } else if (state is CartEmpty) {
            return EmptyScreen(
              lottieName: emptyCartLottie,
              content: "your cart is empty , try to add something",
              title: "My cart",
            );
          }
          return Container();
        },
      ),
    );
  }
}
