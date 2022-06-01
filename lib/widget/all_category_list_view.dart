import '../model/category.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'category_widget.dart';

class AllCategoryListView extends StatefulWidget {

  final List<Category> categories;
  final void Function(Category) onCategorySelected;

  AllCategoryListView(this.categories, {this.onCategorySelected});

  @override
  _AllCategoryListViewState createState() => _AllCategoryListViewState();
}

class _AllCategoryListViewState extends State<AllCategoryListView> {

  Category _selectedCategory;

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
            padding: EdgeInsets.all(1.25 * SizeConfig.heightSizeMultiplier),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(widget.categories == null ? 0 : widget.categories.length, (index) =>

                  Padding(
                    padding: EdgeInsets.only(right: index < widget.categories.length - 1 ? 4.61 * SizeConfig.widthSizeMultiplier : 0),
                    child: GestureDetector(
                      behavior: HitTestBehavior.opaque,
                      onTap: () {

                        _onSelected(widget.categories[index]);
                      },
                      child: CategoryWidget(widget.categories[index], selectedCategoryId: _selectedCategory == null || _selectedCategory.id == null ||
                          _selectedCategory.id.isEmpty ? "" : _selectedCategory.id),
                    ),
                  )
              ),
            ),
          ),
        ),
      ),
    );
  }


  void _onSelected(Category category) {

    try {

      setState(() {
        _selectedCategory = category;
      });
    }
    catch(error) {

      _selectedCategory = category;
    }

    widget.onCategorySelected(_selectedCategory);
  }
}