import '../view/cart.dart';

import '../model/order.dart';
import '../model/user.dart';
import '../presenter/user_presenter.dart';
import '../route/route_manager.dart';

import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'delivery_address_widget.dart';

class OrderDeliveryAddressWidget extends StatefulWidget {

  @override
  _OrderDeliveryAddressWidgetState createState() => _OrderDeliveryAddressWidgetState();
}

class _OrderDeliveryAddressWidgetState extends State<OrderDeliveryAddressWidget> with ChangeNotifier {

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        ValueListenableBuilder(
          valueListenable: order,
          builder: (BuildContext context, Order order, _) {

            return Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Container(
                  height: 2.5 * SizeConfig.heightSizeMultiplier,
                  color: Theme.of(context).hintColor,
                ),

                SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

                Padding(
                  padding: EdgeInsets.only(
                    left: 5.12 * SizeConfig.widthSizeMultiplier,
                    right: 5.12 * SizeConfig.widthSizeMultiplier,
                  ),
                  child: Text(AppLocalization.of(context).getTranslatedValue("delivery_address"),
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),

                SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

                Container(
                  height: .25 * SizeConfig.heightSizeMultiplier,
                  color: Theme.of(context).hintColor,
                ),

                SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

                Padding(
                  padding: EdgeInsets.only(
                    left: 5.12 * SizeConfig.widthSizeMultiplier,
                    right: 5.12 * SizeConfig.widthSizeMultiplier,
                  ),
                  child: Row(
                    children: [

                      ValueListenableBuilder(
                        valueListenable: currentUser,
                        builder: (BuildContext context, User user, _) {

                          return Visibility(
                            visible: user.addresses.list.length > 1,
                            child: Padding(
                              padding: EdgeInsets.only(
                                right: 5.12 * SizeConfig.widthSizeMultiplier,
                              ),
                              child: GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {

                                  Navigator.of(context).pushNamed(RouteManager.SELECT_ADDRESS);
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    top: 1 * SizeConfig.heightSizeMultiplier,
                                    bottom: 1 * SizeConfig.heightSizeMultiplier,
                                    left: 2.56 * SizeConfig.widthSizeMultiplier,
                                    right: 2.56 * SizeConfig.widthSizeMultiplier,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(.45 * SizeConfig.heightSizeMultiplier),
                                    border: Border.all(color: Colors.black26, width: .254 * SizeConfig.widthSizeMultiplier),
                                  ),
                                  child: Container(
                                    padding: EdgeInsets.all(.1 * SizeConfig.heightSizeMultiplier),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(.75 * SizeConfig.heightSizeMultiplier),
                                      border: Border.all(color: Colors.black38, width: .384 * SizeConfig.widthSizeMultiplier),
                                    ),
                                    child: Icon(Icons.location_on,
                                      size: 5 * SizeConfig.widthSizeMultiplier,
                                      color: Colors.black38,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),

                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {

                          Navigator.of(context).pushNamed(RouteManager.MY_ADDRESS);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            top: 1 * SizeConfig.heightSizeMultiplier,
                            bottom: 1 * SizeConfig.heightSizeMultiplier,
                            left: 2.56 * SizeConfig.widthSizeMultiplier,
                            right: 2.56 * SizeConfig.widthSizeMultiplier,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(.45 * SizeConfig.heightSizeMultiplier),
                            border: Border.all(color: Colors.black26, width: .254 * SizeConfig.widthSizeMultiplier),
                          ),
                          child: Container(
                            padding: EdgeInsets.all(.1 * SizeConfig.heightSizeMultiplier),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(.75 * SizeConfig.heightSizeMultiplier),
                              border: Border.all(color: Colors.black38, width: .384 * SizeConfig.widthSizeMultiplier),
                            ),
                            child: Icon(Icons.add,
                              size: 5 * SizeConfig.widthSizeMultiplier,
                              color: Colors.black38,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

                Visibility(
                  visible: order.address != null,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 1.5 * SizeConfig.heightSizeMultiplier,
                      right: 1.5 * SizeConfig.heightSizeMultiplier,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[

                        DeliveryAddressWidget(order.address, true),

                        SizedBox(height: 1.875 * SizeConfig.heightSizeMultiplier,),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}