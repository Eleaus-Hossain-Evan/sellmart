import '../model/product.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class CampaignProductVariationInfo extends StatefulWidget {

  final Product product;
  final String campaignEndDate;

  CampaignProductVariationInfo(this.product, this.campaignEndDate);

  @override
  _CampaignProductVariationInfoState createState() => _CampaignProductVariationInfoState();
}

class _CampaignProductVariationInfoState extends State<CampaignProductVariationInfo> with ChangeNotifier {

  @override
  Widget build(BuildContext context) {

    return Visibility(
      visible: widget.product != null && widget.product.variationType != null && (widget.product.variationType == 0 || widget.product.variationType == 1) &&
          widget.product.selectedVariation != null && widget.product.variation1Values != null
          && !(widget.product.variation1Values.length == 1 && widget.product.variation1Values[0].name.isEmpty),
      child: Column(
        children: <Widget>[

          SizedBox(height: 1.875 * SizeConfig.heightSizeMultiplier,),

          Visibility(
            visible: widget.product != null && widget.product.selectedVariation != null,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Flexible(
                  child: Wrap(
                    children: widget.product.variation1Values.asMap().map((index, value1) => MapEntry(index, Visibility(
                      visible: value1.name.isNotEmpty,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {

                          _onValueSelected(value1.id);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            top: .625 * SizeConfig.heightSizeMultiplier,
                            bottom: .625 * SizeConfig.heightSizeMultiplier,
                            left: 3.07 * SizeConfig.widthSizeMultiplier,
                            right: 3.07 * SizeConfig.widthSizeMultiplier,
                          ),
                          margin: EdgeInsets.only(
                            right: 3 * SizeConfig.widthSizeMultiplier,
                            bottom: 2 * SizeConfig.heightSizeMultiplier,
                          ),
                          decoration: BoxDecoration(
                              color: widget.product.selectedVariation != null && widget.product.selectedVariation.value1 == value1.name ?
                              Colors.blueAccent : Colors.grey[300],
                              borderRadius: BorderRadius.all(Radius.circular(3.125 * SizeConfig.heightSizeMultiplier,))
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              Visibility(
                                visible: widget.product.selectedVariation != null && widget.product.selectedVariation.value1 == value1.name,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 1.28 * SizeConfig.widthSizeMultiplier,),
                                  child: Icon(Icons.check, color: Colors.white, size: 4.35 * SizeConfig.widthSizeMultiplier,),
                                ),
                              ),

                              Text(value1.name,
                                style: Theme.of(context).textTheme.bodyText1.copyWith(
                                    color: widget.product.selectedVariation != null && widget.product.selectedVariation.value1 == value1.name ?
                                    Colors.white : Colors.black54,
                                    fontSize: 1.9375 * SizeConfig.textSizeMultiplier,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))).values.toList(),
                  ),
                ),
              ],
            ),
          ),

          Visibility(
            visible: widget.product != null && widget.product.selectedVariation != null,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[

                Flexible(
                  child: Wrap(
                    children: widget.product.variation2Values.asMap().map((index, value2) => MapEntry(index, Visibility(
                      visible: value2.name.isNotEmpty,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {

                          _onValueSelected(value2.id);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            top: .625 * SizeConfig.heightSizeMultiplier,
                            bottom: .625 * SizeConfig.heightSizeMultiplier,
                            left: 3.07 * SizeConfig.widthSizeMultiplier,
                            right: 3.07 * SizeConfig.widthSizeMultiplier,
                          ),
                          margin: EdgeInsets.only(
                            right: 3 * SizeConfig.widthSizeMultiplier,
                            bottom: 2 * SizeConfig.heightSizeMultiplier,
                          ),
                          decoration: BoxDecoration(
                              color: widget.product.selectedVariation != null && widget.product.selectedVariation.id == value2.id ?
                              Colors.blueAccent : Colors.grey[300],
                              borderRadius: BorderRadius.all(Radius.circular(3.125 * SizeConfig.heightSizeMultiplier,))
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[

                              Visibility(
                                visible: widget.product.selectedVariation != null && widget.product.selectedVariation.id == value2.id,
                                child: Padding(
                                  padding: EdgeInsets.only(right: 1.28 * SizeConfig.widthSizeMultiplier,),
                                  child: Icon(Icons.check, color: Colors.white, size: 4.35 * SizeConfig.widthSizeMultiplier,),
                                ),
                              ),

                              Text(value2.name,
                                style: Theme.of(context).textTheme.bodyText1.copyWith(
                                    color: widget.product.selectedVariation != null && widget.product.selectedVariation.id == value2.id ?
                                    Colors.white : Colors.black54,
                                    fontSize: 1.9375 * SizeConfig.textSizeMultiplier,
                                    fontWeight: FontWeight.w500
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ))).values.toList(),
                  ),
                ),
              ],
            ),
          ),

          _divider(),
        ],
      ),
    );
  }


  Widget _divider() {

    return Container(
      color: Theme.of(context).hintColor,
      height: .625 * SizeConfig.heightSizeMultiplier,
      width: double.infinity,
    );
  }


  void _onValueSelected(String variationId) {

    if(variationId != widget.product.selectedVariation.id) {

      for(int i=0; i<widget.product.variations.length; i++) {

        if(widget.product.variations[i].id == variationId) {

          setState(() {
            widget.product.selectedVariation = widget.product.variations[i];
          });

          if(widget.product.selectedVariation.stock > 0) {

            if(widget.product.quantity > widget.product.selectedVariation.stock) {

              setState(() {
                widget.product.quantity = widget.product.selectedVariation.stock;
              });
            }
          }
          else {

            setState(() {
              widget.product.quantity = 1;
            });
          }

          break;
        }
      }
    }
  }
}