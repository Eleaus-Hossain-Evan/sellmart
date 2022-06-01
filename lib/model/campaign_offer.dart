class CampaignOffer {

  String id;
  String name;
  String slug;
  String startDate;
  String endDate;
  int type;
  double campaignDiscount;

  CampaignOffer({this.id, this.name, this.slug, this.startDate, this.endDate,
    this.type, this.campaignDiscount});

  CampaignOffer.fromJson(Map<String, dynamic> json) {

    id = json['id'];

    try {
      name = json['name'];
    }
    catch(error) {}

    try {
      slug = json['slug'];
    }
    catch(error) {}

    try {
      startDate = json['startDate'];
    }
    catch(error) {}

    try {
      endDate = json['endDate'];
    }
    catch(error) {}

    try {
      campaignDiscount = double.parse(json['amount'].toString());
    }
    catch(error) {}

    try {
      type = json['type'];
    }
    catch(error) {

      try {
        type = int.parse(json['type']);
      }
      catch(error) {}
    }
  }
}


class CampaignOffers {

  List<CampaignOffer> list;

  CampaignOffers({this.list});

  CampaignOffers.fromJson(dynamic data) {

    list = List();

    if(data != null) {

      data.forEach((campaignOffer) {

        list.add(CampaignOffer.fromJson(campaignOffer));
      });
    }
  }
}