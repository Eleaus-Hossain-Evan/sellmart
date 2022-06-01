import '../model/category.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class CategoryListView extends StatefulWidget {

  final List<Category> categories;
  final int selectedCategoryIndex;
  final void Function(int) onCategorySelected;

  CategoryListView(this.categories, this.selectedCategoryIndex, {this.onCategorySelected});

  @override
  _CategoryListViewState createState() => _CategoryListViewState();
}

class _CategoryListViewState extends State<CategoryListView> {

  @override
  Widget build(BuildContext context) {

    return Expanded(
      flex: 1,
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          left: 2 * SizeConfig.widthSizeMultiplier,
          right: 2 * SizeConfig.widthSizeMultiplier,
          bottom: 1 * SizeConfig.heightSizeMultiplier,
        ),
        child: NotificationListener <OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowGlow();
            return;
          },
          child: ListView.separated(
            itemCount: widget.categories == null ? 0 : widget.categories.length,
            padding: EdgeInsets.only(
              top: 1.25 * SizeConfig.heightSizeMultiplier,
            ),
            separatorBuilder: (BuildContext context, int index) {

              return SizedBox(height: .625 * SizeConfig.heightSizeMultiplier);
            },
            itemBuilder: (BuildContext context, int index) {

              return GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {

                  widget.onCategorySelected(index);
                },
                child: Container(
                  padding: EdgeInsets.only(
                    top: .875 * SizeConfig.heightSizeMultiplier,
                    bottom: .875 * SizeConfig.heightSizeMultiplier,
                    left: 2.7 * SizeConfig.widthSizeMultiplier,
                    right: 2.7 * SizeConfig.widthSizeMultiplier,
                  ),
                  decoration: BoxDecoration(
                    color: widget.selectedCategoryIndex != null && widget.selectedCategoryIndex == index ? Theme.of(context).primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(1 * SizeConfig.heightSizeMultiplier),
                  ),
                  child: Text(widget.categories[index].name ?? "",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                      fontWeight: FontWeight.w400,
                      color: widget.selectedCategoryIndex != null && widget.selectedCategoryIndex == index ? Colors.white : Colors.black,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}