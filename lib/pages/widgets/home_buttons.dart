import 'package:flutter/material.dart';

class HomeButtons extends StatelessWidget {
  HomeButtons(this.title, this.icon, this.subtitle, {this.onBackPressed});
  final String title;
  final String subtitle;
  final Icon icon;
  final Function onBackPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [BoxShadow(blurRadius: 0.1, spreadRadius: 0.4)]),
      // height: 50,
      // width: 50,
      child: Center(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              icon,
              const SizedBox(
                width: 10,
              ),
              Text(title),
            ],
          ),
          const SizedBox(
            height: 30,
          ),
          Text(subtitle)
        ],
      )),
    );
  }
}
