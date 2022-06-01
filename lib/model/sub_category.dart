import '../utils/api_routes.dart';
import 'category.dart';
import 'product.dart';
import 'sub_sub_category.dart';

class SubCategory {

  String id;
  String name;
  String image;
  String imageLarge;
  String slug;
  bool active;
  Category category;
  List<SubSubCategory> subSubCategories;

  SubCategory({this.id, this.name, this.image, this.imageLarge, this.slug,
    this.active, this.category, this.subSubCategories});

  SubCategory.fromJson(Map<String, dynamic> json) {

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
    catch(error) {

      try {
        active = (json['active'] == "1");
      }
      catch(error) {}
    }

    try {
      category = Category.fromJson(json['category']);
    }
    catch(error) {}

    try {

      subSubCategories = List();

      json['subsubcategory'].forEach((subSubCategory) {

        subSubCategories.add(SubSubCategory.fromJson(subSubCategory));
      });
    }
    catch(error) {

      subSubCategories = List();
    }
  }


  toJson() {

    return {
      "_id" : id ?? "",
      "name" : name ?? "",
      "image" : image == null ? "" : image.split(APIRoute.BASE_URL)[1],
      "image_large" : imageLarge == null ? "" : imageLarge.split(APIRoute.BASE_URL)[1],
      "slug" : slug ?? "",
      "active" : active == null || active == false ?  "0" : "1",
      "category" : category == null ? Category(subCategories: List()).toJson() : category.toJson(),
    };
  }
}


class SubCategoryProducts {

  int totalProduct;
  int perPageProduct;
  List<Product> products;
  SubCategory subCategory;
  List<SubSubCategory> subSubCategories;

  SubCategoryProducts({this.totalProduct, this.perPageProduct, this.products, this.subCategory, this.subSubCategories});

  SubCategoryProducts.fromJson(Map<String, dynamic> json) {

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
      subCategory = SubCategory.fromJson(json['subcategory']);
    }
    catch(error) {}

    try {

      subSubCategories = List();

      json['subSubCategory'].forEach((subSubCategory) {

        subSubCategories.add(SubSubCategory.fromJson(subSubCategory));
      });
    }
    catch(error) {

      subSubCategories = List();
    }
  }
}