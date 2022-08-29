import '../utils/api_routes.dart';

class SizeInfo {
  String id;
  int stock;
  int discountType;
  double discountAmount;
  double regularPrice;
  double discountPrice;
  List<String> images;
  List<List<String>> infos;

  SizeInfo(
      {this.id,
      this.stock,
      this.discountType,
      this.discountAmount,
      this.regularPrice,
      this.discountPrice,
      this.images,
      this.infos});

  SizeInfo.fromJson(Map<String, dynamic> json) {
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

      json['gallery'].forEach((image) {
        images.add(APIRoute.BASE_URL + image.toString());
      });
    } catch (error) {
      images = List();
    }

    try {
      infos = List();

      json['info'].forEach((info) {
        List<String> items = [];

        info.forEach((item) {
          items.add(item);
        });

        infos.add(items);
      });
    } catch (error) {
      infos = List();
    }
  }

  @override
  String toString() {
    return 'SizeInfo(id: $id, stock: $stock, discountType: $discountType, discountAmount: $discountAmount, regularPrice: $regularPrice, discountPrice: $discountPrice, images: $images, infos: $infos)';
  }
}
