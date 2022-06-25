// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import '../utils/api_routes.dart';
import 'product.dart';
import 'sub_category.dart';

class Category {
  String id;
  String name;
  String image;
  String imageLarge;
  String url;
  String slug;
  bool active;
  bool featured;
  bool status;
  List<SubCategory> subCategories;

  Category(
      {this.id,
      this.name,
      this.image,
      this.imageLarge,
      this.url,
      this.slug,
      this.active,
      this.featured,
      this.status,
      this.subCategories});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['_id'];

    try {
      name = json['name'] ?? json['categoryName'];
    } catch (error) {}

    try {
      image = APIRoute.BASE_URL + json['image'];
    } catch (error) {}

    try {
      imageLarge = APIRoute.BASE_URL + json['image_large'];
    } catch (error) {}

    try {
      url = json['url'];
    } catch (error) {}

    try {
      slug = json['slug'] ?? json['slugName'];
    } catch (error) {}

    try {
      active = json['active'];
    } catch (error) {
      try {
        active = (json['active'] == "1");
      } catch (error) {}
    }

    try {
      featured = json['featured'];
    } catch (error) {
      try {
        featured = (json['featured'] == "1");
      } catch (error) {}
    }

    try {
      status = json['status'];
    } catch (error) {
      try {
        status = (json['status'] == "1");
      } catch (error) {}
    }

    try {
      subCategories = List();

      json['subcategory'].forEach((subCategory) {
        subCategories.add(SubCategory.fromJson(subCategory));
      });
    } catch (error) {
      subCategories = List();
    }
  }

  toJson() {
    return {
      "_id": id ?? "",
      "name": name ?? "",
      "image": image == null ? "" : image.split(APIRoute.BASE_URL)[1],
      "image_large":
          imageLarge == null ? "" : imageLarge.split(APIRoute.BASE_URL)[1],
      "url": url ?? "",
      "slug": slug ?? "",
      "active": active == null || active == false ? "0" : "1",
      "featured": featured == null || featured == false ? "0" : "1",
      "status": status == null || status == false ? "0" : "1",
      "subcategory": subCategories == null
          ? jsonEncode(List<SubCategory>()
                  .map((subCategory) => subCategory.toJson())
                  .toList())
              .toString()
          : jsonEncode(subCategories
                  .map((subCategory) => subCategory.toJson())
                  .toList())
              .toString(),
    };
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, image: $image, imageLarge: $imageLarge, url: $url, slug: $slug, active: $active, featured: $featured, status: $status, subCategories: $subCategories)';
  }
}

class Categories {
  List<Category> list;

  Categories({this.list});

  Categories.fromJson(dynamic data) {
    list = List();

    if (data != null) {
      data.forEach((category) {
        list.add(Category.fromJson(category));
      });
    }
  }

  @override
  String toString() => 'Categories(list: ${list.map((e) => e.toString())})';
}

class CategoryProducts {
  int totalProduct;
  int perPageProduct;
  List<Product> products;
  Category category;
  List<SubCategory> subCategories;

  CategoryProducts(
      {this.totalProduct,
      this.perPageProduct,
      this.products,
      this.category,
      this.subCategories});

  CategoryProducts.fromJson(Map<String, dynamic> json) {
    try {
      totalProduct = int.parse(json['productLength'].toString());
    } catch (error) {}

    try {
      perPageProduct = int.parse(json['perPageProduct'].toString());
    } catch (error) {}

    try {
      products = List();

      json['product'].forEach((product) {
        products.add(Product.fromJson(product));
      });
    } catch (error) {
      products = List();
    }

    try {
      category = Category.fromJson(json['category']);
    } catch (error) {}

    try {
      subCategories = List();

      json['subcategory'].forEach((subCategory) {
        subCategories.add(SubCategory.fromJson(subCategory));
      });
    } catch (error) {
      subCategories = List();
    }
  }
}
