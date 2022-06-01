import 'category.dart';
import 'info.dart';
import 'product.dart';
import 'app_service.dart';

class HomeData {

  Info info;
  AppServices services;
  List<Category> categories;
  ProductItems hotSelling;
  ProductItems flashSale;
  List<ProductItems> sections;

  HomeData({this.info, this.categories, this.hotSelling, this.flashSale, this.sections, this.services});

  HomeData.fromJson(Map<String, dynamic> json) {

    try {
      info = Info.fromJson(json['info']);
    }
    catch(error) {}

    try {

      services = json['services'] == null ? AppServices(list: List()) : AppService.fromJson(json['services']);
    }
    catch(error) {}

    try {

      categories = List();

      json['category'].forEach((category) {

        categories.add(Category.fromJson(category));
      });
    }
    catch(error) {

      categories = List();
    }

    try {
      hotSelling = ProductItems.fromJson(json['topSelling']);
    }
    catch(error) {}

    try {
      flashSale = ProductItems.fromJson(json['discountProduct']);
    }
    catch(error) {}

    try {

      sections = List();

      json['productSection'].forEach((section) {

        sections.add(ProductItems.fromJson(section));
      });
    }
    catch(error) {

      sections = List();
    }
  }
}