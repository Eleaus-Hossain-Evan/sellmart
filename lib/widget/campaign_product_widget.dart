import '../utils/api_routes.dart';
import '../localization/app_localization.dart';

import '../model/product.dart';
import '../utils/size_config.dart';
import '../utils/price_calculator.dart';
import 'package:flutter/material.dart';

class CampaignProductWidget extends StatefulWidget {

  final Product product;

  CampaignProductWidget(this.product);

  @override
  _CampaignProductWidgetState createState() => _CampaignProductWidgetState();
}

class _CampaignProductWidgetState extends State<CampaignProductWidget> {

  @override
  Widget build(BuildContext context) {

    return Material(
      elevation: 2,
      color: Colors.grey[100],
      borderRadius: BorderRadius.circular(.2 * SizeConfig.heightSizeMultiplier),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(.2 * SizeConfig.heightSizeMultiplier),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[

            Expanded(
              flex: 10,
              child: Stack(
                children: <Widget>[

                  Container(
                    height: double.infinity,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                      top: .25 * SizeConfig.heightSizeMultiplier,
                      right: .512 * SizeConfig.widthSizeMultiplier,
                      left: .512 * SizeConfig.widthSizeMultiplier,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(.2 * SizeConfig.heightSizeMultiplier),
                    ),
                    child: Image.network(widget.product.thumbnail ?? (APIRoute.BASE_URL + ""),
                      height: double.infinity,
                      width: double.infinity,
                      cacheHeight: 500,
                      cacheWidth: 500,
                      fit: BoxFit.fill,
                      scale: .5,
                    ),
                  ),

                  Align(
                    alignment: Alignment.topRight,
                    child: Visibility(
                      visible: widget.product.campaignOfferPrice != null && widget.product.price != null && widget.product.campaignOfferDiscount != null
                          && widget.product.campaignDiscountType != null && widget.product.campaignOfferPrice != widget.product.price,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: .475 * SizeConfig.heightSizeMultiplier,
                          bottom: .475 * SizeConfig.heightSizeMultiplier,
                          left: 2.05 * SizeConfig.widthSizeMultiplier,
                          right: 2.05 * SizeConfig.widthSizeMultiplier,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).primaryColor,
                          borderRadius: BorderRadius.circular(.2 * SizeConfig.heightSizeMultiplier),
                        ),
                        child: Text(widget.product.campaignDiscountType != null && widget.product.campaignOfferDiscount != null ?
                          (widget.product.campaignDiscountType == PriceCalculator.AMOUNT ? ("৳" + widget.product.campaignOfferDiscount.round().toString()) :
                          widget.product.campaignOfferDiscount.round().toString() + "%") : "",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 1.625 * SizeConfig.textSizeMultiplier,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: !(widget.product.currentStock != null && widget.product.currentStock > 0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        padding: EdgeInsets.only(
                          top: .7 * SizeConfig.heightSizeMultiplier,
                          bottom: .7 * SizeConfig.heightSizeMultiplier,
                          left: 5.5 * SizeConfig.widthSizeMultiplier,
                          right: 5.5 * SizeConfig.widthSizeMultiplier,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red[600],
                          borderRadius: BorderRadius.circular(1.8 * SizeConfig.heightSizeMultiplier),
                        ),
                        child: Text(AppLocalization.of(context).getTranslatedValue("out_of_stock"),
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 1.825 * SizeConfig.textSizeMultiplier,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 1.25 * SizeConfig.heightSizeMultiplier,),

            Expanded(
              flex: 2,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 2.56 * SizeConfig.widthSizeMultiplier,
                  right: 2.56 * SizeConfig.widthSizeMultiplier,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Text(widget.product.name,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                      fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                      fontWeight: FontWeight.w500,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ),

            Expanded(
              flex: 2,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 2.56 * SizeConfig.widthSizeMultiplier,
                    right: 2.56 * SizeConfig.widthSizeMultiplier,
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[

                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[

                          Text("৳" + widget.product.currentPrice.round().toString(),
                            style: Theme.of(context).textTheme.bodyText2.copyWith(
                              fontSize: 1.75 * SizeConfig.textSizeMultiplier,
                              fontWeight: FontWeight.w500,
                            ),
                          ),

                          Visibility(
                            visible: widget.product.currentPrice != widget.product.price,
                            child: Text("৳" + widget.product.price.round().toString(),
                              style: Theme.of(context).textTheme.bodyText2.copyWith(
                                fontSize: 1.5 * SizeConfig.textSizeMultiplier,
                                fontWeight: FontWeight.w400,
                                color: Colors.grey[800],
                                decoration: TextDecoration.lineThrough,
                              ),
                            ),
                          ),
                        ],
                      ),

                      Container(
                        padding: EdgeInsets.only(
                          top: .625 * SizeConfig.heightSizeMultiplier,
                          bottom: .625 * SizeConfig.heightSizeMultiplier,
                          left: 2.05 * SizeConfig.widthSizeMultiplier,
                          right: 2.05 * SizeConfig.widthSizeMultiplier,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context).accentColor,
                          borderRadius: BorderRadius.circular(1.875 * SizeConfig.heightSizeMultiplier),
                        ),
                        child: Text(AppLocalization.of(context).getTranslatedValue("buy_now"),
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                            fontSize: 1.55 * SizeConfig.textSizeMultiplier,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: .625 * SizeConfig.heightSizeMultiplier,),
          ],
        ),
      ),
    );
  }
}