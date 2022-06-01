import '../localization/app_localization.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';

class PriceFilterSheet extends StatefulWidget {

  final double minPrice, maxPrice;
  final void Function(double, double) onValueChanged;

  PriceFilterSheet(this.minPrice, this.maxPrice, {this.onValueChanged});

  @override
  PriceFilterSheetState createState() => PriceFilterSheetState();
}

class PriceFilterSheetState extends State<PriceFilterSheet> {

  SfRangeValues _values = SfRangeValues(Constants.MIN_PRICE, Constants.MAX_PRICE);

  @override
  void initState() {

    _values = SfRangeValues(widget.minPrice, widget.maxPrice);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      padding: EdgeInsets.only(
        left: 5.12 * SizeConfig.widthSizeMultiplier,
        right: 5.12 * SizeConfig.widthSizeMultiplier,
        bottom: 6.8 * SizeConfig.heightSizeMultiplier,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(2.56 * SizeConfig.widthSizeMultiplier),
          topLeft: Radius.circular(2.56 * SizeConfig.widthSizeMultiplier),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),

          Text(AppLocalization.of(context).getTranslatedValue("filter_by_price_range"),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(.65),
            ),
          ),

          SizedBox(height: 1.875 * SizeConfig.heightSizeMultiplier,),

          SfRangeSlider(
            min: Constants.MIN_PRICE,
            max: Constants.MAX_PRICE,
            enableTooltip: true,
            activeColor: Theme.of(context).primaryColor,
            inactiveColor: Colors.black54,
            values: _values,
            onChanged: (SfRangeValues values){
              setState(() {
                _values = values;
              });
            },
          ),

          Padding(
            padding: EdgeInsets.only(
              left: 1.28 * SizeConfig.widthSizeMultiplier,
              right: 1.28 * SizeConfig.widthSizeMultiplier,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[

                Text(AppLocalization.of(context).getTranslatedValue("min") + ": " +
                    double.parse(_values.start.toString()).floor().toString(),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 1.625 * SizeConfig.textSizeMultiplier,
                    fontWeight: FontWeight.w500,
                  ),
                ),

                Text(AppLocalization.of(context).getTranslatedValue("max") + ": " +
                    double.parse(_values.end.toString()).floor().toString(),
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 1.625 * SizeConfig.textSizeMultiplier,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  setState(() {
                    _values = SfRangeValues(Constants.MIN_PRICE, 999.0);
                  });

                  _onApply();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    top: .375 * SizeConfig.heightSizeMultiplier,
                    bottom: .375 * SizeConfig.heightSizeMultiplier,
                    left: 1.79 * SizeConfig.widthSizeMultiplier,
                    right: 1.79 * SizeConfig.widthSizeMultiplier,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.875 * SizeConfig.heightSizeMultiplier),
                    border: Border.all(
                      color: Colors.black38,
                      width: .256 * SizeConfig.widthSizeMultiplier,
                    ),
                  ),
                  child: Text(AppLocalization.of(context).getTranslatedValue("under_1k"),
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Colors.black.withOpacity(.65),
                      fontSize: 1.875 * SizeConfig.textSizeMultiplier,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  setState(() {
                    _values = SfRangeValues(1000.0, 10000.0);
                  });

                  _onApply();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    top: .375 * SizeConfig.heightSizeMultiplier,
                    bottom: .375 * SizeConfig.heightSizeMultiplier,
                    left: 1.79 * SizeConfig.widthSizeMultiplier,
                    right: 1.79 * SizeConfig.widthSizeMultiplier,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.875 * SizeConfig.heightSizeMultiplier),
                    border: Border.all(
                      color: Colors.black38,
                      width: .256 * SizeConfig.widthSizeMultiplier,
                    ),
                  ),
                  child: Text(AppLocalization.of(context).getTranslatedValue("from_1k_to_10k"),
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Colors.black.withOpacity(.65),
                      fontSize: 1.875 * SizeConfig.textSizeMultiplier,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  setState(() {
                    _values = SfRangeValues(10001.0, Constants.MAX_PRICE);
                  });

                  _onApply();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    top: .375 * SizeConfig.heightSizeMultiplier,
                    bottom: .375 * SizeConfig.heightSizeMultiplier,
                    left: 1.79 * SizeConfig.widthSizeMultiplier,
                    right: 1.79 * SizeConfig.widthSizeMultiplier,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(1.875 * SizeConfig.heightSizeMultiplier),
                    border: Border.all(
                      color: Colors.black38,
                      width: .256 * SizeConfig.widthSizeMultiplier,
                    ),
                  ),
                  child: Text(AppLocalization.of(context).getTranslatedValue("above_10k"),
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Colors.black.withOpacity(.65),
                      fontSize: 1.875 * SizeConfig.textSizeMultiplier,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 3.125 * SizeConfig.heightSizeMultiplier,),

          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  setState(() {
                    _values = SfRangeValues(Constants.MIN_PRICE, Constants.MAX_PRICE);
                  });

                  _onApply();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    top: .75 * SizeConfig.heightSizeMultiplier,
                    bottom: .75 * SizeConfig.heightSizeMultiplier,
                    left: 3.84 * SizeConfig.widthSizeMultiplier,
                    right: 3.84 * SizeConfig.widthSizeMultiplier,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(1.875 * SizeConfig.heightSizeMultiplier),
                  ),
                  child: Text(AppLocalization.of(context).getTranslatedValue("clear"),
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                      fontSize: 1.875 * SizeConfig.textSizeMultiplier,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),

              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  _onApply();
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(
                    top: .75 * SizeConfig.heightSizeMultiplier,
                    bottom: .75 * SizeConfig.heightSizeMultiplier,
                    left: 3.84 * SizeConfig.widthSizeMultiplier,
                    right: 3.84 * SizeConfig.widthSizeMultiplier,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(1.875 * SizeConfig.heightSizeMultiplier),
                  ),
                  child: Text(AppLocalization.of(context).getTranslatedValue("apply"),
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: Colors.white,
                      fontSize: 1.875 * SizeConfig.textSizeMultiplier,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 10 * SizeConfig.heightSizeMultiplier,),
        ],
      ),
    );
  }


  void _onApply() {

    Navigator.of(context).pop();
    widget.onValueChanged(_values.start, _values.end);
  }
}