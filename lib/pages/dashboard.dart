import 'dart:io';

import 'package:face_net_authentication/pages/models/homebutton_model.dart';
import 'package:face_net_authentication/pages/models/user.model.dart';
import 'package:face_net_authentication/pages/user_details.dart';
import 'package:face_net_authentication/pages/widgets/app_button.dart';
import 'package:face_net_authentication/pages/widgets/home_buttons.dart';
import 'package:face_net_authentication/util/colors.dart';
import 'package:flutter/material.dart';

class Dashboard extends StatelessWidget {
  Dashboard(this.user, {Key key, this.imagePath}) : super(key: key);
  // final String username;
  final String imagePath;
  final User user;

  List<HomeButtonModel> buttons = [
    HomeButtonModel("Calender", "Tap to view calender",
        Icon(Icons.calendar_today_outlined)),
    HomeButtonModel(
        "Expenses", "Tap to view expenses", Icon(Icons.money_outlined)),
    HomeButtonModel(
        "Leaves", "Tap to view calender", Icon(Icons.beach_access_rounded)),
    HomeButtonModel("To-Do", "Tap to add", Icon(Icons.notes))
  ];

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        backgroundColor: greyShade,
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.only(left: 15, right: 15, top: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hi ' + user.user + '!',
                            style: TextStyle(
                                fontSize: 22, fontWeight: FontWeight.w600),
                          ),
                          Text(
                            '${user.role}',
                            style: TextStyle(
                                color: primaryColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        ],
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    UserDetails(path: imagePath, user: user)));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.black,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(imagePath)),
                          ),
                        ),
                        // margin: EdgeInsets.all(20),
                        width: 50,
                        height: 50,
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Expanded(
                  child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 180,
                          childAspectRatio: 2 / 2,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20),
                      primary: true,
                      padding:
                          const EdgeInsets.only(top: 20, left: 15, right: 15),
                      scrollDirection: Axis.vertical,
                      // crossAxisSpacing: 5,
                      // mainAxisSpacing: 5,
                      // crossAxisCount: 2,
                      itemCount: buttons.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return HomeButtons(buttons[index].title,
                            buttons[index].icon, buttons[index].subtitle);
                      }),
                ),
                // Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
