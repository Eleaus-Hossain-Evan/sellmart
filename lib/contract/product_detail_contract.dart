import '../model/product.dart';
import 'package:flutter/material.dart';

abstract class ProductDetailContract {

  void onSuccess(Product product, List<Product> similarProducts);
  void onFailure(BuildContext context);
  void onAddedToWishList(BuildContext context);
  void onRemovedFromWishList(BuildContext context);
  void onFailedToAddOrRemovedWishList(BuildContext context, String message);
}