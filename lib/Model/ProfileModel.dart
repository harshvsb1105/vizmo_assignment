// class ProfileModel {
//   String createdAt;
//   String name;
//   String avatar;
//   String email;
//   String phone;
//   List<String> department;
//   String birthday;
//   String country;
//   String id;
//
//   ProfileModel(
//       {this.createdAt,
//       this.name,
//       this.avatar,
//       this.email,
//       this.phone,
//       this.department,
//       this.birthday,
//       this.country,
//       this.id});
//
//   ProfileModel.fromJson(Map<String, dynamic> json) {
//     createdAt = json['createdAt'];
//     name = json['name'];
//     avatar = json['avatar'];
//     email = json['email'];
//     phone = json['phone'];
//     department = json['department'].cast<String>();
//     birthday = json['birthday'];
//     country = json['country'];
//     id = json['id'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['createdAt'] = this.createdAt;
//     data['name'] = this.name;
//     data['avatar'] = this.avatar;
//     data['email'] = this.email;
//     data['phone'] = this.phone;
//     data['department'] = this.department;
//     data['birthday'] = this.birthday;
//     data['country'] = this.country;
//     data['id'] = this.id;
//     return data;
//   }
// }


// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

List<ProfileModel> profileModelFromJson(String str) => List<ProfileModel>.from(json.decode(str).map((x) => ProfileModel.fromJson(x)));

String profileModelToJson(List<ProfileModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileModel {
  ProfileModel({
    this.createdAt,
    this.name,
    this.avatar,
    this.email,
    this.phone,
    this.department,
    this.birthday,
    this.country,
    this.id,
  });

  DateTime createdAt;
  String name;
  String avatar;
  String email;
  String phone;
  List<Department> department;
  DateTime birthday;
  String country;
  String id;

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    createdAt: DateTime.parse(json["createdAt"]),
    name: json["name"],
    avatar: json["avatar"],
    email: json["email"],
    phone: json["phone"],
    department: List<Department>.from(json["department"].map((x) => departmentValues.map[x])),
    birthday: DateTime.parse(json["birthday"]),
    country: json["country"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "createdAt": createdAt.toIso8601String(),
    "name": name,
    "avatar": avatar,
    "email": email,
    "phone": phone,
    "department": List<dynamic>.from(department.map((x) => departmentValues.reverse[x])),
    "birthday": birthday.toIso8601String(),
    "country": country,
    "id": id,
  };
}

enum Department { A, B, C }

final departmentValues = EnumValues({
  "a": Department.A,
  "b": Department.B,
  "c": Department.C
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
