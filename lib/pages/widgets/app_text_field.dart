import 'package:face_net_authentication/util/colors.dart';
import 'package:flutter/material.dart';

class AppTextField extends StatelessWidget {
  AppTextField(
      {Key key,
      @required this.labelText,
      @required this.controller,
      this.keyboardType = TextInputType.text,
      this.autofocus = false,
      this.isPassword = false,
      this.icon})
      : super(key: key);

  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final bool autofocus;
  final bool isPassword;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: this.controller,
      autofocus: this.autofocus,
      cursorColor: primaryColor,
      decoration: InputDecoration(
          // floatingLabelBehavior: FloatingLabelBehavior.never,
          labelText: labelText,
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey[200],
          // enabledBorder: new OutlineInputBorder(
          //   borderSide: BorderSide.none,
          //   borderRadius: const BorderRadius.all(
          //     const Radius.circular(10.0),
          //   ),
          // ),
          // focusedBorder: new OutlineInputBorder(
          //   borderSide: BorderSide.none,
          //   borderRadius: const BorderRadius.all(
          //     const Radius.circular(10.0),
          //   ),
          // ),
          prefixIcon: Container(
            width: 20,
            height: 20,
            margin: EdgeInsets.all(7),
            // padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: primaryColor, borderRadius: BorderRadius.circular(10)),
            child: Center(
              child: Icon(icon, size: 18, color: Colors.grey[200]),
            ),
          ),
          enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: primaryColor)),
          labelStyle: TextStyle(color: Colors.grey[800]),
          focusColor: Colors.grey[800]),
      obscureText: isPassword,
      keyboardType: keyboardType,
    );
  }
}
