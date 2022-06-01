import '../utils/api_routes.dart';

import 'campaign_remaining_time.dart';
import 'product.dart';

class Campaign {

  String id;
  String name;
  String image;
  String slug;
  String startDate;
  String endDate;
  bool active;
  List<Product> products;
  CampaignRemainingTime remainingTime;

  Campaign({this.id, this.name, this.image, this.slug, this.startDate,
    this.endDate, this.active, this.products, this.remainingTime});

  Campaign.fromJson(Map<String, dynamic> json) {

    id = json['_id'];

    try {
      name = json['name'];
    }
    catch(error) {}

    try {
      slug = json['slug'];
    }
    catch(error) {}

    try {
      image = APIRoute.BASE_URL + json['image'];
    }
    catch(error) {

      try {
        image = APIRoute.BASE_URL + json['banner'];
      }
      catch(error) {}
    }

    try {
      startDate = json['startDate'];
    }
    catch(error) {}

    try {
      endDate = json['endDate'];
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

      products = List();

      json['newData'].forEach((product) {

        products.add(Product.fromJson(product));
      });
    }
    catch(error) {

      products = List();
    }
  }
}


class Campaigns {

  List<Campaign> list;

  Campaigns({this.list});

  Campaigns.fromJson(dynamic data) {

    list = List();

    if(data != null) {

      data.forEach((campaign) {

        list.add(Campaign.fromJson(campaign));
      });
    }
  }
}