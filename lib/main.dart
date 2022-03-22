import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizmo_assignment/View/ProfileTabScreen.dart';

import 'Controller/EmployeeListController.dart';
import 'Model/ProfileModel.dart';
import 'View/EmployeeList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyPage(),
      routes: {
        EmployeeList.tag: (context) => EmployeeList(),
        // ProfileTabScreen.tag: (context) => ProfileTabScreen(),
      },
    );
  }
}


class MyPage extends StatefulWidget {
  const MyPage({Key key}) : super(key: key);

  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  int selectedIndex = 0;
  List<Widget> widgets = [];

  void onTapHandler(int index) {
    print("INDEX: $index");
    if(index == 0) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MyPage()));
    }
    setState(() {
      selectedIndex = index;
    });
  }

  init() {
    widgets.add(EmployeeList());
    widgets.add(ProfileTabScreen());
    setState(() {});
  }
  
  @override
  void initState() {
    init();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Navigator(
        onGenerateRoute: (settings) {
        if (settings.name == ProfileTabScreen.tag) {
          final args = settings.arguments;
          setState(() {
            selectedIndex = 1;
          });
          return MaterialPageRoute(builder: (_) => ProfileTabScreen(profileModel: args,));
        } else if (settings.name == EmployeeList.tag) {
          setState(() {
            selectedIndex = 0;
          });
          return MaterialPageRoute(builder: (_) => widgets[0]);
        }
        return MaterialPageRoute(builder: (_) => widgets[selectedIndex]);
      },),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: this.selectedIndex,
        backgroundColor: Color(0xffF9F9F9),
        selectedItemColor: Colors.deepOrangeAccent,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.assignment_ind,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.assignment_ind,
              color: Colors.deepOrangeAccent,
            ),
            label: 'Employees',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle_outlined,
              color: Colors.grey,
            ),
            activeIcon: Icon(
              Icons.account_circle_outlined,
              color: Colors.deepOrangeAccent,
            ),
            label: 'Profile',
          ),
        ],
        onTap: (int index) {
          onTapHandler(index);
        },
      ),

    );
  }
}


