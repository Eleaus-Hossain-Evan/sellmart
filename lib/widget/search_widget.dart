import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class SearchWidget extends StatefulWidget {

  final void Function(String) onChanged;

  SearchWidget({this.onChanged});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {

  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 8 * SizeConfig.heightSizeMultiplier,
      padding: EdgeInsets.only(
        left: 2.56 * SizeConfig.widthSizeMultiplier,
        right: 2.56 * SizeConfig.widthSizeMultiplier,
      ),
      child: Align(
        alignment: Alignment.bottomCenter,
        child: TextField(
          controller: _controller,
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.done,
          onChanged: (pattern) {

            widget.onChanged(pattern);
          },
          style: Theme.of(context).textTheme.bodyText1.copyWith(
            fontWeight: FontWeight.w400,
          ),
          decoration: InputDecoration(
            hintText: AppLocalization.of(context).getTranslatedValue("search_for"),
            hintStyle: Theme.of(context).textTheme.bodyText1.copyWith(
              color: Colors.black.withOpacity(.5),
              fontWeight: FontWeight.w400,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
              borderSide: BorderSide(color: Colors.black54, width: .25 * SizeConfig.widthSizeMultiplier),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
              borderSide: BorderSide(color: Colors.black54, width: .25 * SizeConfig.widthSizeMultiplier),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
              borderSide: BorderSide(color: Colors.black54, width: .25 * SizeConfig.widthSizeMultiplier),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
              borderSide: BorderSide(color: Colors.black38, width: .25 * SizeConfig.widthSizeMultiplier),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 2.56 * SizeConfig.widthSizeMultiplier,
              vertical: 1 * SizeConfig.heightSizeMultiplier,
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
      ),
    );
  }
}