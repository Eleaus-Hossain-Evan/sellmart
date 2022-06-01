import '../utils/api_routes.dart';

import 'product.dart';

class Brand {

  String id;
  String name;
  String image;
  String imageLarge;
  String description;
  String slug;
  bool active;

  Brand({this.id, this.name, this.image, this.imageLarge, this.description,
    this.slug, this.active});

  Brand.fromJson(Map<String, dynamic> json) {

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
      imageLarge = APIRoute.BASE_URL + json['image_large'];
    }
    catch(error) {}

    try {
      description = json['description'];
    }
    catch(error) {}

    try {
      slug = json['slug'];
    }
    catch(error) {}

    try {
      active = json['active'];
    }
    catch(error) {

      try {
        active = (json['active'] == "1");
      }
      catch(error) {}
    }
  }


  toJson() {

    return {
      "_id" : id ?? "",
      "name" : name ?? "",
      "image" : image == null ? "" : image.split(APIRoute.BASE_URL)[1],
      "image_large" : imageLarge == null ? "" : imageLarge.split(APIRoute.BASE_URL)[1],
      "description" : description ?? "",
      "slug" : slug ?? "",
      "active" : active == null || active == false? "0" : "1",
    };
  }
}


class OurBrands {

  String title;
  List<Brand> brands;

  OurBrands({this.title, this.brands});

  OurBrands.fromJson(Map<String, dynamic> json) {

    try {
      title = json['title'];
    }
    catch(error) {}

    try {

      brands = List();

      json['items'].forEach((brand) {

        brands.add(Brand.fromJson(brand));
      });
    }
    catch(error) {

      brands = List();
    }
  }
}


class Brands {

  List<Brand> list;

  Brands({this.list});

  Brands.fromJson(dynamic data) {

    list = List();

    if(data != null) {

      data.forEach((brand) {

        list.add(Brand.fromJson(brand));
      });
    }
  }
}


class BrandProducts {

  int totalProduct;
  int perPageProduct;
  List<Product> products;
  Brand brand;

  BrandProducts({this.totalProduct, this.perPageProduct, this.products, this.brand});

  BrandProducts.fromJson(Map<String, dynamic> json) {

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
      brand = Brand.fromJson(json['brand']);
    }
    catch(error) {}
  }
}