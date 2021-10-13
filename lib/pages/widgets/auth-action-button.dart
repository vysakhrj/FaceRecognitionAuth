import 'package:face_net_authentication/pages/db/database.dart';
import 'package:face_net_authentication/pages/models/user.model.dart';
import 'package:face_net_authentication/pages/dashboard.dart';
import 'package:face_net_authentication/pages/widgets/app_button.dart';
import 'package:face_net_authentication/services/camera.service.dart';
import 'package:face_net_authentication/services/facenet.service.dart';
import 'package:face_net_authentication/util/colors.dart';
import 'package:flutter/material.dart';
import '../home.dart';
import 'app_text_field.dart';

class AuthActionButton extends StatefulWidget {
  AuthActionButton(this._initializeControllerFuture,
      {Key key, @required this.onPressed, @required this.isLogin, this.reload});
  final Future _initializeControllerFuture;
  final Function onPressed;
  final bool isLogin;
  final Function reload;
  @override
  _AuthActionButtonState createState() => _AuthActionButtonState();
}

class _AuthActionButtonState extends State<AuthActionButton> {
  /// service injection
  final FaceNetService _faceNetService = FaceNetService();
  final DataBaseService _dataBaseService = DataBaseService();
  final CameraService _cameraService = CameraService();

  final TextEditingController _userTextEditingController =
      TextEditingController(text: '');
  final TextEditingController _idTextEditingController =
      TextEditingController(text: '');
  final TextEditingController _roleTextEditingController =
      TextEditingController(text: '');
  final TextEditingController _mobileTextEditingController =
      TextEditingController(text: '');

  User predictedUser;

  Future _signUp(context) async {
    /// gets predicted data from facenet service (user face detected)
    List predictedData = _faceNetService.predictedData;
    print(predictedData);
    String user = _userTextEditingController.text;
    // String password = _passwordTextEditingController.text;
    String id = _idTextEditingController.text;
    String mobile = _mobileTextEditingController.text;
    String role = _roleTextEditingController.text;

    /// creates a new user in the 'database'
    await _dataBaseService.saveData(
      id,
      user,
      // password,

      mobile,
      role,
      predictedData,
    );

    /// resets the face stored in the face net sevice
    this._faceNetService.setPredictedData(null);
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext context) => MyHomePage()));
  }

  Future _signIn(context) async {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (BuildContext context) => Dashboard(
                  this.predictedUser,
                  imagePath: _cameraService.imagePath,
                )));
  }

  String _predictUser() {
    String userAndPass = _faceNetService.predict();
    return userAndPass ?? null;
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        try {
          // Ensure that the camera is initialized.
          await widget._initializeControllerFuture;
          // onShot event (takes the image and predict output)
          bool faceDetected = await widget.onPressed();

          if (faceDetected) {
            if (widget.isLogin) {
              var userAndPass = _predictUser();
              if (userAndPass != null) {
                this.predictedUser = await User.fromDB(userAndPass);
              }
            }
            PersistentBottomSheetController bottomSheetController =
                Scaffold.of(context)
                    .showBottomSheet((context) => signSheet(context));

            bottomSheetController.closed.whenComplete(() => widget.reload());
          }
        } catch (e) {
          // If an error occurs, log the error to the console.
          print(e);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: primaryColor,
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.blue.withOpacity(0.1),
              blurRadius: 1,
              offset: Offset(0, 2),
            ),
          ],
        ),
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 14, horizontal: 16),
        width: MediaQuery.of(context).size.width * 0.8,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CAPTURE',
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(
              width: 10,
            ),
            Icon(Icons.camera_alt, color: Colors.white)
          ],
        ),
      ),
    );
  }

  signSheet(context) {
    return Container(
      padding: EdgeInsets.all(20),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isLogin && predictedUser != null
              ? Container(
                  child: Text(
                    'Welcome back, ' + predictedUser.user + '.',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              : widget.isLogin
                  ? Container(
                      child: Text(
                      'User not found!',
                      style: TextStyle(fontSize: 20),
                    ))
                  : Container(
                      child: Text(
                      'Enter details',
                      style: TextStyle(fontSize: 20, color: primaryColor),
                    )),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Column(
              children: [
                !widget.isLogin
                    ? AppTextField(
                        controller: _userTextEditingController,
                        labelText: "Name",
                        icon: Icons.person,
                      )
                    : Container(),
                SizedBox(height: 10),
                !widget.isLogin && predictedUser == null
                    ? AppTextField(
                        controller: _idTextEditingController,
                        labelText: "NEO ID",
                        icon: Icons.credit_card,
                      )
                    : Container(),
                SizedBox(height: 10),
                !widget.isLogin && predictedUser == null
                    ? AppTextField(
                        controller: _roleTextEditingController,
                        labelText: "Role",
                        icon: Icons.person_pin,
                      )
                    : Container(),
                SizedBox(height: 10),
                !widget.isLogin && predictedUser == null
                    ? AppTextField(
                        controller: _mobileTextEditingController,
                        labelText: "Mobile",
                        icon: Icons.phone,
                        keyboardType: TextInputType.number,
                      )
                    : Container(),
                SizedBox(height: 10),
                // widget.isLogin && predictedUser == null
                //     ? Container()
                //     : AppTextField(
                //         controller: _passwordTextEditingController,
                //         labelText: "Password",
                //         isPassword: true,
                //       ),
                SizedBox(height: 10),
                Divider(),
                SizedBox(height: 10),
                widget.isLogin && predictedUser != null
                    ? AppButton(
                        color: primaryColor,
                        text: 'CONTINUE',
                        onPressed: () async {
                          _signIn(context);
                        },
                        icon: Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                        ),
                      )
                    : !widget.isLogin
                        ? AppButton(
                            color: primaryColor,
                            text: 'SIGN UP',
                            onPressed: () async {
                              await _signUp(context);
                            },
                            icon: Icon(
                              Icons.person_add,
                              color: Colors.white,
                            ),
                          )
                        : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
