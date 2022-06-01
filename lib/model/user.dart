import 'dart:convert';
import '../utils/fcm_setup.dart';
import 'address.dart';

class User {

  String id;
  String firstName;
  String lastName;
  String phone;
  String token;
  String otp;
  String password;
  String confirmPassword;
  String newPassword;
  bool isBlocked;
  String balance;
  String image;
  String email;
  String deliveryAddress;
  List<String> wishList;
  Addresses addresses = Addresses(list: List());
  String referralCode;

  User({this.id, this.firstName, this.lastName, this.phone, this.token, this.otp,
    this.password, this.confirmPassword, this.newPassword, this.isBlocked,
    this.balance, this.image, this.email, this.deliveryAddress,
    this.addresses, this.wishList, this.referralCode});

  User.fromJson(Map<String, dynamic> json) {

    id = json['_id'] == null ? "" : json['_id'].toString();
    firstName = json['firstName'] == null ? "" : json['firstName'].toString();
    lastName = json['lastName'] == null ? "" : json['lastName'].toString();
    phone = json['phone'] == null ? "" : json['phone'].toString();
    token = json['token'] == null ? "" : json['token'].toString();
    isBlocked = json['isBlocked'] == null ? false : json['isBlocked'];
    balance = json['balance'] == null ? "" : json['balance'].toString();
    image = json['image'] == null ? "" : json['image'];
    email = json['email'] == null ? "" : json['email'];
    deliveryAddress = json['deliveryAddress'] == null ? "" : json['deliveryAddress'];
    addresses = json['address'] == null ? Addresses(list: List()) : Addresses.fromJson(json['address']);

    try {

      wishList = [];

      json['wishList'].forEach((productID) {

        wishList.add(productID);
      });
    }
    catch(error) {

      wishList = [];
    }
  }

  toJson() {

    return {
      "_id" : id == null ? "" : id,
      "firstName" : firstName == null ? "" : firstName,
      "lastName" : lastName == null ? "" : lastName,
      "phone" : phone == null ? "" : phone,
      "token" : token == null ? "" : token,
      "balance" : balance == null ? "" : balance,
      "image" : image == null ? "" : image,
      "email" : email == null ? "" : email,
      "deliveryAddress" : deliveryAddress == null ? "" : deliveryAddress,
      "address" : jsonEncode(addresses.list.map((address) => address.toJson()).toList()).toString(),
      "wishList" : wishList.toList(),
      "otp" : otp == null ? "" : otp,
      "password" : password == null ? "" : password,
      "confirmPassword" : confirmPassword == null ? "" : confirmPassword,
    };
  }

  toSignUpFirstStep() {

    return {
      "firstName" : firstName == null ? "" : firstName,
      "lastName" : lastName == null ? "" : lastName,
      "phone" : phone == null ? "" : phone,
    };
  }

  toSignUpSecondStep() {

    return {
      "phone" : phone == null ? "" : phone,
      "otp" : otp == null ? "" : otp,
      "password" : password == null ? "" : password,
      "confirmPassword" : confirmPassword == null ? "" : confirmPassword
    };
  }

  toLogin() {

    return {
      "phone" : phone == null ? "" : phone,
      "password" : password == null ? "" : password,
      "deviceToken" : deviceToken.value == null ? "" : deviceToken.value,
    };
  }


  changePassword() {

    return {
      "oldPassword" : password == null ? "" : password,
      "newPassword" : newPassword == null ? "" : newPassword,
      "newConfirmPassword" : confirmPassword == null ? "" : confirmPassword
    };
  }


  resetPassword() {

    return {
      "phone" : phone == null ? "" : phone,
      "password" : newPassword == null ? "" : newPassword,
      "password_confirmation" : confirmPassword == null ? "" : confirmPassword,
    };
  }
}