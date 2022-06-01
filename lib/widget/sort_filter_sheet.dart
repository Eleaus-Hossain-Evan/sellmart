import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class SortFilterSheet extends StatefulWidget {

  final int sortValue;
  final void Function(int) onSelected;

  SortFilterSheet(this.sortValue, {this.onSelected});

  @override
  SortFilterSheetState createState() => SortFilterSheetState();
}

class SortFilterSheetState extends State<SortFilterSheet> {

  List<String> _sortTitles = ["", "", ""];

  @override
  void didChangeDependencies() {

    _sortTitles[0] = AppLocalization.of(context).getTranslatedValue("relevance");
    _sortTitles[1] = AppLocalization.of(context).getTranslatedValue("price_l2h");
    _sortTitles[2] = AppLocalization.of(context).getTranslatedValue("price_h2l");

    super.didChangeDependencies();
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
          topLeft: Radius.circular(2.56 * SizeConfig.widthSizeMultiplier),
          topRight: Radius.circular(2.56 * SizeConfig.widthSizeMultiplier),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[

          SizedBox(height: 3.75 * SizeConfig.heightSizeMultiplier,),

          Text(AppLocalization.of(context).getTranslatedValue("sort_by"),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
              fontWeight: FontWeight.w500,
              color: Colors.black.withOpacity(.65),
            ),
          ),

          SizedBox(height: 1.5 * SizeConfig.heightSizeMultiplier,),

          Column(
            children: List.generate(3, (index) {

              return _sortRadioButton(_sortTitles[index], index);
            }),
          ),

          SizedBox(height: 10 * SizeConfig.heightSizeMultiplier,),
        ],
      ),
    );
  }


  Widget _sortRadioButton(String title, int value) {

    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {

        _onSelected(value);
      },
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[

          Transform.scale(
            scale: 1.1,
            child: Radio(
              value: value,
              groupValue: widget.sortValue,
              activeColor: Theme.of(context).primaryColor,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              visualDensity: VisualDensity(vertical: 0),
              onChanged: _onSelected,
            ),
          ),

          Padding(
            padding: EdgeInsets.only(left: 1.28 * SizeConfig.widthSizeMultiplier),
            child: Text(title,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                fontSize: 2.2 * SizeConfig.textSizeMultiplier,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
        ],
      ),
    );
  }


  void _onSelected(int value) {

    if(widget.sortValue != value) {

      Navigator.of(context).pop();
      widget.onSelected(value);
    }
  }
}