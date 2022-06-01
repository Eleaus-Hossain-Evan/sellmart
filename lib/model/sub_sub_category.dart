import '../utils/api_routes.dart';
import 'sub_category.dart';
import 'product.dart';

class SubSubCategory {

  String id;
  String name;
  String image;
  String imageLarge;
  String slug;
  bool active;
  SubCategory subCategory;

  SubSubCategory({this.id, this.name, this.image, this.imageLarge, this.slug,
    this.active, this.subCategory});

  SubSubCategory.fromJson(Map<String, dynamic> json) {

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
      slug = json['slug'];
    }
    catch(error) {}

    try {
      active = json['active'];
    }
    catch(error) {}

    try {
      subCategory = SubCategory.fromJson(json['subcategory']);
    }
    catch(error) {}
  }
}


class SubSubCategoryProducts {

  int totalProduct;
  int perPageProduct;
  List<Product> products;

  SubSubCategoryProducts({this.totalProduct, this.perPageProduct, this.products});

  SubSubCategoryProducts.fromJson(Map<String, dynamic> json) {

    try {
      totalProduct = int.parse(json['productLength'].toString());
    }
    catch (error) {}

    try {
      perPageProduct = int.parse(json['perPageProduct'].toString());
    }
    catch (error) {}

    try {

      products = List();

      json['product'].forEach((product) {
        products.add(Product.fromJson(product));
      });
    }
    catch (error) {

      products = List();
    }
  }
}