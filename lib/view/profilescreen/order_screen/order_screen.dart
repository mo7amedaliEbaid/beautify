import 'package:beautify/configs/configs.dart';
import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../model/tools/constants/assets.dart';
import '../../widgets/customloading_widget.dart';
import '../../widgets/duplicatetempelate_widget.dart';
import '../../widgets/emptyscreen_widget.dart';
import 'bloc/order_bloc.dart';
import 'order_detail_screen.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({super.key});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  OrderBloc? orderBloc;
  @override
  void dispose() {
    orderBloc?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = OrderBloc();
        orderBloc = bloc;
        bloc.add(OrderInitialEvent());
        return bloc;
      },
      child: BlocBuilder<OrderBloc, OrderState>(
        builder: (context, state) {
          if (state is OrderInitialScreen) {
            final duplicateController = state.duplicateController;

            return DuplicateTemplate(
              title: "Order history",
              child: ListView.builder(
                physics: duplicateController.uiDuplicate.defaultScroll,
                itemCount: state.orderHistoryList.length,
                itemBuilder: (context, index) {
                  final order = state.orderHistoryList[index];
                  return Container(
                    margin:Space.all(.8,.8),
                    padding: Space.all(1,1.1),
                    decoration: BoxDecoration(
                      color: Color(0xffc9c88f),
                      borderRadius: BorderRadius.circular(AppDimensions.normalize(7)),
                    ),
                    child: Column(
                      children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: [
                             Text(
                               "Order : ${order.productList[0].id}",
                               style:AppText.b1b,
                             ),
                             CupertinoButton(
                               child: Text(
                                 "View detail",
                                style: AppText.h3b,
                               ),
                               onPressed: () {
                                 Get.to(OrderDetailScreen(
                                     productList: order.productList));
                               },
                             )
                           ],
                         ),
                        orderHistoryItem(
                            rightTitle: order.time.toString().substring(0, 16),
                            leftTitle: "Date :",
                          leftStyle: AppText.b2!,
                          rightStyle:  AppText.b2b!,),
                        orderHistoryItem(
                            rightTitle: order.totalPrice,
                            leftTitle: "Amount :",
                            leftStyle: AppText.b2!,
                            rightStyle:  AppText.b2b!,
                              //  .copyWith(color: colors.captionColor)
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          } else if (state is OrderEmpty) {
            return EmptyScreen(
                title: "Order history",
                content: "Your order history is empty",
                lottieName: emptyListLottie);
          } else if (state is OrderLoading) {
            return const CustomLoading();
          }
          return Container();
        },
      ),
    );
  }

  Widget orderHistoryItem(
      {required String rightTitle,
      required String leftTitle,
      required TextStyle leftStyle,
      required TextStyle rightStyle}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          leftTitle,
          style: leftStyle,
        ),
        Text(
          rightTitle,
          style: rightStyle,
        )
      ],
    );
  }
}
