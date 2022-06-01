import '../model/variation.dart';
import '../localization/app_localization.dart';
import '../model/product.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class ProductVariationInfo extends StatefulWidget {

  final Product product;
  final void Function(Variation) onVariationSelected;

  ProductVariationInfo(this.product, {this.onVariationSelected});

  @override
  _ProductVariationInfoState createState() => _ProductVariationInfoState();
}

class _ProductVariationInfoState extends State<ProductVariationInfo> with ChangeNotifier {

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
                            top: .825 * SizeConfig.heightSizeMultiplier,
                            bottom: .825 * SizeConfig.heightSizeMultiplier,
                            left: 2.5 * SizeConfig.widthSizeMultiplier,
                            right: 2.5 * SizeConfig.widthSizeMultiplier,
                          ),
                          margin: EdgeInsets.only(
                            right: 3 * SizeConfig.widthSizeMultiplier,
                            bottom: 2 * SizeConfig.heightSizeMultiplier,
                          ),
                          decoration: BoxDecoration(
                              color: widget.product.selectedVariation != null && widget.product.selectedVariation.value1 == value1.name ?
                              Theme.of(context).primaryColor : Colors.grey[300],
                              borderRadius: BorderRadius.circular(.25 * SizeConfig.heightSizeMultiplier),
                          ),
                          child: Text(value1.name,
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: widget.product.selectedVariation != null && widget.product.selectedVariation.value1 == value1.name ?
                                Colors.white : Colors.black.withOpacity(.75),
                                fontSize: 1.75 * SizeConfig.textSizeMultiplier,
                                fontWeight: FontWeight.w500
                            ),
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
                      visible: value2.name.isNotEmpty && value2.variation1Name == widget.product.selectedVariation.value1,
                      child: GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {

                          _onValueSelected(value2.id);
                        },
                        child: Container(
                          padding: EdgeInsets.only(
                            top: .825 * SizeConfig.heightSizeMultiplier,
                            bottom: .825 * SizeConfig.heightSizeMultiplier,
                            left: 2.5 * SizeConfig.widthSizeMultiplier,
                            right: 2.5 * SizeConfig.widthSizeMultiplier,
                          ),
                          margin: EdgeInsets.only(
                            right: 3 * SizeConfig.widthSizeMultiplier,
                            bottom: 2 * SizeConfig.heightSizeMultiplier,
                          ),
                          decoration: BoxDecoration(
                              color: widget.product.selectedVariation != null && widget.product.selectedVariation.id == value2.id ?
                              Theme.of(context).primaryColor : Colors.grey[300],
                              borderRadius: BorderRadius.circular(.25 * SizeConfig.heightSizeMultiplier),
                          ),
                          child: Text(value2.name,
                            style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: widget.product.selectedVariation != null && widget.product.selectedVariation.id == value2.id ?
                                Colors.white : Colors.black.withOpacity(.75),
                                fontSize: 1.75 * SizeConfig.textSizeMultiplier,
                                fontWeight: FontWeight.w500
                            ),
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

          Visibility(
            visible: false,
            child: SizedBox(height: 1.875 * SizeConfig.heightSizeMultiplier,),
          ),

          Visibility(
            visible: false,
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[

                Text(AppLocalization.of(context).getTranslatedValue("stock_available") + ":",
                  style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontSize: 1.85 * SizeConfig.textSizeMultiplier,
                    fontWeight: FontWeight.w700,
                  ),
                ),

                SizedBox(width: 2.56 * SizeConfig.widthSizeMultiplier,),

                Visibility(
                  visible: widget.product != null && widget.product.id != null,
                  child: Container(
                    padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(widget.product.selectedVariation == null ?
                    AppLocalization.of(context).getTranslatedValue("out_of_stock") :
                    (widget.product.selectedVariation.stock > 0 ? widget.product.selectedVariation.stock.toString() :
                    AppLocalization.of(context).getTranslatedValue("out_of_stock")),
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
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

          widget.onVariationSelected(widget.product.variations[i]);
          break;
        }
      }
    }
  }
}