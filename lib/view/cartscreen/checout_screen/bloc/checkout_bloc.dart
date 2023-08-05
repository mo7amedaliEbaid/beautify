import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';

import '../../../../model/controllers/duplicate_controller.dart';
import '../../../../model/controllers/profile_controller.dart';
import '../../../../model/tools/entities/AddressEntity/address_entity.dart';
import '../../../../model/tools/entities/entities.dart';




part 'checkout_event.dart';
part 'checkout_state.dart';

class CheckoutBloc extends Bloc<CheckoutEvent, CheckoutState> {
  CheckoutBloc() : super(CheckoutInitial()) {
    on<CheckoutEvent>((event, emit) async {
      final duplicateController = Get.find<DuplicateController>();
      final profileController = Get.find<ProfileController>();
      final addressFunctions = profileController.addressFunctions;

      if (event is CheckoutStart) {
        final addressList = await addressFunctions.addressItemList(
            /*textStyle: duplicateController.textStyle*/);
        emit(CheckoutInitialScreen(
            addressList: addressList,
            duplicateController: duplicateController,
            profileController: profileController));
      } else if (event is CheckoutGetUserAddress) {
        final popupMenuItemList = await addressFunctions.countryMenuList(
         /*   textStyle: duplicateController.textStyle*/);
        emit(CheckoutGetAddreesScreen(
          uiDuplicate: duplicateController.uiDuplicate,
            popupMenuItemList: popupMenuItemList,
          //  textStyle: duplicateController.textStyle,
            /*colors: duplicateController.colors*/));

        final addressList = await addressFunctions.addressItemList(
        /*    textStyle: duplicateController.textStyle*/);
        emit(CheckoutInitialScreen(
            addressList: addressList,
            duplicateController: duplicateController,
            profileController: profileController));
      } else if (event is CheckoutSaveAddress) {
        await addressFunctions.addToAddressBox(
            addressEntity: event.addressEntity);

        final addressList = await addressFunctions.addressItemList(
         /*   textStyle: duplicateController.textStyle*/);
        emit(CheckoutInitialScreen(
            duplicateController: duplicateController,
            profileController: profileController,
            addressList: addressList));
      }
    });
  }
}
