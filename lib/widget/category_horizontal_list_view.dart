import 'package:extended_image/extended_image.dart';

import '../view/products.dart';

import '../model/category.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class CategoryHorizontalListView extends StatefulWidget {

  final List<Category> categories;

  CategoryHorizontalListView(this.categories);

  @override
  _CategoryHorizontalListViewState createState() => _CategoryHorizontalListViewState();
}

class _CategoryHorizontalListViewState extends State<CategoryHorizontalListView> {

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: widget.categories.length > 0,
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return;
        },
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: 1.5 * SizeConfig.heightSizeMultiplier,
              left: 2.56 * SizeConfig.widthSizeMultiplier,
              right: 2.56 * SizeConfig.widthSizeMultiplier,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(widget.categories == null ? 0 : widget.categories.length, (index) =>

                  Padding(
                    padding: EdgeInsets.only(right: index < widget.categories.length - 1 ? 3.5 * SizeConfig.widthSizeMultiplier : 0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {

                        _onCategorySelected(widget.categories[index]);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          Material(
                            elevation: 1,
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(.375 * SizeConfig.heightSizeMultiplier),
                            child: Container(
                              height: 7.5 * SizeConfig.heightSizeMultiplier,
                              width: 15.38 * SizeConfig.widthSizeMultiplier,
                              padding: EdgeInsets.all(.375 * SizeConfig.heightSizeMultiplier),
                              child: Image.network(widget.categories[index].image ?? "",
                                cacheHeight: 200,
                                cacheWidth: 200,
                                scale: .5,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),

                          SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

                          Container(
                            width: 16.66 * SizeConfig.widthSizeMultiplier,
                            alignment: Alignment.center,
                            child: Text(widget.categories[index].name ?? "",
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: Theme.of(context).textTheme.bodyText2.copyWith(
                                  fontSize: 1.4 * SizeConfig.textSizeMultiplier,
                                  fontWeight: FontWeight.w500
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }


  void _onCategorySelected(Category category) {

    Navigator.push(context, MaterialPageRoute(builder: (context) => Products(category: category)));
  }
}