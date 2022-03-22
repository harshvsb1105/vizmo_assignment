import 'package:http/http.dart' as http;
import 'package:vizmo_assignment/Model/ProfileModel.dart';

class RemoteServices {
  static var client = http.Client();

  static Future<List<ProfileModel>> fetchEmployeeList(int page) async {
    final _baseUrl = 'https://620dfdda20ac3a4eedcf5a52.mockapi.io/api/employee';

    var response = await client.get(Uri.parse("$_baseUrl?page=$page&limit=10"));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return profileModelFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}