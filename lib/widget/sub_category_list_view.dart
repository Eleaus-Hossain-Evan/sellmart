import '../model/sub_category.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class SubCategoryListView extends StatefulWidget {

  final List<SubCategory> subCategories;
  final void Function(SubCategory) onSubCategorySelected;

  SubCategoryListView(this.subCategories, {this.onSubCategorySelected});

  @override
  _SubCategoryListViewState createState() => _SubCategoryListViewState();
}

class _SubCategoryListViewState extends State<SubCategoryListView>{

  @override
  Widget build(BuildContext context) {

    return Expanded(
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (overScroll) {
          overScroll.disallowGlow();
          return;
        },
        child: ListView.separated(
          itemCount: widget.subCategories == null ? 0 : widget.subCategories.length,
          separatorBuilder: (context, index) {

            return Container(
              height: .0625 * SizeConfig.heightSizeMultiplier,
              color: Colors.black26,
            );
          },
          itemBuilder: (context, index) {

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {

                widget.onSubCategorySelected(widget.subCategories[index]);
              },
              child: Container(
                height: 11.25 * SizeConfig.heightSizeMultiplier,
                color: Colors.white,
                padding: EdgeInsets.only(
                  left: 6.41 * SizeConfig.widthSizeMultiplier,
                  right: 3.84 * SizeConfig.widthSizeMultiplier,
                ),
                child: Row(
                  children: <Widget>[

                    Expanded(
                      flex: 1,
                      child: Image.network(widget.subCategories[index].image ?? "",
                        height: 7.5 * SizeConfig.heightSizeMultiplier,
                        width: 15.38 * SizeConfig.widthSizeMultiplier,
                        fit: BoxFit.fill,
                        errorBuilder: (context, url, error) => Icon(Icons.image,
                          size: 8 * SizeConfig.heightSizeMultiplier,
                          color: Colors.black26,
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: EdgeInsets.only(left: 7.69 * SizeConfig.widthSizeMultiplier),
                        child: Text(widget.subCategories[index].name ?? "",
                          style: Theme.of(context).textTheme.subtitle2,
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),

                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: EdgeInsets.all(.625 * SizeConfig.heightSizeMultiplier),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.black38, width: .12 * SizeConfig.widthSizeMultiplier),
                        ),
                        child: Icon(
                          Icons.arrow_forward_ios,
                          size: 5.12 * SizeConfig.imageSizeMultiplier,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}