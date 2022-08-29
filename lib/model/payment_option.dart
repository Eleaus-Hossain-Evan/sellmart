import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class PaymentOption extends Equatable {
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

  @override
  List<Object> get props => [id, name, icon];
}
