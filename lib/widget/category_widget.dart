import '../model/category.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {

  final Category category;
  final String selectedCategoryId;

  CategoryWidget(this.category, {this.selectedCategoryId});

  @override
  _CategoryWidgetState createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {

  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[

        PhysicalModel(
            elevation: 1,
            color: Colors.white,
            borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
            child: Container(
              height: 7.5 * SizeConfig.heightSizeMultiplier,
              width: 15.38 * SizeConfig.widthSizeMultiplier,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(.625 * SizeConfig.heightSizeMultiplier),
                image: DecorationImage(
                  image: NetworkImage(widget.category.image ?? ""),
                  fit: BoxFit.fill,
                ),
              ),
            ),
        ),

        SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

        Container(
          width: 16.66 * SizeConfig.widthSizeMultiplier,
          alignment: Alignment.center,
          child: Text(widget.category.name ?? "",
            style: Theme.of(context).textTheme.bodyText2.copyWith(
              fontSize: 1.4 * SizeConfig.textSizeMultiplier,
              fontWeight: FontWeight.w500
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}