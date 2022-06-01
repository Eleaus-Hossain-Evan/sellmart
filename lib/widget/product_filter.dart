import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import '../model/filter_options.dart';
import 'package:flutter/material.dart';

class ProductFilter extends StatefulWidget {

  final FilterOptions filterOptions;
  final void Function() onFilterApplied;
  final void Function() onFilterCleared;

  ProductFilter({this.filterOptions, this.onFilterApplied, this.onFilterCleared, Key key}) : super(key: key);

  @override
  ProductFilterState createState() => ProductFilterState();
}

class ProductFilterState extends State<ProductFilter> {

  List<String> _sortByTitles = ["", "", ""];
  List<String> _priceTitles = ["", "", "", "", ""];


  @override
  void didChangeDependencies() {

    _sortByTitles[0] = AppLocalization.of(context).getTranslatedValue("relevance");
    _sortByTitles[1] = AppLocalization.of(context).getTranslatedValue("price_l2h");
    _sortByTitles[2] = AppLocalization.of(context).getTranslatedValue("price_h2l");

    _priceTitles[0] = AppLocalization.of(context).getTranslatedValue("zero_to_1k");
    _priceTitles[1] = AppLocalization.of(context).getTranslatedValue("from_1k_to_10k");
    _priceTitles[2] = AppLocalization.of(context).getTranslatedValue("from_10k_to_50k");
    _priceTitles[3] = AppLocalization.of(context).getTranslatedValue("from_50k_to_250k");
    _priceTitles[4] = AppLocalization.of(context).getTranslatedValue("from_250k_to_5m");

    super.didChangeDependencies();
  }


  @override
  Widget build(BuildContext context) {

    return Drawer(
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Stack(
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(bottom: 6.25 * SizeConfig.heightSizeMultiplier,),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[

                    Padding(
                      padding: EdgeInsets.only(
                        top: 1.875 * SizeConfig.heightSizeMultiplier,
                        bottom: 2.5 * SizeConfig.heightSizeMultiplier,
                        left: 3.84 * SizeConfig.widthSizeMultiplier,
                        right: 1.84 * SizeConfig.heightSizeMultiplier,
                      ),
                      child: Text(AppLocalization.of(context).getTranslatedValue("filter"),
                        style: Theme.of(context).textTheme.headline5,
                      ),
                    ),

                    Expanded(
                      child: NotificationListener<OverscrollIndicatorNotification>(
                        onNotification: (overScroll) {
                          overScroll.disallowGlow();
                          return;
                        },
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: EdgeInsets.only(
                              top: .625 * SizeConfig.heightSizeMultiplier,
                              left: 3.84 * SizeConfig.widthSizeMultiplier,
                              right: .625 * SizeConfig.heightSizeMultiplier,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[

                                Text(AppLocalization.of(context).getTranslatedValue("sort_by"),
                                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                                    fontSize: 1.875 * SizeConfig.textSizeMultiplier,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                SizedBox(height: 1.875 * SizeConfig.heightSizeMultiplier,),

                                Column(
                                  children: List.generate(3, (index) {

                                    return _sortByRadioButton(_sortByTitles[index], index);
                                  }),
                                ),

                                SizedBox(height: 1.875 * SizeConfig.textSizeMultiplier,),

                                Text(AppLocalization.of(context).getTranslatedValue("price"),
                                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),

                                SizedBox(height: 1.875 * SizeConfig.heightSizeMultiplier,),

                                Column(
                                  children: List.generate(5, (index) {

                                    return _price(_priceTitles[index], index);
                                  }),
                                ),

                                SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),

                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {

                                    widget.onFilterCleared();
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                      right: 2 * SizeConfig.widthSizeMultiplier,
                                    ),
                                    padding: EdgeInsets.only(
                                      top: 1 * SizeConfig.heightSizeMultiplier,
                                      bottom: 1 * SizeConfig.heightSizeMultiplier,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey[300],
                                      borderRadius: BorderRadius.circular(.25 * SizeConfig.heightSizeMultiplier),
                                    ),
                                    child: Text(AppLocalization.of(context).getTranslatedValue("clear"),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText1,
                                    ),
                                  ),
                                ),

                                SizedBox(height: 1.875 * SizeConfig.heightSizeMultiplier,),

                                GestureDetector(
                                  behavior: HitTestBehavior.opaque,
                                  onTap: () {

                                    widget.onFilterApplied();
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    margin: EdgeInsets.only(
                                      right: 2 * SizeConfig.widthSizeMultiplier,
                                    ),
                                    padding: EdgeInsets.only(
                                      top: 1 * SizeConfig.heightSizeMultiplier,
                                      bottom: 1 * SizeConfig.heightSizeMultiplier,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor,
                                      borderRadius: BorderRadius.circular(.25 * SizeConfig.heightSizeMultiplier),
                                    ),
                                    child: Text(AppLocalization.of(context).getTranslatedValue("apply"),
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context).textTheme.bodyText1.copyWith(color: Colors.white),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _sortByRadioButton(String title, int value) {

    return Column(
      children: <Widget>[

        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {

            setState(() {
              widget.filterOptions.sortValue = value;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(left: 1.28 * SizeConfig.widthSizeMultiplier),
                child: Text(title,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontSize: 1.6875 * SizeConfig.textSizeMultiplier,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),

              Transform.scale(
                scale: .68,
                child: Radio(
                  value: value,
                  groupValue: widget.filterOptions.sortValue,
                  activeColor: Colors.black.withOpacity(.75),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  visualDensity: VisualDensity(vertical: -3),
                  onChanged: (value) {

                    setState(() {
                      widget.filterOptions.sortValue = value;
                    });
                  },
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: .5 * SizeConfig.heightSizeMultiplier,),

        Padding(
          padding: EdgeInsets.only(right: 1.79 * SizeConfig.widthSizeMultiplier),
          child: Container(
            height: .0625 * SizeConfig.heightSizeMultiplier,
            color: Colors.black38,
          ),
        ),

        SizedBox(height: .5 * SizeConfig.heightSizeMultiplier,),
      ],
    );
  }


  Widget _price(String title, int index) {

    return Column(
      children: <Widget>[

        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {

            setState(() {
              widget.filterOptions.priceRangeIndex = index;
            });
          },
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              Padding(
                padding: EdgeInsets.only(left: 1.28 * SizeConfig.widthSizeMultiplier),
                child: Text(title,
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontSize: 1.6875 * SizeConfig.textSizeMultiplier,
                    fontWeight: FontWeight.normal,
                  ),
                ),
              ),

              Opacity(
                opacity: index == widget.filterOptions.priceRangeIndex ? 1 : 0,
                child: Padding(
                  padding: EdgeInsets.only(right: 2.56 * SizeConfig.widthSizeMultiplier),
                  child: Icon(Icons.check,
                    size: 5.12 * SizeConfig.imageSizeMultiplier,
                    color: Colors.black.withOpacity(.75),
                  ),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: .75 * SizeConfig.heightSizeMultiplier,),

        Padding(
          padding: EdgeInsets.only(right: 1.79 * SizeConfig.widthSizeMultiplier),
          child: Container(
            height: .0625 * SizeConfig.heightSizeMultiplier,
            color: Colors.black38,
          ),
        ),

        SizedBox(height: .875 * SizeConfig.heightSizeMultiplier,),
      ],
    );
  }
}