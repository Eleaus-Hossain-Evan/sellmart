import '../model/address.dart';
import '../model/user.dart';
import '../presenter/user_presenter.dart';
import '../utils/constants.dart';
import '../widget/delivery_address_widget.dart';

import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import '../widget/my_app_bar.dart';
import '../view/home.dart';
import 'package:flutter/material.dart';

import 'cart.dart';

class SelectDeliveryAddress extends StatefulWidget {

  @override
  _SelectDeliveryAddressState createState() => _SelectDeliveryAddressState();
}

class _SelectDeliveryAddressState extends State<SelectDeliveryAddress> with ChangeNotifier {

  @override
  Widget build(BuildContext context) {

    return WillPopScope(
      onWillPop: _onBackPress,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: Builder(
          builder: (BuildContext context) {

            return SafeArea(
              child: Column(
                children: <Widget>[

                  MyAppBar(AppLocalization.of(context).getTranslatedValue("select_delivery_address"),
                    onBackPress: () {

                      FocusManager.instance.primaryFocus?.unfocus();
                      _onBackPress();
                    },
                  ),

                  Expanded(
                    child: NotificationListener<OverscrollIndicatorNotification>(
                      onNotification: (overScroll) {
                        overScroll.disallowGlow();
                        return;
                      },
                      child: ValueListenableBuilder(
                        valueListenable: currentUser,
                        builder: (BuildContext context, User user, _) {

                          return ListView.separated(
                            itemCount: user.addresses.list.length,
                            padding: EdgeInsets.only(
                                top: 1.25 * SizeConfig.heightSizeMultiplier,
                                left: 2.9 * SizeConfig.widthSizeMultiplier,
                                right: 2.9 * SizeConfig.widthSizeMultiplier
                            ),
                            separatorBuilder: (context, index) {

                              return SizedBox(height: 2 * SizeConfig.heightSizeMultiplier);
                            },
                            itemBuilder: (context, index) {

                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {

                                  _onSelected(user.addresses.list[index]);
                                },
                                child: DeliveryAddressWidget(user.addresses.list[index], true),
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }


  Future<bool> _onBackPress() {

    Navigator.pop(context);
    return Future(() => false);
  }


  void _onSelected(Address address) {

    order.value.address = address;

    if(address.district.toLowerCase() == "dhaka" || address.district.toLowerCase() == "ঢাকা") {

      order.value.deliveryFee = info.value.deliveryChargeOutsideDhaka ?? 90;
      order.value.deliveryType = Constants.INSIDE_DHAKA;
    }
    else {

      order.value.deliveryFee = info.value.deliveryChargeOutsideDhaka ?? 150;
      order.value.deliveryType = Constants.OUTSIDE_DHAKA;
    }

    order.notifyListeners();
    Navigator.pop(context);
  }
}