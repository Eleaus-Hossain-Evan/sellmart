import '../model/brand.dart';
import '../model/product.dart';
import '../model/shop.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'brand_grid_view.dart';
import 'product_grid_view.dart';
import 'shop_grid_view.dart';

class SearchDataWidget extends StatefulWidget {

  final List<Product> products;
  final List<Brand> brands;
  final List<Shop> shops;
  final int typeValue;

  const SearchDataWidget({this.products, this.brands, this.shops, this.typeValue});

  @override
  _SearchDataWidgetState createState() => _SearchDataWidgetState();
}

class _SearchDataWidgetState extends State<SearchDataWidget> {

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

        BrandGridView(widget.brands),

        ShopGridView(widget.shops),
      ],
    );
  }
}