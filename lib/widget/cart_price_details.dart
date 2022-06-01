import '../model/coupon.dart';
import 'package:flutter/material.dart';

import '../localization/app_localization.dart';
import '../resources/images.dart';
import '../utils/size_config.dart';

class CartPriceDetails extends StatefulWidget {

  final Coupon coupon;
  final double subTotal;

  final void Function() onProceed, removeCoupon;
  final void Function(String couponCode) onCouponSubmit;

  CartPriceDetails(this.coupon, this.subTotal, {this.onProceed, this.onCouponSubmit, this.removeCoupon});

  @override
  _CartPriceDetailsState createState() => _CartPriceDetailsState();
}

class _CartPriceDetailsState extends State<CartPriceDetails> {

  TextEditingController _couponController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Align(
      alignment: Alignment.bottomCenter,
      child: PhysicalModel(
        elevation: 3,
        color: Colors.white,
        shadowColor: Theme.of(context).accentColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(2.56 * SizeConfig.widthSizeMultiplier),
          topRight: Radius.circular(2.56 * SizeConfig.widthSizeMultiplier),
        ),
        child: Container(
          height: 28 * SizeConfig.heightSizeMultiplier,
          padding: EdgeInsets.only(
            left: 3.07 * SizeConfig.widthSizeMultiplier,
            right: 3.07 * SizeConfig.widthSizeMultiplier,
            top: 1.875 * SizeConfig.heightSizeMultiplier,
            bottom: 1.875 * SizeConfig.heightSizeMultiplier,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(2.56 * SizeConfig.widthSizeMultiplier),
              bottomLeft: Radius.circular(2.56 * SizeConfig.widthSizeMultiplier),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              IntrinsicHeight(
                child: Row(
                  children: <Widget>[

                    Expanded(
                      flex: 7,
                      child: TextField(
                        controller: _couponController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        style: Theme.of(context).textTheme.bodyText2,
                        onSubmitted: (value) {

                          FocusScope.of(context).unfocus();
                        },
                        decoration: InputDecoration(
                          prefixIcon: Image.asset(Images.couponIcon,
                            scale: 1.6,
                          ),
                          hintText: AppLocalization.of(context).getTranslatedValue("coupon_code"),
                          hintStyle: Theme.of(context).textTheme.caption.copyWith(color: Colors.black38),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(.5 * SizeConfig.heightSizeMultiplier),
                              topLeft: Radius.circular(.5 * SizeConfig.heightSizeMultiplier),
                            ),
                            borderSide: BorderSide(width: .2 * SizeConfig.widthSizeMultiplier, color: Colors.black45, style: BorderStyle.solid,),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(.5 * SizeConfig.heightSizeMultiplier),
                              topLeft: Radius.circular(.5 * SizeConfig.heightSizeMultiplier),
                            ),
                            borderSide: BorderSide(width: .2 * SizeConfig.widthSizeMultiplier, color: Colors.black45, style: BorderStyle.solid,),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(.5 * SizeConfig.heightSizeMultiplier),
                              topLeft: Radius.circular(.5 * SizeConfig.heightSizeMultiplier),
                            ),
                            borderSide: BorderSide(width: .2 * SizeConfig.widthSizeMultiplier, color: Colors.black45, style: BorderStyle.solid,),
                          ),
                          filled: true,
                          contentPadding: EdgeInsets.all(1.6875 * SizeConfig.heightSizeMultiplier),
                          fillColor: Colors.white,
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 2,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {

                          FocusScope.of(context).unfocus();

                          if(_couponController.text.isNotEmpty) {

                            widget.onCouponSubmit(_couponController.text);
                          }
                        },
                        child: Container(
                          height: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(width: .2 * SizeConfig.widthSizeMultiplier, color: Colors.black45, style: BorderStyle.solid,),
                            borderRadius: BorderRadius.only(
                              bottomRight: Radius.circular(.5 * SizeConfig.heightSizeMultiplier),
                              topRight: Radius.circular(.5 * SizeConfig.heightSizeMultiplier),
                            ),
                          ),
                          child: Center(
                            child: Text(AppLocalization.of(context).getTranslatedValue("apply"),
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Column(
                children: <Widget>[

                  Visibility(
                    visible: widget.coupon != null && widget.coupon.code != null && widget.coupon.code.isNotEmpty,
                    child: Padding(
                      padding: EdgeInsets.only(
                        top: .625 * SizeConfig.heightSizeMultiplier,
                        bottom: .375 * SizeConfig.heightSizeMultiplier,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[

                          Text(AppLocalization.of(context).getTranslatedValue("coupon") + ": " + (widget.coupon.code ?? ""),
                            style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          GestureDetector(
                            onTap: () {
                              widget.removeCoupon();
                            },
                            child: Text(AppLocalization.of(context).getTranslatedValue("remove").toLowerCase(),
                              style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: .625 * SizeConfig.heightSizeMultiplier,
                      bottom: .375 * SizeConfig.heightSizeMultiplier,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Text(AppLocalization.of(context).getTranslatedValue("coupon_discount"),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        Text("- ৳" + widget.coupon.discountAmount.round().toString(),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                      top: .375 * SizeConfig.heightSizeMultiplier,
                      bottom: .625 * SizeConfig.heightSizeMultiplier,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[

                        Text(AppLocalization.of(context).getTranslatedValue("sub_total"),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        Text("৳" + widget.subTotal.round().toString(),
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  widget.onProceed();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.only(
                    top: 1.5 * SizeConfig.heightSizeMultiplier,
                    bottom: 1.5 * SizeConfig.heightSizeMultiplier,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Center(
                    child: Text(AppLocalization.of(context).getTranslatedValue("checkout").toUpperCase(),
                      style: Theme.of(context).textTheme.button.copyWith(
                        fontSize: 2 * SizeConfig.textSizeMultiplier,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}