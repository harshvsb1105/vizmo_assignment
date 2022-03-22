class ProfileModel {
  String createdAt;
  String name;
  String avatar;
  String email;
  String phone;
  List<String> department;
  String birthday;
  String country;
  String id;

  ProfileModel(
      {this.createdAt,
      this.name,
      this.avatar,
      this.email,
      this.phone,
      this.department,
      this.birthday,
      this.country,
      this.id});

  ProfileModel.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    name = json['name'];
    avatar = json['avatar'];
    email = json['email'];
    phone = json['phone'];
    department = json['department'].cast<String>();
    birthday = json['birthday'];
    country = json['country'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['createdAt'] = this.createdAt;
    data['name'] = this.name;
    data['avatar'] = this.avatar;
    data['email'] = this.email;
    data['phone'] = this.phone;
    data['department'] = this.department;
    data['birthday'] = this.birthday;
    data['country'] = this.country;
    data['id'] = this.id;
    return data;
  }
}
