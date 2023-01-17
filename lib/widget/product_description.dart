import 'package:extended_image/extended_image.dart';
import 'package:logger/logger.dart';

import '../localization/app_localization.dart';
import '../model/product.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import '../view/products.dart' as product_widget;

class ProductDescription extends StatefulWidget {
  final Product product;

  ProductDescription(this.product);

  @override
  _ProductDescriptionState createState() => _ProductDescriptionState();
}

class _ProductDescriptionState extends State<ProductDescription> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: 1.875 * SizeConfig.heightSizeMultiplier,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppLocalization.of(context).getTranslatedValue("description"),
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        SizedBox(
          height: 1.875 * SizeConfig.heightSizeMultiplier,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: widget.product.description == null ||
                  widget.product.description.isEmpty
              ? Container()
              : Html(
                  data: widget.product.description,
                  style: {
                    "body": Style(
                      fontSize: FontSize(2.25 * SizeConfig.textSizeMultiplier),
                      fontWeight: FontWeight.w400,
                    ),
                  },
                ),
        ),
        SizedBox(
          height: widget.product.description == null ||
                  widget.product.description.isEmpty
              ? .625 * SizeConfig.heightSizeMultiplier
              : 3.625 * SizeConfig.heightSizeMultiplier,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            AppLocalization.of(context).getTranslatedValue("product_details"),
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.w700,
                ),
          ),
        ),
        SizedBox(
          height: 1.25 * SizeConfig.heightSizeMultiplier,
        ),
        Padding(
          padding: EdgeInsets.only(
            top: .4375 * SizeConfig.heightSizeMultiplier,
            bottom: .375 * SizeConfig.heightSizeMultiplier,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  AppLocalization.of(context).getTranslatedValue("sku"),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontSize: 1.9 * SizeConfig.textSizeMultiplier,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45,
                      ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  widget.product != null && widget.product.sku != null
                      ? widget.product.sku
                      : "",
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontSize: 1.9 * SizeConfig.textSizeMultiplier,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(.75),
                      ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: .4375 * SizeConfig.heightSizeMultiplier,
            bottom: .375 * SizeConfig.heightSizeMultiplier,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  AppLocalization.of(context).getTranslatedValue("brand"),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontSize: 1.9 * SizeConfig.textSizeMultiplier,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45,
                      ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  widget.product != null && widget.product.brand != null
                      ? widget.product.brand.name
                      : "",
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontSize: 1.9 * SizeConfig.textSizeMultiplier,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(.75),
                      ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: .4375 * SizeConfig.heightSizeMultiplier,
            bottom: .375 * SizeConfig.heightSizeMultiplier,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  AppLocalization.of(context).getTranslatedValue("category"),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontSize: 1.9 * SizeConfig.textSizeMultiplier,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45,
                      ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  widget.product != null && widget.product.category != null
                      ? widget.product.category.name
                      : "",
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontSize: 1.9 * SizeConfig.textSizeMultiplier,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(.75),
                      ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.only(
            top: .4375 * SizeConfig.heightSizeMultiplier,
            bottom: .375 * SizeConfig.heightSizeMultiplier,
          ),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Text(
                  AppLocalization.of(context)
                      .getTranslatedValue("sub_category"),
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontSize: 1.9 * SizeConfig.textSizeMultiplier,
                        fontWeight: FontWeight.w500,
                        color: Colors.black45,
                      ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Text(
                  widget.product != null && widget.product.subCategory != null
                      ? widget.product.subCategory.name
                      : "",
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        fontSize: 1.9 * SizeConfig.textSizeMultiplier,
                        fontWeight: FontWeight.w500,
                        color: Colors.black.withOpacity(.75),
                      ),
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: widget.product != null &&
              widget.product.brand != null &&
              widget.product.brand.id != null &&
              widget.product.brand.id.isNotEmpty,
          child: Padding(
            padding: EdgeInsets.only(
              top: 3.75 * SizeConfig.heightSizeMultiplier,
            ),
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         product_widget.Products(brand: widget.product.brand),
                //   ),
                // );
                // Logger().i(widget.product.brand.slug);
              },
              child: Card(
                elevation: 5,
                color: Colors.white,
                child: Container(
                  height: 10.5 * SizeConfig.heightSizeMultiplier,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(
                        1 * SizeConfig.heightSizeMultiplier),
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 3 * SizeConfig.widthSizeMultiplier,
                    vertical: .5 * SizeConfig.heightSizeMultiplier,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(
                            .625 * SizeConfig.heightSizeMultiplier),
                        child: SizedBox(
                          height: 10.5 * SizeConfig.heightSizeMultiplier,
                          width: 10.5 * SizeConfig.heightSizeMultiplier,
                          child: ExtendedImage.network(
                            widget.product != null &&
                                    widget.product.brand != null &&
                                    widget.product.brand.image != null &&
                                    widget.product.brand.image.isNotEmpty
                                ? widget.product.brand.image
                                : "",
                            fit: BoxFit.fill,
                            cache: true,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 5 * SizeConfig.heightSizeMultiplier,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: EdgeInsets.only(
                              left: 5.12 * SizeConfig.widthSizeMultiplier),
                          child: Text(
                            widget.product != null &&
                                    widget.product.brand != null
                                ? widget.product.brand.name
                                : "",
                            style: Theme.of(context).textTheme.subtitle2,
                            maxLines: 3,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      // Expanded(
                      //   flex: 3,
                      //   child: Column(
                      //     mainAxisSize: MainAxisSize.max,
                      //     mainAxisAlignment: MainAxisAlignment.center,
                      //     crossAxisAlignment: CrossAxisAlignment.center,
                      //     children: <Widget>[
                      //       Container(
                      //         padding: EdgeInsets.only(
                      //           top: .875 * SizeConfig.heightSizeMultiplier,
                      //           bottom: .875 * SizeConfig.heightSizeMultiplier,
                      //           left: 3.07 * SizeConfig.widthSizeMultiplier,
                      //           right: 3.07 * SizeConfig.widthSizeMultiplier,
                      //         ),
                      //         decoration: BoxDecoration(
                      //           color: Colors.blue.withOpacity(.35),
                      //           borderRadius: BorderRadius.circular(
                      //               .25 * SizeConfig.heightSizeMultiplier),
                      //         ),
                      //         child: Text(
                      //           AppLocalization.of(context)
                      //               .getTranslatedValue("visit_brand"),
                      //           maxLines: 1,
                      //           overflow: TextOverflow.ellipsis,
                      //           style: Theme.of(context)
                      //               .textTheme
                      //               .bodyText2
                      //               .copyWith(
                      //                 fontWeight: FontWeight.w500,
                      //                 color: Colors.blue[800],
                      //               ),
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3.125 * SizeConfig.heightSizeMultiplier,
        ),
      ],
    );
  }
}
