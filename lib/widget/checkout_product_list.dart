import 'package:app/utils/api_routes.dart';

import '../view/bottom_nav.dart';

import '../db/db_helper.dart';
import '../model/cart_item.dart';

import '../localization/app_localization.dart';
import '../utils/size_config.dart';
import 'package:flutter/material.dart';

class CheckoutProductList extends StatefulWidget {
  final List<CartItem> items;
  final void Function() onQuantityChange;
  final bool removalActive;
  final void Function(int) deleteItem;

  CheckoutProductList(this.items, this.removalActive,
      {this.onQuantityChange, this.deleteItem});

  @override
  _CheckoutProductListState createState() => _CheckoutProductListState();
}

class _CheckoutProductListState extends State<CheckoutProductList>
    with ChangeNotifier {
  DBHelper _dbHelper = DBHelper();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
              color: Colors.grey[300],
              width: .45 * SizeConfig.widthSizeMultiplier),
          bottom: BorderSide(
              color: Colors.grey[300],
              width: .45 * SizeConfig.widthSizeMultiplier),
        ),
      ),
      child: ListView.separated(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: widget.items.length,
        separatorBuilder: (BuildContext context, int index) {
          return Container(
            height: .22 * SizeConfig.heightSizeMultiplier,
            color: Colors.grey[300],
          );
        },
        itemBuilder: (BuildContext context, int index) {
          return IntrinsicHeight(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 5.12 * SizeConfig.widthSizeMultiplier,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        // Visibility(
                        //   visible: widget.removalActive,
                        //   child: Padding(
                        //     padding: EdgeInsets.only(
                        //       right: 5.12 * SizeConfig.widthSizeMultiplier,
                        //     ),
                        //     child: GestureDetector(
                        //       behavior: HitTestBehavior.opaque,
                        //       onTap: () {

                        //         widget.deleteItem(index);
                        //       },
                        //       child: Icon(
                        //         Icons.close, size: 6.41 * SizeConfig.imageSizeMultiplier, color: Theme.of(context).primaryColor,
                        //       ),
                        //     ),
                        //   ),
                        // ),

                        Flexible(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              widget.items[index].product.thumbnail ??
                                  (APIRoute.BASE_URL + ""),
                              height: double.infinity,
                              width: double.infinity,
                              cacheHeight: 500,
                              cacheWidth: 500,
                              fit: BoxFit.fill,
                              scale: .25,
                            ),
                          ),
                        ),

                        Flexible(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 1.875 * SizeConfig.heightSizeMultiplier,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    widget.items[index].product.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  Visibility(
                                    visible: widget.removalActive,
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        right: 5.12 *
                                            SizeConfig.widthSizeMultiplier,
                                      ),
                                      child: GestureDetector(
                                        behavior: HitTestBehavior.opaque,
                                        onTap: () {
                                          widget.deleteItem(index);
                                        },
                                        child: Icon(
                                          Icons.close,
                                          size: 6.41 *
                                              SizeConfig.imageSizeMultiplier,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.5 * SizeConfig.heightSizeMultiplier,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    AppLocalization.of(context)
                                            .getTranslatedValue("tk") +
                                        ". " +
                                        widget.items[index].product.currentPrice
                                            .round()
                                            .toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          fontSize: 1.8 *
                                              SizeConfig.textSizeMultiplier,
                                          fontWeight: FontWeight.w400,
                                        ),
                                  ),
                                  IntrinsicHeight(
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            _decreaseQuantity(
                                                widget.items[index]);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(.15 *
                                                SizeConfig
                                                    .heightSizeMultiplier),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(.75 *
                                                      SizeConfig
                                                          .heightSizeMultiplier),
                                              border: Border.all(
                                                  color: widget
                                                              .items[index]
                                                              .product
                                                              .quantity >
                                                          1
                                                      ? Theme.of(context)
                                                          .primaryColor
                                                      : Colors.black26,
                                                  width: .384 *
                                                      SizeConfig
                                                          .widthSizeMultiplier),
                                            ),
                                            child: Icon(
                                              Icons.remove,
                                              size: 6 *
                                                  SizeConfig
                                                      .widthSizeMultiplier,
                                              color: widget.items[index].product
                                                          .quantity >
                                                      1
                                                  ? Theme.of(context)
                                                      .primaryColor
                                                  : Colors.black26,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                            top: .15 *
                                                SizeConfig.heightSizeMultiplier,
                                            bottom: .15 *
                                                SizeConfig.heightSizeMultiplier,
                                            left: 2.8 *
                                                SizeConfig.widthSizeMultiplier,
                                            right: 2.8 *
                                                SizeConfig.widthSizeMultiplier,
                                          ),
                                          child: Text(
                                            widget.items[index].product.quantity
                                                .toString(),
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1,
                                          ),
                                        ),
                                        GestureDetector(
                                          behavior: HitTestBehavior.opaque,
                                          onTap: () {
                                            _checkQuantity(widget.items[index]);
                                          },
                                          child: Container(
                                            padding: EdgeInsets.all(.15 *
                                                SizeConfig
                                                    .heightSizeMultiplier),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(.75 *
                                                      SizeConfig
                                                          .heightSizeMultiplier),
                                              border: Border.all(
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  width: .384 *
                                                      SizeConfig
                                                          .widthSizeMultiplier),
                                            ),
                                            child: Icon(
                                              Icons.add,
                                              size: 6 *
                                                  SizeConfig
                                                      .widthSizeMultiplier,
                                              color: Theme.of(context)
                                                  .primaryColor,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 1.875 * SizeConfig.heightSizeMultiplier,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 5.12 * SizeConfig.widthSizeMultiplier,
                ),
                Column(
                  children: List.generate(
                      200 ~/ 8,
                      (index) => Expanded(
                            child: Container(
                              color: index % 2 == 0
                                  ? Colors.transparent
                                  : Colors.grey[400],
                              width: .4 * SizeConfig.widthSizeMultiplier,
                            ),
                          )),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding:
                        EdgeInsets.all(1.25 * SizeConfig.heightSizeMultiplier),
                    child: Center(
                      child: Text(
                        AppLocalization.of(context).getTranslatedValue("tk") +
                            ". " +
                            (widget.items[index].product.currentPrice *
                                    widget.items[index].product.quantity)
                                .round()
                                .toString(),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: Colors.black.withOpacity(.65),
                            ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Future<void> _checkQuantity(CartItem item) async {
    if ((item.product.variationType == 0 || item.product.variationType == 1)) {
      if (item.product.selectedVariation != null &&
          item.product.selectedVariation.id != null) {
        if (item.product.quantity < item.product.selectedVariation.stock) {
          _increaseQuantity(item);
        }
      } else if (item.product.currentStock != null) {
        if (item.product.quantity < item.product.currentStock) {
          _increaseQuantity(item);
        }
      }
    } else {
      if (item.product.selectedInfoSizeStock != null &&
          item.product.quantity < item.product.selectedInfoSizeStock) {
        _increaseQuantity(item);
      }
    }
  }

  Future<void> _increaseQuantity(CartItem item) async {
    item.product.quantity = item.product.quantity + 1;

    _dbHelper.updateProduct(item.position, item.product);

    numberOfItems.value = await _dbHelper.getProductCount();
    numberOfItems.notifyListeners();

    setState(() {});

    widget.onQuantityChange();
  }

  Future<void> _decreaseQuantity(CartItem item) async {
    if (item.product.quantity > 1) {
      item.product.quantity = item.product.quantity - 1;

      _dbHelper.updateProduct(item.position, item.product);

      numberOfItems.value = await _dbHelper.getProductCount();
      numberOfItems.notifyListeners();

      setState(() {});

      widget.onQuantityChange();
    }
  }
}
