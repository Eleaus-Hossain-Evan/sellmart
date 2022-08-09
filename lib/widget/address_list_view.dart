import 'package:app/utils/constants.dart';
import 'package:app/view/home.dart';
import 'package:logger/logger.dart';

import '../localization/app_localization.dart';
import '../model/address.dart';
import '../model/user.dart';
import '../presenter/user_presenter.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'custom_dialog.dart';
import 'delivery_address_widget.dart';

import '../view/cart.dart';
import '../model/order.dart';

class AddressListView extends StatefulWidget {
  final void Function(Address) onEdit;
  final void Function(String addressID) onDelete;

  AddressListView({this.onEdit, this.onDelete});

  @override
  _AddressListViewState createState() => _AddressListViewState();
}

class _AddressListViewState extends State<AddressListView> with ChangeNotifier {
  ValueNotifier<int> addressIndex = ValueNotifier(1);

  @override
  Widget build(BuildContext context) {
    // if (currentUser.value.addresses.list.length < 0) {
    //   _onSelected(currentUser.value.addresses.list[addressIndex.value]);
    // }
    return Padding(
      padding: EdgeInsets.only(
        bottom: .5 * SizeConfig.heightSizeMultiplier,
      ),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return;
        },
        child: ValueListenableBuilder(
            valueListenable: order,
            builder: (BuildContext context, Order orderData, _) {
              return ValueListenableBuilder(
                valueListenable: currentUser,
                builder: (BuildContext context, User user, _) {
                  return user.addresses.list.length > 1
                      ? ListView.separated(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: user.addresses.list.length,
                          padding: EdgeInsets.only(
                              // top: 1.25 * SizeConfig.heightSizeMultiplier,
                              left: 2.9 * SizeConfig.widthSizeMultiplier,
                              right: 2.9 * SizeConfig.widthSizeMultiplier),
                          separatorBuilder: (context, index) {
                            return SizedBox(
                                height: 2 * SizeConfig.heightSizeMultiplier);
                          },
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  addressIndex.value = index;
                                  _onSelected(
                                      user.addresses.list[addressIndex.value]);
                                });
                                // print(user.addresses.list[index].division);
                                // print("order=> ${order.address.name}");
                                // print(
                                //     "order=> ${addressIndex.value} == ${index}");
                              },
                              child: DeliveryAddressWidget(
                                user.addresses.list[index],
                                addressIndex.value == index,
                                onEdit: (Address address) {
                                  widget.onEdit(address);
                                },
                                onDelete: (String addressID) {
                                  _showConfirmationDialog(context, addressID);
                                },
                              ),
                            );
                          },
                        )
                      : Center(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: 2 * SizeConfig.widthSizeMultiplier,
                            ),
                            child: Text("No Address Added"),
                          ),
                        );
                },
              );
            }),
      ),
    );
  }

  void _onSelected(Address address) {
    order.value.address = address;

    Logger().wtf(address.toString());

    if (address.district.toLowerCase() == "dhaka" ||
        address.district.toLowerCase() == "ঢাকা") {
      order.value.deliveryFee = info.value.deliveryChargeInsideDhaka ?? 90;
      order.value.deliveryType = Constants.INSIDE_DHAKA;
      debugPrint('order.value.deliveryType: ${order.value.deliveryType}');
    } else {
      order.value.deliveryFee = info.value.deliveryChargeOutsideDhaka ?? 150;
      order.value.deliveryType = Constants.OUTSIDE_DHAKA;
      debugPrint('order.value.deliveryType: ${order.value.deliveryType}');
    }

    order.notifyListeners();
    // Navigator.pop(context);
  }

  Future<Widget> _showConfirmationDialog(
      BuildContext context, String addressID) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: AppLocalization.of(context).getTranslatedValue("warning"),
            message: AppLocalization.of(context)
                .getTranslatedValue("confirm_address_delete"),
            onPositiveButtonPress: () {
              widget.onDelete(addressID);
            },
          );
        });
  }

  void init() {
    // if (currentUser.value.addresses.list.length == 0) {
    //   currentUser.value.addresses.list.add(Address());
    // }
  }
}
