import '../model/brand.dart';
import '../route/route_manager.dart';
import '../utils/size_config.dart';
import '../view/products.dart';
import 'package:flutter/material.dart';

import 'brand_widget.dart';

class BrandGridView extends StatefulWidget {

  final List<Brand> brands;

  BrandGridView(this.brands);

  @override
  _BrandGridViewState createState() => _BrandGridViewState();
}

class _BrandGridViewState extends State<BrandGridView> {

  @override
  Widget build(BuildContext context) {

    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowGlow();
        return;
      },
      child: SingleChildScrollView(
        child: GridView.builder(
          itemCount: widget.brands.length,
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

                Navigator.push(context, MaterialPageRoute(builder: (context) => Products(brand: widget.brands[index])));
              },
              child: BrandWidget(widget.brands[index]),
            );
          },
        ),
      ),
    );
  }
}