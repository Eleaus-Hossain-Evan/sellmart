import '../localization/app_localization.dart';
import '../model/product.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

import 'product_grid_view.dart';

class SimilarProducts extends StatefulWidget {

  final List<Product> similarProducts;
  final bool isCampaignOffer;
  final String campaignSlug;

  SimilarProducts(this.similarProducts, this.isCampaignOffer, {this.campaignSlug});

  @override
  _SimilarProductsState createState() => _SimilarProductsState();
}

class _SimilarProductsState extends State<SimilarProducts> {

  @override
  Widget build(BuildContext context) {

    return Container(
      color: Colors.white,
      child: Column(
        children: <Widget>[

          Container(
            color: Theme.of(context).hintColor,
            height: .625 * SizeConfig.heightSizeMultiplier,
            width: double.infinity,
            margin: EdgeInsets.only(
              left: 3.84 * SizeConfig.widthSizeMultiplier,
              right: 3.84 * SizeConfig.widthSizeMultiplier,
            ),
          ),

          SizedBox(height: 2.5 * SizeConfig.heightSizeMultiplier,),

          Text(AppLocalization.of(context).getTranslatedValue("similar_products"),
            style: Theme.of(context).textTheme.subtitle2.copyWith(
              fontWeight: FontWeight.w700,
            ),
          ),

          SizedBox(height: 1.875 * SizeConfig.heightSizeMultiplier,),

          ProductGridView(widget.similarProducts, widget.isCampaignOffer, campaignSlug: widget.campaignSlug,),

          SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),
        ],
      ),
    );
  }
}