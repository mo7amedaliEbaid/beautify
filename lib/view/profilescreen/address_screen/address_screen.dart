import 'dart:async';
import 'package:beautify/configs/configs.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import '../../../model/controllers/duplicate_controller.dart';
import '../../../model/tools/constants/assets.dart';
import '../../../model/tools/entities/AddressEntity/address_entity.dart';
import '../../widgets/adreebottomsheet_widget.dart';
import '../../widgets/customloading_widget.dart';
import '../../widgets/dropdowndecoration_widget.dart';
import '../../widgets/duplicatetempelate_widget.dart';
import '../../widgets/editadressbutton_widget.dart';
import '../../widgets/exception_widget.dart';
import '../../widgets/snackbar_widget.dart';
import 'bloc/address_bloc.dart';

class AddressScreen extends StatefulWidget {
  const AddressScreen({super.key});

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  AddressBloc? addressBloc;
  StreamSubscription? subscription;

  @override
  void dispose() {
    addressBloc?.close();
    subscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final duplicateController = Get.find<DuplicateController>();
    return BlocProvider(
      create: (context) {
        final bloc = AddressBloc();
        addressBloc = bloc;
        bloc.add(AddressStart());
        subscription = bloc.stream.listen((state) {
          if (state is AddressEditedSuccessfully) {
            snackBar(
                title: "Address",
                message: "Your address edited successfully",
        );
          }
        });
        return bloc;
      },
      child: BlocBuilder<AddressBloc, AddressState>(
        builder: (context, state) {
          final adNameController = TextEditingController();
          final stateController = TextEditingController();
          final postalController = TextEditingController();
          final searchController = TextEditingController();
          final addressController = TextEditingController();
          final GlobalKey<FormState> adNameKey = GlobalKey();
          final GlobalKey<FormState> addressKey = GlobalKey();
          final GlobalKey<FormState> postalKey = GlobalKey();
          final GlobalKey<FormState> stateKey = GlobalKey();
          String country = "";
          final defaultPhysics = duplicateController.uiDuplicate.defaultScroll;
          Widget dropDown({required List<DropdownMenuItem> countryList}) {
            return DropdownButtonFormField2(
                buttonStyleData: ButtonStyleData(
                  width: AppDimensions.normalize(120),
                ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(AppDimensions.normalize(5))
                  )
                ),
                isDense: true,
                hint: Text(
                  "select country",
                ),
                validator: (value) {
                  if (value == null) {
                    return "please select country";
                  } else {
                    return null;
                  }
                },
                dropdownStyleData: DropdownStyleData(
                    maxHeight: AppDimensions.normalize(120),
                    decoration: dropDownDecoration()),
                onChanged: (value) {
                  country = value;
                },
                dropdownSearchData: DropdownSearchData(
                  searchInnerWidgetHeight:AppDimensions.normalize(100),
                  searchController: searchController,
                  searchInnerWidget: Padding(
                    padding: Space.all(.1,.1),
                    child: TextField(
                      controller: searchController,
                      decoration:
                          const InputDecoration(hintText: "search here"),
                    ),
                  ),
                ),
                items: countryList);
          }

          if (state is AddressDefaultScreen) {
            return DuplicateTemplate(
              title: "My Address",
              child: Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: SizedBox(
                  height: AppDimensions.normalize(22),
                 width: AppDimensions.normalize(60),
                  child: FloatingActionButton.extended(
                      onPressed: () {
                        addAddressBottomSheet(
                            scrollPhysics: defaultPhysics,
                            osSaveClicked: () {
                              if (adNameKey.currentState!.validate() &&
                                  addressKey.currentState!.validate() &&
                                  stateKey.currentState!.validate() &&
                                  postalKey.currentState!.validate()) {
                                if (country.isNotEmpty) {
                                  Get.back();
                                  addressBloc!.add(AddressAddNew(AddressEntity(
                                      addressDetail: addressController.text,
                                      addressName: adNameController.text,
                                      state: stateController.text,
                                      postalCode:
                                          int.parse(postalController.text),
                                      country: country)));
                                } else {
                                  snackBar(
                                      title: "Country",
                                      message: "Please select your country",
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
                            dropDown:
                                dropDown(countryList: state.countryItemList));
                      },
                      label: AutoSizeText(
                        "Add new address",
                        maxLines: 2,
                      )),
                ),
                body: ListView.builder(
                  padding: Space.v,
                  physics: duplicateController.uiDuplicate.defaultScroll,
                  itemCount: state.addressList.length,
                  itemBuilder: (context, index) {
                    final address = state.addressList[index];

                    return Container(
                      decoration: BoxDecoration(
                        color: Color(0xffafc282),
                          borderRadius: BorderRadius.circular(12)),
                      margin: Space.all(.7,.7),
                      padding:Space.all(.8,.2),
                      child: Row(
                        children: [
                          SizedBox(
                            width: AppDimensions.normalize(30),
                            height: AppDimensions.normalize(30),
                            child: CircleAvatar(
                              child: LottieBuilder.network(locationLottie),
                            ),
                          ),
                          Space.x1!,
                          SizedBox(
                            width:AppDimensions.normalize(50),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  address.addressName,
                                  style: AppText.b1b,
                                ),
                                Space.y!,
                                AutoSizeText(
                                  address.addressDetail,
                                  maxLines: 2,
                                 style: AppText.b2b,
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                CupertinoButton(
                                  child: Icon(
                                    CupertinoIcons.delete,
                                  ),
                                  onPressed: () {
                                    showCupertinoDialog(
                                      context: context,
                                      builder: (context) {
                                        return CupertinoAlertDialog(
                                          title: Text(
                                            "Remove address",
                                          ),
                                          content: Text(
                                            "Are you sure to remove address",
                                          ),
                                          actions: [
                                            CupertinoButton(
                                              child: Text(
                                                "Cancel",
                                              ),
                                              onPressed: () {
                                                Get.back();
                                              },
                                            ),
                                            CupertinoButton(
                                              child: Text(
                                                "Yes",
                                              ),
                                              onPressed: () {
                                                Get.back();
                                                addressBloc!.add(AddressRemove(
                                                    address.postalCode));
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                                addressEditButton(
                                    callback: () {
                                      adNameController.text =
                                          address.addressName;
                                      addressController.text =
                                          address.addressDetail;
                                      postalController.text =
                                          address.postalCode.toString();
                                      stateController.text = address.state;

                                      addAddressBottomSheet(
                                        scrollPhysics: defaultPhysics,
                                        osSaveClicked: () {
                                          if (adNameKey.currentState!
                                                  .validate() &&
                                              addressKey.currentState!
                                                  .validate() &&
                                              stateKey.currentState!
                                                  .validate() &&
                                              postalKey.currentState!
                                                  .validate()) {
                                            if (country.isNotEmpty) {
                                              Get.back();
                                              addressBloc!.add(AddressEdit(
                                                  addressEntity: AddressEntity(
                                                      addressDetail:
                                                          addressController
                                                              .text,
                                                      addressName:
                                                          adNameController.text,
                                                      state:
                                                          stateController.text,
                                                      postalCode: int.parse(
                                                          postalController
                                                              .text),
                                                      country: country),
                                                  postalCode:
                                                      address.postalCode));
                                            } else {
                                              snackBar(
                                                  title: "Country",
                                                  message:
                                                      "Please select your country",
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
                                        dropDown: dropDown(
                                            countryList: state.countryItemList),
                                      );
                                    },),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          } else if (state is AddressLoading) {
            return const CustomLoading();
          } else if (state is AddressError) {
            return AppException(
              callback: () {
                addressBloc!.add(AddressStart());
              },
            );
          } else if (state is AddressEmpty) {
            return DuplicateTemplate(
              title: "My Address",
              child: Scaffold(
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerFloat,
                floatingActionButton: SizedBox(
                  height: AppDimensions.normalize(20),
                  width:AppDimensions.normalize(65),
                  child: FloatingActionButton.extended(
                      onPressed: () {
                        addAddressBottomSheet(
                            scrollPhysics: defaultPhysics,
                            osSaveClicked: () {
                              if (adNameKey.currentState!.validate() &&
                                  addressKey.currentState!.validate() &&
                                  stateKey.currentState!.validate() &&
                                  postalKey.currentState!.validate()) {
                                if (country.isNotEmpty) {
                                  Get.back();
                                  addressBloc!.add(AddressAddNew(AddressEntity(
                                      addressDetail: addressController.text,
                                      addressName: adNameController.text,
                                      state: stateController.text,
                                      postalCode:
                                          int.parse(postalController.text),
                                      country: country)));
                                } else {
                                  snackBar(
                                      title: "Country",
                                      message: "Please select your country",
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
                            dropDown: dropDown(countryList: state.countryList));
                      },
                      label: AutoSizeText(
                        "Add new address",
                        maxLines: 2,
                      )),
                ),
                body: Padding(
                  padding: Space.all(1.5,1.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      LottieBuilder.network(
                        emptyListLottie,
                        width: AppDimensions.normalize(125),
                        height: AppDimensions.normalize(110),
                      ),
                      Space.y1!,
                      AutoSizeText(
                        "your address list is empty try to add new one",
                     style: AppText.h3b,
                        maxLines: 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
          return Container();
        },
      ),
    );
  }
}
