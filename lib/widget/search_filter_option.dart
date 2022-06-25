import '../localization/app_localization.dart';
import '../utils/constants.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'price_filter_sheet.dart';
import 'sort_filter_sheet.dart';
import 'type_filter_sheet.dart';

class SearchFilterOption extends StatefulWidget {
  final int typeValue, sortValue;
  final double minPrice, maxPrice;
  final void Function(int) onTypeSelected, onSortSelected;
  final void Function(double, double) onPriceSelected;

  SearchFilterOption(
      this.typeValue, this.sortValue, this.minPrice, this.maxPrice,
      {this.onTypeSelected, this.onSortSelected, this.onPriceSelected});

  @override
  _SearchFilterOptionState createState() => _SearchFilterOptionState();
}

class _SearchFilterOptionState extends State<SearchFilterOption> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 7.5 * SizeConfig.heightSizeMultiplier,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 1,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                FocusScope.of(context).unfocus();
                _showTypeBottomSheet(context);
              },
              child: Container(
                padding: EdgeInsets.only(
                  top: .625 * SizeConfig.heightSizeMultiplier,
                  bottom: .625 * SizeConfig.heightSizeMultiplier,
                  left: 1.79 * SizeConfig.widthSizeMultiplier,
                  right: 1.79 * SizeConfig.widthSizeMultiplier,
                ),
                margin: EdgeInsets.only(
                  left: 2.56 * SizeConfig.widthSizeMultiplier,
                  right: 2.05 * SizeConfig.widthSizeMultiplier,
                ),
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.circular(
                      .5 * SizeConfig.heightSizeMultiplier),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      widget.typeValue == 0
                          ? AppLocalization.of(context)
                              .getTranslatedValue("products")
                          : (widget.typeValue == 1
                              ? AppLocalization.of(context)
                                  .getTranslatedValue("category")
                              : widget.typeValue == 2
                                  ? AppLocalization.of(context)
                                      .getTranslatedValue("shops")
                                  : widget.typeValue == 3
                                      ? AppLocalization.of(context)
                                          .getTranslatedValue("brands")
                                      : ""),
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: Colors.white,
                            fontSize: 2 * SizeConfig.textSizeMultiplier,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    Icon(
                      Icons.arrow_drop_down,
                      color: Colors.white,
                      size: 6.41 * SizeConfig.imageSizeMultiplier,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Visibility(
              visible: widget.typeValue == 0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  _showSortBottomSheet(context);
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: .625 * SizeConfig.heightSizeMultiplier,
                    bottom: .625 * SizeConfig.heightSizeMultiplier,
                    left: 1.79 * SizeConfig.widthSizeMultiplier,
                    right: 1.79 * SizeConfig.widthSizeMultiplier,
                  ),
                  margin: EdgeInsets.only(
                    left: 2.05 * SizeConfig.widthSizeMultiplier,
                    right: 2.05 * SizeConfig.widthSizeMultiplier,
                  ),
                  decoration: BoxDecoration(
                    color: widget.sortValue == 0
                        ? Colors.black.withOpacity(.13)
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(
                        .5 * SizeConfig.heightSizeMultiplier),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalization.of(context)
                            .getTranslatedValue("sort_by"),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: widget.sortValue == 0
                                  ? Colors.black54
                                  : Colors.white,
                              fontSize: 2 * SizeConfig.textSizeMultiplier,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: widget.sortValue == 0
                            ? Colors.black38
                            : Colors.white,
                        size: 6.41 * SizeConfig.imageSizeMultiplier,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Visibility(
              visible: widget.typeValue == 0,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  _showPriceBottomSheet(context);
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: .625 * SizeConfig.heightSizeMultiplier,
                    bottom: .625 * SizeConfig.heightSizeMultiplier,
                    left: 1.79 * SizeConfig.widthSizeMultiplier,
                    right: 1.79 * SizeConfig.widthSizeMultiplier,
                  ),
                  margin: EdgeInsets.only(
                    left: 2.05 * SizeConfig.widthSizeMultiplier,
                    right: 2.56 * SizeConfig.widthSizeMultiplier,
                  ),
                  decoration: BoxDecoration(
                    color: widget.minPrice == Constants.MIN_PRICE &&
                            widget.maxPrice == Constants.MAX_PRICE
                        ? Colors.black.withOpacity(.13)
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(
                        .5 * SizeConfig.heightSizeMultiplier),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        AppLocalization.of(context).getTranslatedValue("price"),
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: widget.minPrice == Constants.MIN_PRICE &&
                                      widget.maxPrice == Constants.MAX_PRICE
                                  ? Colors.black54
                                  : Colors.white,
                              fontSize: 2 * SizeConfig.textSizeMultiplier,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                      Icon(
                        Icons.arrow_drop_down,
                        color: widget.minPrice == Constants.MIN_PRICE &&
                                widget.maxPrice == Constants.MAX_PRICE
                            ? Colors.black38
                            : Colors.white,
                        size: 6.41 * SizeConfig.imageSizeMultiplier,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showTypeBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.black54,
      elevation: 10,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(1.875 * SizeConfig.heightSizeMultiplier),
          topLeft: Radius.circular(1.875 * SizeConfig.heightSizeMultiplier),
        ),
      ),
      builder: (BuildContext context) {
        return TypeFilterSheet(
          widget.typeValue,
          onSelected: (int value) {
            widget.onTypeSelected(value);
          },
        );
      },
    );
  }

  void _showSortBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.black54,
      elevation: 10,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(1.875 * SizeConfig.heightSizeMultiplier),
          topLeft: Radius.circular(1.875 * SizeConfig.heightSizeMultiplier),
        ),
      ),
      builder: (BuildContext context) {
        return SortFilterSheet(
          widget.sortValue,
          onSelected: (int value) {
            widget.onSortSelected(value);
          },
        );
      },
    );
  }

  void _showPriceBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      barrierColor: Colors.black54,
      elevation: 10,
      isScrollControlled: true,
      isDismissible: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(1.875 * SizeConfig.heightSizeMultiplier),
          topLeft: Radius.circular(1.875 * SizeConfig.heightSizeMultiplier),
        ),
      ),
      builder: (BuildContext context) {
        return PriceFilterSheet(
          widget.minPrice,
          widget.maxPrice,
          onValueChanged: (double min, double max) {
            widget.onPriceSelected(min, max);
          },
        );
      },
    );
  }
}
