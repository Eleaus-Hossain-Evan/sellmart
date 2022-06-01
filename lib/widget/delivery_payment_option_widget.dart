import '../view/cart.dart';
import '../view/home.dart';

import '../model/order.dart';
import '../model/payment_option.dart';
import '../resources/images.dart';
import '../utils/constants.dart';

import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class DeliveryPaymentOptionWidget extends StatefulWidget {

  final void Function() onSelected;

  DeliveryPaymentOptionWidget({this.onSelected});

  @override
  _DeliveryPaymentOptionWidgetState createState() => _DeliveryPaymentOptionWidgetState();
}

class _DeliveryPaymentOptionWidgetState extends State<DeliveryPaymentOptionWidget> with ChangeNotifier {

  List<PaymentOption> _options = List();

  @override
  void initState() {

    WidgetsBinding.instance.addPostFrameCallback((_) {

      _init();
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return ValueListenableBuilder(
      valueListenable: order,
      builder: (BuildContext context, Order order, _) {

        return Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[

            SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

            Padding(
              padding: EdgeInsets.only(
                left: 5.12 * SizeConfig.widthSizeMultiplier,
                right: 5.12 * SizeConfig.widthSizeMultiplier,
              ),
              child: Text(AppLocalization.of(context).getTranslatedValue("payment_method"),
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),

            SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

            Padding(
              padding: EdgeInsets.only(
                left: 5.12 * SizeConfig.widthSizeMultiplier,
                right: 5.12 * SizeConfig.widthSizeMultiplier,
              ),
              child: ListView.separated(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _options.length,
                separatorBuilder: (BuildContext context, int index) {

                  return SizedBox(height: 1 * SizeConfig.heightSizeMultiplier,);
                },
                itemBuilder: (BuildContext context, int index) {

                  return GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {

                      _onPaymentOptionSelected(_options[index]);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                        top: 1.25 * SizeConfig.heightSizeMultiplier,
                        bottom: 1.25 * SizeConfig.heightSizeMultiplier,
                        left: 3 * SizeConfig.widthSizeMultiplier,
                        right: 3 * SizeConfig.widthSizeMultiplier,
                      ),
                      decoration: BoxDecoration(
                        color: order.paymentOption != null && order.paymentOption.id == _options[index].id ? Theme.of(context).primaryColor : Colors.transparent,
                        borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
                        border: Border.all(color: order.paymentOption != null && order.paymentOption.id == _options[index].id ? Colors.transparent : Colors.black12,
                          width: .35 * SizeConfig.widthSizeMultiplier,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [

                                _options[index].icon,
                              ],
                            ),
                          ),

                          Expanded(
                            flex: 4,
                            child: Text(_options[index].name,
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: order.paymentOption != null && order.paymentOption.id == _options[index].id ? Colors.white : Colors.black,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),

                          Expanded(
                            flex: 1,
                            child: Column(
                              children: [

                                Container(
                                  padding: EdgeInsets.all(.25 * SizeConfig.heightSizeMultiplier),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(.75 * SizeConfig.heightSizeMultiplier),
                                    border: Border.all(color: order.paymentOption != null && order.paymentOption.id == _options[index].id ? Colors.white : Colors.black12,
                                      width: .384 * SizeConfig.widthSizeMultiplier,
                                    ),
                                  ),
                                  child: Icon(Icons.check,
                                    size: 6 * SizeConfig.widthSizeMultiplier,
                                    color: order.paymentOption != null && order.paymentOption.id == _options[index].id ? Colors.white : Colors.transparent,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

            Container(
              height: 2.5 * SizeConfig.heightSizeMultiplier,
              color: Theme.of(context).hintColor,
            ),
          ],
        );
      },
    );
  }


  void _onPaymentOptionSelected(PaymentOption option) {

    order.value.paymentOption = option;
    order.notifyListeners();

    widget.onSelected();
  }


  void _init() {

    setState(() {
      _options.add(PaymentOption(id: Constants.CASH_ON_DELIVERY, name: AppLocalization.of(context).getTranslatedValue("cod"), icon: Image.asset(Images.cash, height: 3.75 * SizeConfig.heightSizeMultiplier, width: 7.69 * SizeConfig.widthSizeMultiplier, fit: BoxFit.fill)));
    });

    if(info.value != null && info.value.onlinePaymentActive != null && info.value.onlinePaymentActive) {

      setState(() {
        _options.add(PaymentOption(id: Constants.ONLINE_PAYMENT, name: AppLocalization.of(context).getTranslatedValue("online_payment"), icon: Image.asset(Images.onlinePayment, height: 3.75 * SizeConfig.heightSizeMultiplier, width: 7.69 * SizeConfig.widthSizeMultiplier, fit: BoxFit.fill)));
      });
    }
  }
}