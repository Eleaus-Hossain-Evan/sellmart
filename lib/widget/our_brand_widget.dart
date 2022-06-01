import '../view/products.dart';

import '../model/brand.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'brand_widget.dart';

class OurBrandWidget extends StatefulWidget {

  final List<Brand> brands;

  OurBrandWidget(this.brands);

  @override
  _OurBrandWidgetState createState() => _OurBrandWidgetState();
}

class _OurBrandWidgetState extends State<OurBrandWidget> {

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: widget.brands.length > 0,
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
            children: List.generate(widget.brands == null ? 0 : widget.brands.length, (index) =>

                Padding(
                  padding: EdgeInsets.only(right: index < widget.brands.length - 1 ? 2 * SizeConfig.widthSizeMultiplier : 0),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {

                      _onBrandSelected(widget.brands[index]);
                    },
                    child: BrandWidget(widget.brands[index]),
                  ),
                )
            ),
          ),
        ),
      ),
    );
  }


  void _onBrandSelected(Brand brand) {

    Navigator.push(context, MaterialPageRoute(builder: (context) => Products(brand: brand)));
  }
}