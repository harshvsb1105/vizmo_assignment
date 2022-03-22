class CheckinModel {
  String checkin;
  String location;
  String purpose;
  String id;
  String employeeId;

  CheckinModel(
      {this.checkin, this.location, this.purpose, this.id, this.employeeId});

  CheckinModel.fromJson(Map<String, dynamic> json) {
    checkin = json['checkin'];
    location = json['location'];
    purpose = json['purpose'];
    id = json['id'];
    employeeId = json['employeeId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['checkin'] = this.checkin;
    data['location'] = this.location;
    data['purpose'] = this.purpose;
    data['id'] = this.id;
    data['employeeId'] = this.employeeId;
    return data;
  }
}
