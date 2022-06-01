import 'brand.dart';
import 'category.dart';
import 'product.dart';

import 'shop.dart';

class SearchData {

  Products products;
  Categories categories;
  Shops shops;
  Brands brands;

  SearchData({this.products, this.categories, this.shops, this.brands});

  SearchData.fromJson(Map<String, dynamic> json) {

    try {
      products = Products.fromJson(json['products']);
    }
    catch(error) {}

    try {
      categories = Categories.fromJson(json['category']);
    }
    catch(error) {}

    try {
      shops = Shops.fromJson(json['shop']);
    }
    catch(error) {}

    try {
      brands = Brands.fromJson(json['brand']);
    }
    catch(error) {}
  }
}