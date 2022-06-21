class Order {
  String? message;
  bool? status;
  Data? data;

  Order({this.message, this.status, this.data});

  Order.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    status = json['status'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    data['status'] = this.status;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  String? carNum;
  String? gasType;
  String? latituide;
  String? longtuide;
  String? litres;
  String? price;
  String? details;
  User? user;
  String? userId;
  User? driver;
  String? driverId;
  String? status;

  Data(
      {this.id,
      this.carNum,
      this.gasType,
      this.latituide,
      this.longtuide,
      this.litres,
      this.price,
      this.details,
      this.user,
      this.userId,
      this.driver,
      this.driverId,
      this.status});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    carNum = json['car_num'];
    gasType = json['gas_type'];
    latituide = json['latituide'];
    longtuide = json['longtuide'];
    litres = json['litres'];
    price = json['price'];
    details = json['details'];
    user = json['user'] != '' ? new User.fromJson(json['user']) : null;
    userId = json['user_id'];
    driver = json['driver'] != '' ? new User.fromJson(json['driver']) : null;
    driverId = json['driver_id'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['car_num'] = this.carNum;
    data['gas_type'] = this.gasType;
    data['latituide'] = this.latituide;
    data['longtuide'] = this.longtuide;
    data['litres'] = this.litres;
    data['price'] = this.price;
    data['details'] = this.details;
    if (this.user != '') {
      data['user'] = this.user!.toJson();
    }
    data['user_id'] = this.userId;
    if (this.driver != '') {
      data['driver'] = this.driver!.toJson();
    }
    data['driver_id'] = this.driverId;
    data['status'] = this.status;
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? email;
  String? phone;
  String? image;
  String? login;
  String? type;
  String? ssn;

  User(
      {this.id,
      this.name,
      this.email,
      this.phone,
      this.image,
      this.login,
      this.type,
      this.ssn});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    login = json['login'];
    type = json['type'];
    ssn = json['ssn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['image'] = this.image;
    data['login'] = this.login;
    data['type'] = this.type;
    data['ssn'] = this.ssn;
    return data;
  }
}
