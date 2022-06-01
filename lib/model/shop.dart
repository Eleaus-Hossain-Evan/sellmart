import '../utils/api_routes.dart';
import 'address.dart';
import 'product.dart';

class Shop {

  String id;
  String name;
  String image;
  String vendorName;
  String thumbnail;
  String slug;
  Address address;

  Shop({this.id, this.name, this.image, this.vendorName, this.thumbnail,
    this.address, this.slug});

  Shop.fromJson(Map<String, dynamic> json) {

    id = json['_id'];

    try {
      name = json['name'];
    }
    catch(error) {}

    try {
      image = APIRoute.BASE_URL + json['image'];
    }
    catch(error) {}

    try {
      vendorName = json['vendorName'];
    }
    catch(error) {}

    try {
      slug = json['slug'];
    }
    catch(error) {}

    try {
      thumbnail = APIRoute.BASE_URL + json['thumbnail'];
    }
    catch(error) {}

    try {
      address = Address.fromJson(json['address']);
    }
    catch(error) {}
  }
}


class OurShops {

  String title;
  List<Shop> shops;

  OurShops({this.title, this.shops});

  OurShops.fromJson(Map<String, dynamic> json) {

    try {
      title = json['title'];
    }
    catch(error) {}

    try {

      shops = List();

      json['items'].forEach((shop) {

        shops.add(Shop.fromJson(shop));
      });
    }
    catch(error) {

      shops = List();
    }
  }
}


class Shops {

  List<Shop> list;

  Shops({this.list});

  Shops.fromJson(dynamic data) {

    list = List();

    if(data != null) {

      data.forEach((shop) {

        list.add(Shop.fromJson(shop));
      });
    }
  }
}


class ShopProducts {

  int totalProduct;
  int perPageProduct;
  List<Product> products;
  Shop shop;

  ShopProducts({this.totalProduct, this.perPageProduct, this.products, this.shop});

  ShopProducts.fromJson(Map<String, dynamic> json) {

    try {
      totalProduct = int.parse(json['productLength'].toString());
    }
    catch(error) {}

    try {
      perPageProduct = int.parse(json['perPageProduct'].toString());
    }
    catch(error) {}

    try {

      products = List();

      json['product'].forEach((product) {

        products.add(Product.fromJson(product));
      });
    }
    catch(error) {

      products = List();
    }

    try {
      shop = Shop.fromJson(json['shop']);
    }
    catch(error) {}
  }
}