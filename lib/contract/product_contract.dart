import '../model/brand.dart';
import '../model/category.dart';
import '../model/shop.dart';
import '../model/sub_category.dart';
import '../model/sub_sub_category.dart';
import '../model/product.dart';
import 'package:flutter/material.dart';

abstract class ProductContract {

  void productsByBrand(BrandProducts brandProducts);
  void productsByShop(ShopProducts shopProducts);
  void productsByCategory(CategoryProducts categoryProducts);
  void productsBySubCategory(SubCategoryProducts subCategoryProducts);
  void productsBySubSubCategory(SubSubCategoryProducts subSubCategoryProducts);
  void discountedProducts(DiscountedProducts discountedProducts);
  void onFailure(BuildContext context);
}