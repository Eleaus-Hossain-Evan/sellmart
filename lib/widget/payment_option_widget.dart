import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

ValueNotifier<int> paymentValue = ValueNotifier(-1);
ValueNotifier<int> deliveryValue = ValueNotifier(-1);

class PaymentOptionWidget extends StatefulWidget {

  @override
  _PaymentOptionWidgetState createState() => _PaymentOptionWidgetState();
}

class _PaymentOptionWidgetState extends State<PaymentOptionWidget> {

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(bottom: 2.5 * SizeConfig.heightSizeMultiplier),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[

          Expanded(
            flex: 2,
            child: Column(
              children: <Widget>[

                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 3.84 * SizeConfig.widthSizeMultiplier),
                      child: Text(AppLocalization.of(context).getTranslatedValue("payment_method"),
                        style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 2,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.25 * SizeConfig.heightSizeMultiplier),
                      border: Border.all(color: Colors.grey[300], width: .33 * SizeConfig.widthSizeMultiplier),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        _paymentRadioButton(AppLocalization.of(context).getTranslatedValue("cod"), 0),

                        Container(
                          height: .125 * SizeConfig.heightSizeMultiplier,
                          color: Colors.grey[300],
                        ),

                        _paymentRadioButton(AppLocalization.of(context).getTranslatedValue("online_payment"), 1),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 10,),

          Expanded(
            flex: 3,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[

                Expanded(
                  flex: 1,
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(left: 3.84 * SizeConfig.widthSizeMultiplier),
                      child: Text(AppLocalization.of(context).getTranslatedValue("delivery_option"),
                        style: Theme.of(context).textTheme.headline5.copyWith(
                          color: Colors.blueGrey,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),

                Expanded(
                  flex: 3,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(1.25 * SizeConfig.heightSizeMultiplier),
                      border: Border.all(color: Colors.grey[300], width: .33 * SizeConfig.widthSizeMultiplier),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[

                        _deliveryRadioButton(AppLocalization.of(context).getTranslatedValue("pick"), 0),

                        Container(
                          height: .125 * SizeConfig.heightSizeMultiplier,
                          color: Colors.grey[300],
                        ),

                        _deliveryRadioButton(AppLocalization.of(context).getTranslatedValue("inside_dhaka"), 1),

                        Container(
                          height: .125 * SizeConfig.heightSizeMultiplier,
                          color: Colors.grey[300],
                        ),

                        _deliveryRadioButton(AppLocalization.of(context).getTranslatedValue("outside_dhaka"), 2),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _paymentRadioButton(String title, int value) {

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {

        _onPaymentSelected(value);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 2.56 * SizeConfig.widthSizeMultiplier),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Transform.scale(
              scale: 1.1,
              child: Radio(
                value: value,
                groupValue: paymentValue.value,
                activeColor: Theme.of(context).primaryColor,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity(vertical: 0),
                onChanged: _onPaymentSelected
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 1.28 * SizeConfig.widthSizeMultiplier),
              child: Text(title,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 2.2 * SizeConfig.textSizeMultiplier,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  Widget _deliveryRadioButton(String title, int value) {

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {

        _onDeliverySelected(value);
      },
      child: Padding(
        padding: EdgeInsets.only(left: 2.56 * SizeConfig.widthSizeMultiplier),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[

            Transform.scale(
              scale: 1.1,
              child: Radio(
                  value: value,
                  groupValue: deliveryValue.value,
                  activeColor: Theme.of(context).primaryColor,
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity(vertical: 0),
                  onChanged: _onDeliverySelected
              ),
            ),

            Padding(
              padding: EdgeInsets.only(left: 1.28 * SizeConfig.widthSizeMultiplier),
              child: Text(title,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                  fontSize: 2.2 * SizeConfig.textSizeMultiplier,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }


  void _onPaymentSelected(int value) {

    if(paymentValue.value != value) {

      setState(() {
        paymentValue.value = value;
      });
    }
  }


  void _onDeliverySelected(int value) {

    if(deliveryValue.value != value) {

      setState(() {
        deliveryValue.value = value;
      });
    }
  }
}