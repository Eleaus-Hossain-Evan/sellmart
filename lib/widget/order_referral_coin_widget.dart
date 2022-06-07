import '../utils/constants.dart';

import '../model/coupon.dart';

import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class OrderReferralCoinWidget extends StatefulWidget {
  final Coupon coupon;
  final void Function(String) onCouponSubmit;
  final void Function() onCouponRemoval;

  OrderReferralCoinWidget(this.coupon,
      {this.onCouponSubmit, this.onCouponRemoval});

  @override
  _OrderReferralCoinWidgetState createState() =>
      _OrderReferralCoinWidgetState();
}

class _OrderReferralCoinWidgetState extends State<OrderReferralCoinWidget>
    with ChangeNotifier {
  TextEditingController _couponController = TextEditingController();

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
                "Total: ${widget.coupon.discountAmount}",
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
                  width: 68 * SizeConfig.widthSizeMultiplier,
                  child: TextField(
                    controller: _couponController,
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
        Visibility(
          visible: widget.coupon != null &&
              widget.coupon.code != null &&
              widget.coupon.code.isNotEmpty,
          child: Padding(
            padding: EdgeInsets.only(
              top: 1.5 * SizeConfig.heightSizeMultiplier,
              bottom: 1.5 * SizeConfig.heightSizeMultiplier,
              left: 5.12 * SizeConfig.widthSizeMultiplier,
              right: 5.12 * SizeConfig.widthSizeMultiplier,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      widget.coupon != null &&
                              widget.coupon.code != null &&
                              widget.coupon.code.isNotEmpty
                          ? widget.coupon.code
                          : "",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontSize: 2 * SizeConfig.textSizeMultiplier,
                            color: Colors.black.withOpacity(.75),
                          ),
                    ),
                    Text(
                      widget.coupon != null &&
                              widget.coupon.code != null &&
                              widget.coupon.code.isNotEmpty
                          ? (widget.coupon.discount.amount.round().toString() +
                              (widget.coupon.discount.type ==
                                      Constants.FLAT_DISCOUNT
                                  ? (" " +
                                      AppLocalization.of(context)
                                          .getTranslatedValue("tk"))
                                  : "%"))
                          : "",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontSize: 2 * SizeConfig.textSizeMultiplier,
                            color: Colors.black.withOpacity(.75),
                          ),
                    ),
                  ],
                ),
                SizedBox(
                  height: .8 * SizeConfig.heightSizeMultiplier,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    _couponController.text = "";
                    widget.onCouponRemoval();
                  },
                  child: Text(
                    AppLocalization.of(context)
                        .getTranslatedValue("remove_coupon"),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 2.5 * SizeConfig.heightSizeMultiplier,
          color: Theme.of(context).hintColor,
        ),
      ],
    );
  }

  void _validate() {
    FocusScope.of(context).unfocus();

    if (_couponController.text.isNotEmpty) {
      widget.onCouponSubmit(_couponController.text);
    }
  }
}
