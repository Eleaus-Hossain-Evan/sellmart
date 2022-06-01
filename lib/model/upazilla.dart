class Upazila {

  String id;
  String districtID;
  String name;
  String bnName;

  Upazila({this.id, this.districtID, this.name, this.bnName});

  Upazila.fromJson(Map<String, dynamic> json) {

    id = json['id'];
    districtID = json['district_id'];
    name = json['name'];
    bnName = json['bn_name'];
  }
}


class Upazilas {

  List<Upazila> list;

  Upazilas({this.list});

  Upazilas.fromJson(dynamic json) {

    try {

      list = List();

      json.forEach((upazila) {

        list.add(Upazila.fromJson(upazila));
      });
    }
    catch(error) {

      list = List();
    }
  }
}