import 'package:app/model/category.dart';

import '../model/brand.dart';
import '../model/product.dart';
import '../model/shop.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'brand_grid_view.dart';
import 'category_grid_view.dart';
import 'product_grid_view.dart';
import 'shop_grid_view.dart';

class SearchDataWidget extends StatefulWidget {
  final List<Product> products;
  final List<Category> categories;
  final List<Brand> brands;
  final List<Shop> shops;
  final int typeValue;

  const SearchDataWidget(
      {this.products,
      this.categories,
      this.brands,
      this.shops,
      this.typeValue});

  @override
  _SearchDataWidgetState createState() => _SearchDataWidgetState();
}

class _SearchDataWidgetState extends State<SearchDataWidget> {
  int _selectedCategoryIndex = 0;
  @override
  Widget build(BuildContext context) {
    return IndexedStack(
      index: widget.typeValue,
      children: <Widget>[
        NotificationListener<OverscrollIndicatorNotification>(
          onNotification: (overScroll) {
            overScroll.disallowGlow();
            return;
          },
          child: SingleChildScrollView(
            child: ProductGridView(widget.products, false),
          ),
        ),
        CategoryGridView(categories: widget.categories),
        ShopGridView(widget.shops),
        BrandGridView(widget.brands),
      ],
    );
  }
}
