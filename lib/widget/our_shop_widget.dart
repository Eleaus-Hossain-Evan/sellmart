import '../view/products.dart';

import '../model/shop.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'shop_widget.dart';

class OurShopWidget extends StatefulWidget {

  final List<Shop> shops;

  OurShopWidget(this.shops);

  @override
  _OurShopWidgetState createState() => _OurShopWidgetState();
}

class _OurShopWidgetState extends State<OurShopWidget> {

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: widget.shops.length > 0,
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
            children: List.generate(widget.shops == null ? 0 : widget.shops.length, (index) =>

                Padding(
                  padding: EdgeInsets.only(right: index < widget.shops.length - 1 ? 2.5 * SizeConfig.widthSizeMultiplier : 0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {

                      _onShopSelected(widget.shops[index]);
                    },
                    child: ShopWidget(widget.shops[index]),
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }

  void _onShopSelected(Shop shop) {

    Navigator.push(context, MaterialPageRoute(builder: (context) => Products(shop: shop)));
  }
}