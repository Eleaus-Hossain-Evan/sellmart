class Size {

  String id;
  int stock;
  String name;

  Size({this.id, this.stock, this.name});

  Size.fromJson(Map<String, dynamic> json) {

    id = json['_id'];

    try {
      stock = json['stock'];
    }
    catch(error) {

      try {
        stock = int.parse(json['stock']);
      }
      catch(error) {}
    }

    try {
      name = json['size'];
    }
    catch(error) {}
  }

  toJson() {

    return {
      "_id" : id ?? "",
      "stock" : stock == null ? "" : stock.toString(),
      "size" : name ?? "",
    };
  }
}