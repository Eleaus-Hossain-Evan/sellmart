import 'district.dart';

class Division {

  String id;
  String name;
  String bnName;
  List<District> districtList;

  Division({this.id, this.name, this.bnName, this.districtList});

  Division.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    name = json['name'];
    bnName = json['bn_name'];
  }
}


class Divisions {

  List<Division> list;

  Divisions({this.list});

  Divisions.fromJson(dynamic json) {

    try {

      list = List();

      json.forEach((division) {

        list.add(Division.fromJson(division));
      });
    }
    catch(error) {

      list = List();
    }
  }
}