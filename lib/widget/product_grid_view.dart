import '../view/campaign_product_details.dart';

import '../model/product.dart';
import '../utils/size_config.dart';
import '../view/product_details.dart';
import 'package:flutter/material.dart';

import 'campaign_product_widget.dart';
import 'product_widget.dart';

class ProductGridView extends StatefulWidget {

  final List<Product> products;
  final bool campaignProduct;
  final String campaignSlug;
  final String campaignEndDate;

  ProductGridView(this.products, this.campaignProduct, {this.campaignSlug, this.campaignEndDate});

  @override
  _ProductGridViewState createState() => _ProductGridViewState();
}

class _ProductGridViewState extends State<ProductGridView> {

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: widget.products.length > 0,
      child: GridView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        cacheExtent: 20,
        itemCount: widget.products == null ? 0 : widget.products.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 1 * SizeConfig.heightSizeMultiplier,
          crossAxisSpacing: 2.2 * SizeConfig.widthSizeMultiplier,
          childAspectRatio: .7,
        ),
        padding: EdgeInsets.only(
          top: 1 * SizeConfig.heightSizeMultiplier,
          bottom: 1.875 * SizeConfig.heightSizeMultiplier,
          left: 2.9 * SizeConfig.widthSizeMultiplier,
          right: 2.9 * SizeConfig.widthSizeMultiplier,
        ),
        itemBuilder: (context, index) {

          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {

              if(widget.products[index].currentStock != null && widget.products[index].currentStock > 0) {

                if(widget.campaignProduct) {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => CampaignProductDetails(widget.products[index].slug, widget.campaignSlug, widget.campaignEndDate)));
                }
                else {

                  Navigator.push(context, MaterialPageRoute(builder: (context) => ProductDetails(widget.products[index].slug)));
                }
              }
            },
            child: widget.campaignProduct ? CampaignProductWidget(widget.products[index]) : ProductWidget(widget.products[index]),
          );
        },
      ),
    );
  }
}