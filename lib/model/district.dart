import 'upazilla.dart';

class District {

  String id;
  String divisionID;
  String name;
  String bnName;
  List<Upazila> upazilaList;

  District({this.id, this.divisionID, this.name, this.bnName, this.upazilaList});

  District.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    divisionID = json['division_id'];
    name = json['name'];
    bnName = json['bn_name'];
  }
}


class Districts {

  List<District> list;

  Districts({this.list});

  Districts.fromJson(dynamic json) {

    try {

      list = List();

      json.forEach((district) {

        list.add(District.fromJson(district));
      });
    }
    catch(error) {

      list = List();
    }
  }
}