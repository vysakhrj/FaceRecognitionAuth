import 'dart:io';

import 'package:face_net_authentication/pages/home.dart';
import 'package:face_net_authentication/pages/models/homebutton_model.dart';
import 'package:face_net_authentication/pages/models/user.model.dart';
import 'package:face_net_authentication/pages/widgets/app_button.dart';
import 'package:face_net_authentication/pages/widgets/header.dart';
import 'package:face_net_authentication/pages/widgets/home_buttons.dart';
import 'package:face_net_authentication/util/colors.dart';
import 'package:flutter/material.dart';

class UserDetails extends StatefulWidget {
  const UserDetails({Key key, this.path, this.user}) : super(key: key);

  final String path;
  final User user;

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  List<HomeButtonModel> buttons = [];
  _onBackPressed() {
    Navigator.of(context).pop();
  }

  @override
  initState() {
    super.initState();

    buttons = [
      HomeButtonModel("Neo ID", "${widget.user.id}", Icon(Icons.credit_card)),
      HomeButtonModel(
          "Mobile", "${widget.user.mobile}", Icon(Icons.phone_android_rounded)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Header(
            "Profile",
            onBackPressed: _onBackPressed,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.black,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: FileImage(File(widget.path)),
              ),
            ),
            // margin: EdgeInsets.all(20),
            width: 70,
            height: 70,
          ),
          const SizedBox(
            height: 40,
          ),
          Text(widget.user.user,
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 7,
          ),
          Text(widget.user.role),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 170,
                    childAspectRatio: 3 / 2,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                primary: true,
                padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
                scrollDirection: Axis.vertical,
                // crossAxisSpacing: 5,
                // mainAxisSpacing: 5,
                // crossAxisCount: 2,
                itemCount: buttons.length,
                itemBuilder: (BuildContext ctx, index) {
                  return HomeButtons(buttons[index].title, buttons[index].icon,
                      buttons[index].subtitle);
                }),
          ),
          // const Spacer(),
          AppButton(
              text: "LOG OUT",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              },
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              color: primaryColor),
          SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
