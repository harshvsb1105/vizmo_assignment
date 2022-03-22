import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizmo_assignment/Controller/AllCheckinEmployeeidController.dart';
import 'package:vizmo_assignment/Controller/EmployeeListController.dart';
import 'package:vizmo_assignment/Model/ProfileModel.dart';
import 'package:http/http.dart' as http;
import 'package:vizmo_assignment/View/ProfileTabScreen.dart';
import 'Components/ListItem.dart';

class EmployeeList extends StatefulWidget {
  final String index;
  static String tag = '/EmployeeList';


  const EmployeeList({
    Key key,
    this.index,
  }) : super(key: key);

  @override
  _EmployeeListState createState() => _EmployeeListState();
}

class _EmployeeListState extends State<EmployeeList> {
  // EmployeeListController _controller = Get.put(EmployeeListController());
  AllCheckinEmployeeidController _checkinController =
  Get.put(AllCheckinEmployeeidController());
  TextEditingController _searchController = TextEditingController();
  List<ProfileModel> employeeList = [];
  // The controller for the ListView
  ScrollController _scrollController;

  // We will fetch data from this Rest api
  final _baseUrl = 'https://620dfdda20ac3a4eedcf5a52.mockapi.io/api/employee';

  int _page = 1;

  // There is next page or not
  bool _hasNextPage = true;

  // Used to display loading indicators when _firstLoad function is running
  bool _isFirstLoadRunning = false;

  // Used to display loading indicators when _loadMore function is running
  bool _isLoadMoreRunning = false;

  // This holds the posts fetched from the server
  List<ProfileModel> _posts = [];

  // This function will be called when the app launches (see the initState function)
  void _firstLoad(bool byCreatedAt, String search) async {
     var res;
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      if(byCreatedAt) {
        _posts.clear();
        res = await http.get(Uri.parse("$_baseUrl?sortBy=createdAt&order=desc&page=1&limit=10"));
      } else if (_searchController.text.isNotEmpty) {
        print("LLLLLLL");
        _posts.clear();
        res = await http.get(Uri.parse("$_baseUrl?search=${_searchController.text}"));
      } else {
        res = await http.get(Uri.parse("$_baseUrl?page=$_page&limit=10"));
      }
      setState(() {
        var parsedJson = json.decode(res.body);
        var parsedList = parsedJson as List;

        if (parsedList == null) {
          // do nothing

        } else {
          for (int i = 0; i < parsedList.length; i++) {
            _posts.add(new ProfileModel.fromJson(parsedList[i]));
          }
        }
      });
    } catch (err) {
      print('Something went wrong');
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // This function will be triggered whenver the user scroll
  // to near the bottom of the list view
  void _loadMore() async {
    var res;
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _scrollController.position.extentAfter < 100) {
      setState(() {
        _isLoadMoreRunning = true; // Display a progress indicator at the bottom
      });
      _page += 1; // Increase _page by 1
      try {
        print("PAGE ---$_page");
          res = await http.get(Uri.parse("$_baseUrl?page=$_page&limit=10"));


        var fetchedPosts = json.decode(res.body);
        var jsonList = fetchedPosts as List;

        if (jsonList == null) {
          // do nothing

        } else {
          for (int i = 0; i < jsonList.length; i++) {
            employeeList.add(new ProfileModel.fromJson(jsonList[i]));
            setState(() {
              _posts.addAll(employeeList);
            });
          }
        }
        if (fetchedPosts.length > 0) {
          setState(() {
            _posts.addAll(employeeList);
          });
        } else {
          // This means there is no more data
          // and therefore, we will not send another GET request
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Something went wrong!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  // fetchdata() async {
  //  await _controller.firstLoad();
  // }

  @override
  void initState() {
    super.initState();
    // fetchdata();
    // _controller.firstLoad(false, _searchController.text);
    _firstLoad(false, _searchController.text);
    _scrollController = ScrollController()..addListener(_loadMore);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("sssss - ${_controller.posts.obs.value}");

    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepOrangeAccent,
          title: Text('Employee List'),
          actions: [
            // IconButton(icon: Icon(Icons.sort_rounded), onPressed: () => _controller.firstLoad())

            IconButton(icon: Icon(Icons.sort_rounded), onPressed: () => _firstLoad(true, _searchController.text))
          ],
        ),
        body: _isFirstLoadRunning
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Column(
                children: [
                  Container(
                    width: double.infinity,
                    height: 40,
                    child: Center(
                      child: TextField(
                        controller: _searchController,
                        onSubmitted: (text)  {
                          print("This is searched text : $text");
                          print("This is searched text Controller : ${_searchController.text}");
                           _firstLoad(false, _searchController.text);
                          // _controller.firstLoad();
                        },
                        decoration: InputDecoration(
                            filled: true,
                            contentPadding: const EdgeInsets.only(top: 15),
                            hintText: 'Search',
                            hintStyle:
                            TextStyle(color: const  Color(0xff3C3C43), fontSize: 17),
                            prefixIcon: Icon(
                              Icons.search,
                              color: const Color(0xff3C3C43),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.all(const Radius.circular(10.0)),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            )),
                      ),
                    ),
                  ),
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            itemCount: _posts.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                child: ListItem(
                  title: _posts[index].name,
                  image: _posts[index].avatar,
                  subTitle: _posts[index].country,
                ),
                onTap: () async {
                  await _checkinController.fetchEmployeeCheckinDetails(_posts[index].id);
                  Navigator.pushNamed(context, ProfileTabScreen.tag, arguments: _posts[index]);
                  // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileTabScreen(profileModel: _posts[index],)));
                },
              );
            },
          ),
        ),
                  // Obx(
                  //    () {
                  //     return Expanded(
                  //       child: ListView.builder(
                  //         controller: _scrollController,
                  //         itemCount: _posts.length,
                  //         itemBuilder: (BuildContext context, int index) {
                  //           return GestureDetector(
                  //               child: ListItem(
                  //           title: _posts[index].name,
                  //           image: _posts[index].avatar,
                  //           subTitle: _posts[index].country,
                  //         ),
                  //               onTap: () async {
                  //                 await _checkinController.fetchEmployeeCheckinDetails(_posts[index].id);
                  //                 Navigator.pushNamed(context, ProfileTabScreen.tag, arguments: _posts[index]);
                  //                 // Navigator.push(context, MaterialPageRoute(builder: (context) => ProfileTabScreen(profileModel: _posts[index],)));
                  //               },
                  //             );
                  //         },
                  //       ),
                  //     );
                  //   }
                  // ),

                  // when the _loadMore function is running
                  if (_isLoadMoreRunning == true)
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 40),
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),

                  // When nothing else to load
                  if (_hasNextPage == false)
                    Container(
                      padding: const EdgeInsets.only(top: 30, bottom: 40),
                      color: Colors.amber,
                      child: Center(
                        child: Text('You have fetched all of the content'),
                      ),
                    ),
                ],
              ));
  }
}
