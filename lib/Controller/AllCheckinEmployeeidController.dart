import 'dart:convert';

import 'package:get/get.dart';
import 'package:vizmo_assignment/Model/CheckinModel.dart';
import 'package:http/http.dart' as http;


class AllCheckinEmployeeidController extends GetxController{
  List<CheckinModel> employeeCheckinList = <CheckinModel>[].obs;


  Future<List<CheckinModel>> fetchEmployeeCheckinDetails(String id) async {
    final apiUrl = "https://620dfdda20ac3a4eedcf5a52.mockapi.io/api/employee/$id/checkin";
    print(apiUrl);
    var response = await http
        .get(Uri.parse(apiUrl), headers: {"Accept": "application/json"});
    var parsedJson = jsonDecode(response.body);

    var categoryJson = parsedJson as List;

    if (categoryJson == null) {
      // do nothing

    } else {
      for (int i = 0; i < categoryJson.length; i++) {
        employeeCheckinList.add(new CheckinModel.fromJson(categoryJson[i]));
      }
    }
    return employeeCheckinList;
  }
}