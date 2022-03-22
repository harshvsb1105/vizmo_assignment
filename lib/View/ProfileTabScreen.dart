import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vizmo_assignment/Controller/AllCheckinEmployeeidController.dart';
import 'package:vizmo_assignment/Model/ProfileModel.dart';


class ProfileTabScreen extends StatefulWidget {
  static String tag = '/ProfileTabScreen';
  final  profileModel;

  const ProfileTabScreen({this.profileModel});

  @override
  _ProfileTabScreenState createState() => _ProfileTabScreenState();
}

class _ProfileTabScreenState extends State<ProfileTabScreen> {
  AllCheckinEmployeeidController _checkinController =
      Get.find();

  // fetchDetails() async {
  //   await _checkinController.fetchEmployeeCheckinDetails(widget.profileModel.id);
  // }

  mockMethod() {}

  @override
  void initState() {
     // fetchDetails();
    super.initState();
  }

  @override
  void dispose() {
    _checkinController.employeeCheckinList.clear();
    // _checkinController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context).settings.arguments as Map;
    var displayHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: Text('Profile'),
        automaticallyImplyLeading: false,
      ),
      body: widget.profileModel == null
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
            child: Column(
                children: [
                  Image.network(widget.profileModel.avatar),
                  SizedBox(
                    height: displayHeight * 0.03,
                  ),
                  Text(
                    "Profile Details",
                    style:
                        TextStyle(color: Colors.deepOrangeAccent, fontSize: 15),
                  ),
                  ListTile(
                    title: Text(
                      "Name",
                      style: TextStyle(color: Colors.black),
                    ),
                    subtitle: Text(widget.profileModel.name),
                  ),
                  ListTile(
                      title: Text(
                        "Contact",
                        style: TextStyle(color: Colors.black),
                      ),
                      subtitle: Text(
                          "Email: ${widget.profileModel.email}\nPhone: ${widget.profileModel.phone}")),
                  SizedBox(
                    height: displayHeight * 0.03,
                  ),
                  Text(
                    "Checkin Details",
                    style:
                        TextStyle(color: Colors.deepOrangeAccent, fontSize: 15),
                  ),
        ListView.builder(
          shrinkWrap: true,
          itemCount: _checkinController.employeeCheckinList.length,
          itemBuilder: (context, index) => ListTile(
              title: Text(
                _checkinController.employeeCheckinList[index].id,
                style: TextStyle(color: Colors.black),
              ),
              subtitle: Text(
                  "Date: ${_checkinController.employeeCheckinList[index].checkin}\nLocation: ${_checkinController.employeeCheckinList[index].location} ")),
        ),
                  // GetBuilder<AllCheckinEmployeeidController>(
                  //   builder: (_checkinController) {
                  //     return ListView.builder(
                  //       shrinkWrap: true,
                  //       itemCount: _checkinController.employeeCheckinList.length,
                  //       itemBuilder: (context, index) => ListTile(
                  //           title: Text(
                  //             _checkinController.employeeCheckinList[index].id,
                  //             style: TextStyle(color: Colors.black),
                  //           ),
                  //           subtitle: Text(
                  //               "Date: ${_checkinController.employeeCheckinList[index].checkin}\nLocation: ${_checkinController.employeeCheckinList[index].location} ")),
                  //     );
                  //   }
                  // )
                  // Center(
                  //   child: Container(
                  //     child: profileModel == null ? Text("No Profile selected") : Text(profileModel.name ),
                  //   ),
                  // ),
                ],
              ),
          ),
    );
  }
}
