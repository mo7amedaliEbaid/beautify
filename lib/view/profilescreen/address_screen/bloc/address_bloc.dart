import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import '../../../../model/controllers/profile_controller.dart';
import '../../../../model/tools/entities/AddressEntity/address_entity.dart';




part 'address_event.dart';
part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  AddressBloc() : super(AddressInitial()) {
    on<AddressEvent>((event, emit) async {
      final profileController = Get.find<ProfileController>();
      final addressFunctions = profileController.addressFunctions;
      try {
        if (event is AddressStart) {
          emit(AddressLoading());
          final addressList = await addressFunctions.getAddressList();
          final countryItemList =
              await addressFunctions.countryMenuList();
          if (addressList.isNotEmpty) {
            emit(AddressDefaultScreen(
                addressList:addressList, countryItemList: countryItemList));
          } else {
            emit(AddressEmpty(countryItemList));
          }
        } else if (event is AddressRemove) {
          emit(AddressLoading());
          final isCompleted = await addressFunctions.removeAddress(
              postalCode: event.postalCode);
          if (isCompleted) {
            final addressList = await addressFunctions.getAddressList();
            final countryItemList =
                await addressFunctions.countryMenuList();
            if (addressList.isNotEmpty) {
              emit(AddressDefaultScreen(
                  addressList: addressList, countryItemList: countryItemList));
            } else {
              emit(AddressEmpty(countryItemList));
            }
          } else {
            emit(AddressError());
          }
        } else if (event is AddressEdit) {
          emit(AddressLoading());
          bool isCompleted = await addressFunctions.editAddress(
              addressEntity: event.addressEntity, postalCode: event.postalCode);
          if (isCompleted) {
            final addressList = await addressFunctions.getAddressList();
            final countryItemList =
                await addressFunctions.countryMenuList();
            emit(AddressEditedSuccessfully());
            emit(AddressDefaultScreen(
                addressList: addressList, countryItemList: countryItemList));
          } else {
            emit(AddressError());
          }
        } else if (event is AddressAddNew) {
          emit(AddressLoading());
          await addressFunctions.addToAddressBox(
              addressEntity: event.addressEntity);
          final addressList = await addressFunctions.getAddressList();
          final countryItemList =
              await addressFunctions.countryMenuList();
          emit(AddressDefaultScreen(
              addressList: addressList, countryItemList: countryItemList));
        }
      } catch (e) {
        emit(AddressError());
      }
    });
  }
}
