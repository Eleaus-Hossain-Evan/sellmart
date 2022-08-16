import '../view/cart.dart';

import '../model/user.dart';
import '../utils/shared_preference.dart';

import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class OrderConfirmationInput extends StatefulWidget {
  @override
  _OrderConfirmationInputState createState() => _OrderConfirmationInputState();
}

class _OrderConfirmationInputState extends State<OrderConfirmationInput>
    with ChangeNotifier {
  MySharedPreference _sharedPreference = MySharedPreference();

  TextEditingController _phoneController = TextEditingController();

  @override
  void initState() {
    _setPhoneNumber();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 2.5 * SizeConfig.heightSizeMultiplier,
        ),
        Container(
          height: 6 * SizeConfig.heightSizeMultiplier,
          margin: EdgeInsets.only(
            left: 3.84 * SizeConfig.widthSizeMultiplier,
            right: 3.84 * SizeConfig.widthSizeMultiplier,
          ),
          child: TextField(
            keyboardType: TextInputType.text,
            textInputAction: TextInputAction.done,
            style: Theme.of(context).textTheme.bodyText2,
            onChanged: (value) {
              order.value.name = value;
            },
            decoration: InputDecoration(
              hintText: AppLocalization.of(context).getTranslatedValue("name"),
              hintStyle: TextStyle(
                fontSize: 2 * SizeConfig.textSizeMultiplier,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                borderSide: BorderSide(
                    color: Colors.black54,
                    width: .25 * SizeConfig.widthSizeMultiplier),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                borderSide: BorderSide(
                    color: Colors.black54,
                    width: .25 * SizeConfig.widthSizeMultiplier),
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                borderSide: BorderSide(
                    color: Colors.black54,
                    width: .25 * SizeConfig.widthSizeMultiplier),
              ),
              contentPadding:
                  EdgeInsets.all(1.5 * SizeConfig.heightSizeMultiplier),
            ),
          ),
        ),
        SizedBox(
          height: 1.75 * SizeConfig.heightSizeMultiplier,
        ),
        Container(
          height: 6 * SizeConfig.heightSizeMultiplier,
          margin: EdgeInsets.only(
            left: 3.84 * SizeConfig.widthSizeMultiplier,
            right: 3.84 * SizeConfig.widthSizeMultiplier,
          ),
          child: TextField(
            controller: _phoneController,
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              order.value.phone = value;
            },
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              hintText:
                  AppLocalization.of(context).getTranslatedValue("mobile"),
              hintStyle: TextStyle(
                fontSize: 2 * SizeConfig.textSizeMultiplier,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                borderSide: BorderSide(
                    color: Colors.black54,
                    width: .25 * SizeConfig.widthSizeMultiplier),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                borderSide: BorderSide(
                    color: Colors.black54,
                    width: .25 * SizeConfig.widthSizeMultiplier),
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                borderSide: BorderSide(
                    color: Colors.black54,
                    width: .25 * SizeConfig.widthSizeMultiplier),
              ),
              contentPadding:
                  EdgeInsets.all(1.5 * SizeConfig.heightSizeMultiplier),
            ),
          ),
        ),
        SizedBox(
          height: 1.75 * SizeConfig.heightSizeMultiplier,
        ),
        Container(
          height: 6 * SizeConfig.heightSizeMultiplier,
          margin: EdgeInsets.only(
            left: 3.84 * SizeConfig.widthSizeMultiplier,
            right: 3.84 * SizeConfig.widthSizeMultiplier,
          ),
          child: TextField(
            keyboardType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              order.value.alternativePhone = value;
            },
            style: Theme.of(context).textTheme.bodyText2,
            decoration: InputDecoration(
              hintText:
                  AppLocalization.of(context).getTranslatedValue("alt_mobile"),
              hintStyle: TextStyle(
                fontSize: 2 * SizeConfig.textSizeMultiplier,
                fontWeight: FontWeight.w400,
                color: Colors.grey,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                borderSide: BorderSide(
                    color: Colors.black54,
                    width: .25 * SizeConfig.widthSizeMultiplier),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                borderSide: BorderSide(
                    color: Colors.black54,
                    width: .25 * SizeConfig.widthSizeMultiplier),
              ),
              border: OutlineInputBorder(
                borderRadius:
                    BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
                borderSide: BorderSide(
                    color: Colors.black54,
                    width: .25 * SizeConfig.widthSizeMultiplier),
              ),
              contentPadding:
                  EdgeInsets.all(1.5 * SizeConfig.heightSizeMultiplier),
            ),
          ),
        ),
        SizedBox(
          height: 2.5 * SizeConfig.heightSizeMultiplier,
        ),
      ],
    );
  }

  Future<void> _setPhoneNumber() async {
    User user = await _sharedPreference.getCurrentUser();

    if (user != null && user.phone != null && user.phone.isNotEmpty) {
      _phoneController.text = user.phone;
      order.value.phone = user.phone;
    }
  }
}
