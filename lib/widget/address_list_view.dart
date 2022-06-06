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
  ValueNotifier<int> addressIndex = ValueNotifier(0);
  @override
  void initState() {
    init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: 8.5 * SizeConfig.heightSizeMultiplier,
      ),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return;
        },
        child: ValueListenableBuilder(
          valueListenable: order,
          builder: (BuildContext context, Order order, _) {
            return ValueListenableBuilder(
              valueListenable: currentUser,
              builder: (BuildContext context, User user, _) {
                return ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: user.addresses.list.length,
                  padding: EdgeInsets.only(
                      top: 1.25 * SizeConfig.heightSizeMultiplier,
                      left: 2.9 * SizeConfig.widthSizeMultiplier,
                      right: 2.9 * SizeConfig.widthSizeMultiplier),
                  separatorBuilder: (context, index) {
                    return SizedBox(height: 2 * SizeConfig.heightSizeMultiplier);
                  },
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          order.address = user.addresses.list[index];
                          addressIndex.value = index;
                          
                        });
                        print(user.addresses.list[index].division);
                        print("order=> ${order.address.division}");
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
                );
              },
            );
          }
        ),
      ),
    );
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
    if (currentUser.value.addresses.list.length == 0) {
      currentUser.value.addresses.list.add(Address());
    }
  }
}
