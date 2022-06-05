import '../utils/constants.dart';

import '../model/coupon.dart';

import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class OrderCouponWidget extends StatefulWidget {
  final Coupon coupon;
  final void Function(String) onCouponSubmit;
  final void Function() onCouponRemoval;

  OrderCouponWidget(this.coupon, {this.onCouponSubmit, this.onCouponRemoval});

  @override
  _OrderCouponWidgetState createState() => _OrderCouponWidgetState();
}

class _OrderCouponWidgetState extends State<OrderCouponWidget>
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
        Container(
          width: double.infinity,
          height: 8 * SizeConfig.heightSizeMultiplier,
          color: Theme.of(context).accentColor,
          padding: EdgeInsets.only(
            left: 5.12 * SizeConfig.widthSizeMultiplier,
            right: 5.12 * SizeConfig.widthSizeMultiplier,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   AppLocalization.of(context)
              //       .getTranslatedValue("promo_code")
              //       .toUpperCase(),
              //   style: Theme.of(context).textTheme.subtitle2.copyWith(
              //         fontWeight: FontWeight.w400,
              //         color: Colors.white,
              //       ),
              // ),
              // GestureDetector(
              //   behavior: HitTestBehavior.opaque,
              //   onTap: () {
              //     _showCouponDialog(context);
              //   },
              //   child: Container(
              //     padding:
              //         EdgeInsets.all(.25 * SizeConfig.heightSizeMultiplier),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(
              //           .85 * SizeConfig.heightSizeMultiplier),
              //       border: Border.all(
              //           color: Colors.white,
              //           width: .361 * SizeConfig.widthSizeMultiplier),
              //     ),
              //     child: Icon(
              //       Icons.add,
              //       size: 6 * SizeConfig.widthSizeMultiplier,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              TextField(
                controller: _couponController,
                keyboardType: TextInputType.text,
                textInputAction: TextInputAction.done,
                style: Theme.of(context).textTheme.bodyText2,
                onSubmitted: (value) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  // hintText: AppLocalization.of(context).getTranslatedValue("type_promo_code"),
                  hintText: "Enter Promo code to apply",
                  hintStyle: TextStyle(
                    fontSize: 2.15 * SizeConfig.textSizeMultiplier,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[400],
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

              ElevatedButton(
                onPressed: () {
                  _validate();
                },
                child: Text("Apply"),
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

  Future<Widget> _showCouponDialog(BuildContext mainContext) async {
    _couponController.text = "";

    return showDialog(
        context: mainContext,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return WillPopScope(
            onWillPop: () {
              return Future(() => true);
            },
            child: Dialog(
              elevation: 10,
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    .25 * SizeConfig.heightSizeMultiplier),
              ),
              child: Container(
                padding: EdgeInsets.all(2.5 * SizeConfig.heightSizeMultiplier),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                      .25 * SizeConfig.heightSizeMultiplier),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalization.of(context)
                              .getTranslatedValue("promo_code")
                              .toUpperCase(),
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          child: Icon(
                            Icons.close,
                            size: 6.92 * SizeConfig.imageSizeMultiplier,
                            color: Colors.black.withOpacity(.65),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      AppLocalization.of(context)
                          .getTranslatedValue("add_promo_code"),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontWeight: FontWeight.w400,
                            color: Colors.black38,
                          ),
                    ),
                    SizedBox(
                      height: 2.5 * SizeConfig.heightSizeMultiplier,
                    ),
                    Container(
                      height: 5 * SizeConfig.heightSizeMultiplier,
                      child: TextField(
                        controller: _couponController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        style: Theme.of(context).textTheme.bodyText2,
                        onSubmitted: (value) {
                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          hintText: AppLocalization.of(context)
                              .getTranslatedValue("type_promo_code"),
                          hintStyle: TextStyle(
                            fontSize: 2.15 * SizeConfig.textSizeMultiplier,
                            fontWeight: FontWeight.w400,
                            color: Colors.grey[400],
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
                    SizedBox(
                      height: 3.125 * SizeConfig.heightSizeMultiplier,
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // GestureDetector(
                        //   behavior: HitTestBehavior.opaque,
                        //   onTap: () {

                        //     Navigator.of(context).pop();
                        //   },
                        //   child: Container(
                        //     padding: EdgeInsets.only(
                        //       top: 1.25 * SizeConfig.heightSizeMultiplier,
                        //       bottom: 1.25 * SizeConfig.heightSizeMultiplier,
                        //       left: 6.41 * SizeConfig.widthSizeMultiplier,
                        //       right: 6.41 * SizeConfig.widthSizeMultiplier,
                        //     ),
                        //     child: Text(AppLocalization.of(context).getTranslatedValue("cancel").toUpperCase(),
                        //       style: Theme.of(context).textTheme.subtitle2.copyWith(
                        //         color: Colors.black26,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          onTap: () {
                            _validate();
                            Navigator.of(context).pop();
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                              top: 1.25 * SizeConfig.heightSizeMultiplier,
                              bottom: 1.25 * SizeConfig.heightSizeMultiplier,
                              left: 6.41 * SizeConfig.widthSizeMultiplier,
                              right: 6.41 * SizeConfig.widthSizeMultiplier,
                            ),
                            decoration: BoxDecoration(
                              color: Theme.of(context).primaryColor,
                              borderRadius: BorderRadius.circular(
                                  .5 * SizeConfig.heightSizeMultiplier),
                            ),
                            child: Text(
                              AppLocalization.of(context)
                                  .getTranslatedValue("done")
                                  .toUpperCase(),
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
