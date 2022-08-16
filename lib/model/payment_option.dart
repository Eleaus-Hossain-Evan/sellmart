import 'package:flutter/material.dart';

class PaymentOption {
  int id;
  String name;
  Widget icon;

  PaymentOption({this.id, this.name, this.icon});

  factory PaymentOption.init() => PaymentOption(
        id: -1,
        icon: Container(),
        name: '',
      );

  @override
  String toString() => 'PaymentOption(id: $id, name: $name, icon: $icon)';
}
