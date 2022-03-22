import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:vizmo_assignment/Model/ProfileModel.dart';

class EmployeeListController extends GetxController {
  List<ProfileModel> employeeList = <ProfileModel>[].obs;
  final _baseUrl = 'https://620dfdda20ac3a4eedcf5a52.mockapi.io/api/employee';

  int page = 1;

  // There is next page or not
  var hasNextPage = true.obs;

  // Used to display loading indicators when firstLoad function is running
  var isFirstLoadRunning = false.obs;

  // Used to display loading indicators when loadMore function is running
  var isLoadMoreRunning = false.obs;

  // This holds the posts fetched from the server
  // var posts = <ProfileModel>[].obs;

  var posts = List<ProfileModel>().obs;


  ScrollController scrollController;

  getData() async {
    await firstLoad();
    update();
  }


  @override
  void onInit() {
    super.onInit();
   getData();
    scrollController = ScrollController()..addListener(loadMore);
    // fetchEmployeeList();
  }

  @override
  void dispose(){
  scrollController.removeListener(loadMore);
    // TODO: implement dispose
    super.dispose();
  }

  // This function will be called when the app launches (see the initState function)
  Future<void> firstLoad() async {
      isFirstLoadRunning.value = true;
    try {
      final res = await http.get(Uri.parse("$_baseUrl?page=$page&limit=10"));
        var parsedJson = json.decode(res.body);
        var parsedList = parsedJson as List;

        if (parsedList == null) {
          // do nothing

        } else {
          for (int i = 0; i < parsedList.length; i++) {
            posts.add(new ProfileModel.fromJson(parsedList[i]));
          }
        }
    } catch (err) {
      print('Something went wrong');
    }

      isFirstLoadRunning.value = false;
      print("WQWQWQ ${posts.length}");

      update();
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void loadMore() async {
    if (hasNextPage.value == true &&
        isFirstLoadRunning.value == false &&
        isLoadMoreRunning.value == false &&
        scrollController.position.extentAfter < 100) {
        isLoadMoreRunning.value = true; // Display a progress indicator at the bottom
      page += 1; // Increase page by 1
      try {
        print("PAGE ---$page");
        final res = await http.get(Uri.parse("$_baseUrl?page=$page&limit=10"));

        var fetchedPosts = json.decode(res.body);
        var jsonList = fetchedPosts as List;

        if (jsonList == null) {
          // do nothing

        } else {
          for (int i = 0; i < jsonList.length; i++) {
            employeeList.add(new ProfileModel.fromJson(jsonList[i]));
              posts.addAll(employeeList);
          }
        }
        if (fetchedPosts.length > 0) {
            posts.addAll(employeeList);
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
            hasNextPage.value = false;
        }
      } catch (err) {
        print('Something went wrong!');
      }

        isLoadMoreRunning.value = false;
    }
    update();
  }

  // Future<List<ProfileModel>> fetchEmployeeList(int page) async {
  //   final apiUrl = "https://620dfdda20ac3a4eedcf5a52.mockapi.io/api/employee?page=$page&format=json";
  //   print(apiUrl);
  //   var response = await http
  //       .get(Uri.parse(apiUrl), headers: {"Accept": "application/json"});
  //   var parsedJson = jsonDecode(response.body);
  //
  //   var categoryJson = parsedJson as List;
  //
  //   if (categoryJson == null) {
  //     // do nothing
  //
  //   } else {
  //     for (int i = 0; i < categoryJson.length; i++) {
  //       employeeList.add(new ProfileModel.fromJson(categoryJson[i]));
  //     }
  //   }
  //   return employeeList;
  // }
}
