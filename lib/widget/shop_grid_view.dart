import '../model/shop.dart';
import '../utils/size_config.dart';
import '../view/products.dart';
import 'package:flutter/material.dart';

import 'shop_widget.dart';

class ShopGridView extends StatefulWidget {

  final List<Shop> shops;

  ShopGridView(this.shops);

  @override
  _ShopGridViewState createState() => _ShopGridViewState();
}

class _ShopGridViewState extends State<ShopGridView> {

  @override
  Widget build(BuildContext context) {

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowGlow();
        return;
      },
      child: SingleChildScrollView(
        child: GridView.builder(
          itemCount: widget.shops.length,
          shrinkWrap: true,
          cacheExtent: 50,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            mainAxisSpacing: .125 * SizeConfig.heightSizeMultiplier,
            crossAxisSpacing: 2 * SizeConfig.widthSizeMultiplier,
            childAspectRatio: .65,
          ),
          padding: EdgeInsets.only(
            top: 1 * SizeConfig.heightSizeMultiplier,
            left: 2.9 * SizeConfig.widthSizeMultiplier,
            right: 2.9 * SizeConfig.widthSizeMultiplier,
          ),
          itemBuilder: (context, index) {

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {

                Navigator.push(context, MaterialPageRoute(builder: (context) => Products(shop: widget.shops[index])));
              },
              child: ShopWidget(widget.shops[index]),
            );
          },
        ),
      ),
    );
  }
}