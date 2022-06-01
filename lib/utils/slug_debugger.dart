import 'package:flutter/material.dart';
import '../view/products.dart';
import '../model/category.dart';
import '../model/sub_category.dart';
import '../model/sub_sub_category.dart';
import '../model/brand.dart';
import '../model/shop.dart';
import '../view/single_campaign.dart';

class SlugDebugger {

  static const String CATEGORY = "category";
  static const String SUB_CATEGORY = "subcategory";
  static const String SUB_SUB_CATEGORY = "subsubcategory";
  static const String BRAND = "brand";
  static const String SHOP = "shop";

  static void debug(BuildContext context, String title, String slug) {

    if(slug != null && slug.isNotEmpty && slug.contains("/")) {

      if(slug.lastIndexOf("/") == 0) {

        String slugName = slug.substring(1, slug.length);

        if(slugName.isNotEmpty) {

          Navigator.push(context, MaterialPageRoute(builder: (context) => SingleCampaign(slugName)));
        }
      }
      else {

        int lastIndex = slug.lastIndexOf("/");

        String slugName = slug.substring(lastIndex + 1, slug.length);
        String slugType = slug.substring(1, lastIndex);

        switch(slugType) {

          case CATEGORY:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Products(category: Category(name: title, slug: slugName))));
            break;

          case SUB_CATEGORY:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Products(subCategory: SubCategory(name: title, slug: slugName))));
            break;

          case SUB_SUB_CATEGORY:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Products(subSubCategory: SubSubCategory(name: title, slug: slugName))));
            break;

          case BRAND:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Products(brand: Brand(name: title, slug: slugName))));
            break;

          case SHOP:
            Navigator.push(context, MaterialPageRoute(builder: (context) => Products(shop: Shop(name: title, slug: slugName))));
            break;
        }
      }
    }
  }
}