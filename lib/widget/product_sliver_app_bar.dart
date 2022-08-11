import 'package:app/model/product.dart';
import 'package:flutter/material.dart';
import '../utils/size_config.dart';
import 'product_image_slider.dart';

class ProductSliverAppBar extends StatefulWidget {
  final Product product;

  ProductSliverAppBar(this.product);

  @override
  _ProductSliverAppBarState createState() => _ProductSliverAppBarState();
}

class _ProductSliverAppBarState extends State<ProductSliverAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: false,
      floating: false,
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      elevation: 0,
      expandedHeight: 33.75 * SizeConfig.heightSizeMultiplier,
      flexibleSpace: FlexibleSpaceBar(
        background: ProductImageSlider(widget.product),
      ),
    );
  }
}
