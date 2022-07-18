import 'package:app/presenter/user_presenter.dart';
import 'package:app/utils/my_flush_bar.dart';

import '../utils/constants.dart';

import '../model/coupon.dart';

import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'custom_dialog.dart';

class OrderReferralCoinWidget extends StatefulWidget {
  final void Function(double) onCoinSubmit;
  final void Function() onCoinRemoval;

  OrderReferralCoinWidget({this.onCoinSubmit, this.onCoinRemoval});

  @override
  _OrderReferralCoinWidgetState createState() =>
      _OrderReferralCoinWidgetState();
}

class _OrderReferralCoinWidgetState extends State<OrderReferralCoinWidget>
    with ChangeNotifier {
  TextEditingController _coinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 2.5 * SizeConfig.heightSizeMultiplier,
          color: Theme.of(context).hintColor,
        ),
        SizedBox(
          height: 2.5 * SizeConfig.heightSizeMultiplier,
        ),
        Padding(
          padding: EdgeInsets.only(
            left: 5.12 * SizeConfig.widthSizeMultiplier,
            right: 5.12 * SizeConfig.widthSizeMultiplier,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                // AppLocalization.of(context)
                //     .getTranslatedValue("delivery_address")
                "Use Referral Coin",
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
              Text(
                // AppLocalization.of(context)
                //     .getTranslatedValue("delivery_address")
                "Total: ${currentUser.value.balance}",
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 2.5 * SizeConfig.heightSizeMultiplier,
        ),
        Container(
          height: .25 * SizeConfig.heightSizeMultiplier,
          color: Theme.of(context).hintColor,
        ),
        Container(
          width: double.infinity,
          height: 8 * SizeConfig.heightSizeMultiplier,
          // color: Theme.of(context).accentColor,
          padding: EdgeInsets.only(
            left: 5.12 * SizeConfig.widthSizeMultiplier,
            right: 5.12 * SizeConfig.widthSizeMultiplier,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 5 * SizeConfig.heightSizeMultiplier,
                child: SizedBox(
                  width: 65 * SizeConfig.widthSizeMultiplier,
                  child: TextField(
                    controller: _coinController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.done,
                    style: Theme.of(context).textTheme.bodyText2,
                    onSubmitted: (value) {
                      FocusScope.of(context).unfocus();
                    },
                    decoration: InputDecoration(
                      hintText: "Enter the amount of coin to use",
                      hintStyle: TextStyle(
                        fontSize: 2.15 * SizeConfig.textSizeMultiplier,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500],
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: .5 * SizeConfig.widthSizeMultiplier),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: .5 * SizeConfig.widthSizeMultiplier),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: Theme.of(context).primaryColor,
                            width: .5 * SizeConfig.widthSizeMultiplier),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: 3 * SizeConfig.widthSizeMultiplier,
              ),
              Flexible(
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      Theme.of(context).accentColor,
                    ),
                    minimumSize: MaterialStateProperty.all(
                      Size.fromHeight(40),
                    ),
                  ),
                  onPressed: () {
                    _validate();
                  },
                  child: Text("Use"),
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 2.5 * SizeConfig.heightSizeMultiplier,
          color: Theme.of(context).hintColor,
        ),
      ],
    );
  }

  void _validate() async {
    FocusScope.of(context).unfocus();
    if (int.parse(currentUser.value.balance) >
        int.parse(_coinController.text)) {
      if (_coinController.text.isNotEmpty) {
        await _showConfirmationDialog(
          context,
        );
      }
    } else {
      MyFlushBar.show(context, "You don't have enough coin!");
    }
  }

  Future<Widget> _showConfirmationDialog(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return CustomDialog(
            title: AppLocalization.of(context).getTranslatedValue("warning"),
            message:
                "Are you sure you want to use ${_coinController.text} coins?",
            onPositiveButtonPress: () {
              widget.onCoinSubmit(double.parse(_coinController.text));
            },
          );
        });
  }
}
