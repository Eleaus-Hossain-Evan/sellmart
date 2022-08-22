class Discount {
  double amount;
  int type;

  Discount({this.amount, this.type});

  Discount.fromJson(Map<String, dynamic> json) {
    try {
      if (json['amount'] != null) {
        amount = double.parse(json['amount'].toString());
      }
    } catch (error) {}

    try {
      type = json['type'];
    } catch (error) {
      try {
        type = int.parse(json['type']);
      } catch (error) {}
    }
  }

  toJson() {
    return {
      "amount": amount == null ? "" : amount.toString(),
      "type": type == null ? "" : type.toString(),
    };
  }
}
