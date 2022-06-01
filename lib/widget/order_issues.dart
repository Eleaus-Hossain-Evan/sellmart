import '../localization/app_localization.dart';
import '../model/order.dart';
import '../utils/size_config.dart';
import '../utils/constants.dart';
import 'package:flutter/material.dart';

class OrderIssues extends StatefulWidget {

  final Order order;
  final void Function() onCancelOrder;
  final void Function() onRequestRefund;
  final void Function() requestReturnRefund;

  OrderIssues(this.order, {this.onCancelOrder, this.onRequestRefund, this.requestReturnRefund});

  @override
  _OrderIssuesState createState() => _OrderIssuesState();
}

class _OrderIssuesState extends State<OrderIssues> {

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        Visibility(
          visible: widget.order.currentState <= Constants.PROCESSING,
          child: Column(
            children: [

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  widget.onCancelOrder();
                },
                child: Container(
                  padding: EdgeInsets.all(1.875 * SizeConfig.heightSizeMultiplier),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.05),
                    borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(AppLocalization.of(context).getTranslatedValue("cancel_order"),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      Icon(Icons.arrow_forward_ios, size: 4.61 * SizeConfig.imageSizeMultiplier, color: Theme.of(context).primaryColor,),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),
            ],
          ),
        ),

        Visibility(
          visible: widget.order.currentState == Constants.DELIVERED &&
            DateTime.now().difference(DateTime.parse(widget.order.states.last.updateTime)).inDays <= 7 &&
            widget.order.returnRequestState == Constants.RETURN_NOT_REQUESTED,
          child: Column(
            children: [

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  widget.requestReturnRefund();
                },
                child: Container(
                  padding: EdgeInsets.all(1.875 * SizeConfig.heightSizeMultiplier),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.05),
                    borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(AppLocalization.of(context).getTranslatedValue("request_for_return_refund"),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      Icon(Icons.arrow_forward_ios, size: 4.61 * SizeConfig.imageSizeMultiplier, color: Theme.of(context).primaryColor,),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),
            ],
          ),
        ),

        Visibility(
          visible: widget.order.currentState == Constants.CANCELLED && widget.order.advancePayment > 0 &&
              widget.order.moneyWithdrawalState == Constants.WITHDRAW_NOT_REQUESTED,
          child: Column(
            children: [

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  widget.onRequestRefund();
                },
                child: Container(
                  padding: EdgeInsets.all(1.875 * SizeConfig.heightSizeMultiplier),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.05),
                    borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      Text(AppLocalization.of(context).getTranslatedValue("request_refund"),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                          fontWeight: FontWeight.w500,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),

                      Icon(Icons.arrow_forward_ios, size: 4.61 * SizeConfig.imageSizeMultiplier, color: Theme.of(context).primaryColor,),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),
            ],
          ),
        ),

        Visibility(
          visible: widget.order.moneyWithdrawalState == Constants.WITHDRAW_REQUESTED,
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  padding: EdgeInsets.all(1.875 * SizeConfig.heightSizeMultiplier),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.05),
                    borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
                  ),
                  child: Text(AppLocalization.of(context).getTranslatedValue("refund_requested"),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),

                SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),
              ],
            ),
          ),
        ),

        Visibility(
          visible: widget.order.returnRequestState == Constants.RETURN_REQUESTED && widget.order.currentState != Constants.REFUNDED,
          child: Align(
            alignment: Alignment.centerRight,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  padding: EdgeInsets.all(1.875 * SizeConfig.heightSizeMultiplier),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.05),
                    borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
                  ),
                  child: Text(AppLocalization.of(context).getTranslatedValue("return_refund_requested"),
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontWeight: FontWeight.w500,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                ),

                SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),
              ],
            ),
          ),
        ),
      ],
    );
  }
}