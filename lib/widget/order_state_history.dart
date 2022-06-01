import 'package:flutter/material.dart';
import '../localization/app_localization.dart';
import '../model/order_state.dart';
import '../resources/images.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';

class OrderStateHistory extends StatefulWidget {

  final List<OrderState> orderStates;

  OrderStateHistory(this.orderStates);
  
  @override
  _OrderStateHistoryState createState() => _OrderStateHistoryState();
}

class _OrderStateHistoryState extends State<OrderStateHistory> {

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [

        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: widget.orderStates.length > 4 ? (_isExpanded ? widget.orderStates.length : 4) : widget.orderStates.length,
          reverse: true,
          itemBuilder: (BuildContext context, int index) {

            int position = widget.orderStates[index].time.split("  ")[0].lastIndexOf(" ");
            String date = widget.orderStates[index].time.substring(0, position);

            return IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Expanded(
                    flex: 2,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [

                        Text(date,
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),

                        Text(widget.orderStates[index].time.split("  ")[1],
                          textAlign: TextAlign.end,
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: Colors.black54,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Stack(
                    alignment: Alignment.topCenter,
                    children: [

                      Visibility(
                        visible: index != 0,
                        child: Container(
                          height: double.infinity,
                          width: .641 * SizeConfig.widthSizeMultiplier,
                          color: Colors.black26,
                          margin: EdgeInsets.only(
                            top: .25 * SizeConfig.heightSizeMultiplier,
                            left: 5.12 * SizeConfig.widthSizeMultiplier,
                            right: 5.12 * SizeConfig.widthSizeMultiplier,
                          ),
                        ),
                      ),

                      Container(
                        height: 1.875 * SizeConfig.heightSizeMultiplier,
                        width: 3.84 * SizeConfig.widthSizeMultiplier,
                        margin: EdgeInsets.only(
                          left: 5.12 * SizeConfig.widthSizeMultiplier,
                          right: 5.12 * SizeConfig.widthSizeMultiplier,
                        ),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.deepOrangeAccent,
                        ),
                      ),
                    ],
                  ),

                  Expanded(
                    flex: 6,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Text(Constants.ORDER_STATES[widget.orderStates[index].status],
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: .7 * SizeConfig.heightSizeMultiplier,),

                        Text(widget.orderStates[index].message,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        SizedBox(height: 3.125 * SizeConfig.heightSizeMultiplier,),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        Visibility(
          visible: widget.orderStates.length > 4,
          child: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {

              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(_isExpanded ? AppLocalization.of(context).getTranslatedValue("show_less") : AppLocalization.of(context).getTranslatedValue("show_more"),
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(width: 1.28 * SizeConfig.widthSizeMultiplier,),

                Image.asset(Images.descendant,
                  height: 2.25 * SizeConfig.heightSizeMultiplier,
                  width: 4.61 * SizeConfig.widthSizeMultiplier,
                  fit: BoxFit.fill,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}