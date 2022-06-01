import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {

  final void Function(String) onTextChanged;

  SearchBox({this.onTextChanged});

  @override
  _SearchBoxState createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {

  @override
  Widget build(BuildContext context) {

    return TextField(
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      style: Theme.of(context).textTheme.bodyText2,
      onChanged: (string) {

        widget.onTextChanged(string);
      },
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.black45,),
        hintText: AppLocalization.of(context).getTranslatedValue("search_by_name"),
        hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(color: Colors.black54),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
          borderSide: BorderSide(width: .25 * SizeConfig.widthSizeMultiplier, color: Colors.black45,),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
          borderSide: BorderSide(width: .25 * SizeConfig.widthSizeMultiplier, color: Colors.black45,),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(.5 * SizeConfig.heightSizeMultiplier),
          borderSide: BorderSide(width: .25 * SizeConfig.widthSizeMultiplier, color: Colors.black45,),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.all(1.6875 * SizeConfig.heightSizeMultiplier),
      ),
    );
  }
}