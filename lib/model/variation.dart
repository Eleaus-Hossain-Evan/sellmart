// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../utils/api_routes.dart';

class Variation {
  String id;
  int stock;
  int discountType;
  double discountAmount;
  double regularPrice;
  double discountPrice;
  List<String> images;
  String value1;
  String value2;

  Variation(
      {this.id,
      this.stock,
      this.regularPrice,
      this.discountPrice,
      this.images,
      this.value1,
      this.value2,
      this.discountType,
      this.discountAmount});

  Variation.fromJson(Map<String, dynamic> json) {
    id = json['_id'];

    try {
      stock = json['stock'];
    } catch (error) {
      try {
        stock = int.parse(json['stock']);
      } catch (error) {}
    }

    try {
      discountType = int.parse(json['discountType'].toString());
    } catch (error) {}

    try {
      discountAmount = double.parse(json['discountAmount'].toString());
    } catch (error) {}

    try {
      regularPrice = double.parse(json['regularPrice'].toString());
    } catch (error) {}

    try {
      discountPrice = double.parse(json['buyingPrice'].toString());
    } catch (error) {}

    try {
      images = List();

      json['image'].forEach((image) {
        images.add(APIRoute.BASE_URL + image.toString());
      });
    } catch (error) {
      images = List();
    }

    try {
      value1 = json['value1'];
    } catch (error) {}

    try {
      value2 = json['value2'];
    } catch (error) {}
  }

  toJson() {
    return {
      "_id": id ?? "",
      "stock": stock == null ? "0" : stock.toString(),
      "regularPrice": regularPrice == null ? "0" : regularPrice.toString(),
      "buyingPrice": discountPrice == null ? "0" : discountPrice.toString(),
      "value1": value1 == null ? "" : value1,
      "value2": value2 == null ? "" : value2
    };
  }

  @override
  String toString() {
    return 'Variation(id: $id, stock: $stock, discountType: $discountType, discountAmount: $discountAmount, regularPrice: $regularPrice, discountPrice: $discountPrice, images: $images, value1: $value1, value2: $value2)';
  }
}

class Variations {
  List<Variation> list;

  Variations({this.list});

  Variations.fromJson(dynamic data) {
    list = List();

    if (data != null) {
      data.forEach((variation) {
        list.add(Variation.fromJson(variation));
      });
    }
  }
}
