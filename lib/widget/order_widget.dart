import '../localization/app_localization.dart';

import '../utils/my_datetime.dart';
import '../model/order.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class OrderWidget extends StatelessWidget {

  final Order order;

  OrderWidget(this.order);

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(1.875 * SizeConfig.heightSizeMultiplier),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: .512 * SizeConfig.widthSizeMultiplier),
        borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          Text(AppLocalization.of(context).getTranslatedValue("order_id") + "  #" + this.order.orderID,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 1.5 * SizeConfig.heightSizeMultiplier,),

          Text(AppLocalization.of(context).getTranslatedValue("created_at") + " " + MyDateTime.getDateTime(DateTime.parse(this.order.createdAt).add(Duration(hours: 6))),
            style: Theme.of(context).textTheme.subtitle2.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),

          SizedBox(height: 1.5 * SizeConfig.heightSizeMultiplier,),

          Text(AppLocalization.of(context).getTranslatedValue("total") + "  ৳" + this.order.totalBill.truncate().toString(),
            style: Theme.of(context).textTheme.subtitle2.copyWith(
              fontWeight: FontWeight.w300,
            ),
          ),
        ],
      ),
    );
  }
}