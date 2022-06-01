class OrderState {

  String id;
  int status;
  String time;
  String updateTime;
  String message;

  OrderState({this.id, this.status, this.time, this.message});

  OrderState.fromJson(Map<String, dynamic> json) {

    id = json['_id'];

    try {
      status = json['status'];
    }
    catch(error) {

      try {
        status = int.parse(json['status']);
      }
      catch(error) {}
    }

    try {
      time = json['time'];
    }
    catch(error) {}

    try {
      updateTime = json['updateTime'];
    }
    catch(error) {}

    try {
      message = json['message'];
    }
    catch(error) {}
  }
}