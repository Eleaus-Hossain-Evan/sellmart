import 'dart:convert';

class Address {

  String id;
  String name;
  String phone;
  String details;
  String district;
  String division;
  String upazila;

  Address({this.id, this.name, this.phone, this.details, this.district, this.division, this.upazila});

  Address.fromJson(Map<String, dynamic> json) {

    try {
      id = json['_id'];
    }
    catch(error) {}

    try {
      name = json['name'];
    }
    catch(error) {}

    try {
      phone = json['phone'];
    }
    catch(error) {}

    try {
      details = json['details'];
    }
    catch(error) {}

    try {
      district = json['district'];
    }
    catch(error) {}

    try {
      division = json['division'];
    }
    catch(error) {}

    try {
      upazila = json['upazila'];
    }
    catch(error) {}
  }


  toJson() {

    return {
      "_id" : id == null ? "" : id,
      "name" : name == null ? "" : name,
      "phone" : phone == null ? "" : phone,
      "details" : details == null ? "" : details,
      "district" : district == null ? "" : district,
      "division" : division == null ? "" : division,
      "upazila" : upazila == null ? "" : upazila
    };
  }


  toAddUpdate() {

    return {
      "name" : name == null ? "" : name,
      "phone" : phone == null ? "" : phone,
      "details" : details == null ? "" : details,
      "district" : district == null ? "" : district,
      "division" : division == null ? "" : division,
      "upazila" : upazila == null ? "" : upazila
    };
  }
}


class Addresses {

  List<Address> list;

  Addresses({this.list});

  Addresses.fromJson(dynamic json) {

    try {

      list = List();

      if(json.toString().contains('"')) {

        json = jsonDecode(json);
      }

      json.forEach((address) {

        list.add(Address.fromJson(address));
      });
    }
    catch(error) {

      print(error);
      list = List();
    }
  }
}