import 'package:booksynation/google_button_web.dart';
import 'package:booksynation/strings.dart';
import 'package:booksynation/userData.dart';
import 'package:booksynation/web_pages/web_data/adminData.dart';
import 'package:booksynation/web_pages/weblogin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WebRegister extends StatefulWidget {
  const WebRegister({
    Key? key,
    required this.auth,
    @required this.currentUser,
  }) : super(key: key);
  final FirebaseAuth auth;
  final currentUser;

  @override
  _WebRegisterState createState() =>
      _WebRegisterState(auth: auth, currentUser: currentUser);
}

class _WebRegisterState extends State<WebRegister> {
  _WebRegisterState({
    required this.auth,
    @required this.currentUser,
  });
  final FirebaseAuth auth;
  final currentUser;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final cpasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        body: Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            color: Color(0xFF3DDD6A).withOpacity(0.10),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: height * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'images/Logo_BSN.svg',
                      height: height * 0.1,
                      width: width * 0.1,
                    ),
                  ],
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Form(
                  key: _formKey,
                  child: Container(
                    height: height * 0.69,
                    width: width * 0.85,
                    alignment: Alignment.center,
                    child: AspectRatio(
                      aspectRatio: 2 / 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 25.0,
                          vertical: 25.0,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 5,
                              offset:
                                  Offset(3, 4), // changes position of shadow
                            ),
                            BoxShadow(
                              color: Colors.black.withOpacity(0.25),
                              blurRadius: 5,
                              offset:
                                  Offset(3, 4), // changes position of shadow
                            ),
                          ],
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      InkWell(
                                        onTap: () => Navigator.pop(context),
                                        child: Icon(
                                          Icons.arrow_back,
                                          key: Key("regBackButton"),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.025,
                                      ),
                                      Text(createAccText),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.010,
                                  ),
                                  TextFormField(
                                    key: Key("emailFormField"),
                                    controller: emailController,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                      labelText: 'Email Address',
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.010,
                                  ),
                                  TextFormField(
                                    key: Key("regFirstNameForm"),
                                    controller: firstNameController,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.person_outline_outlined,
                                        color: Colors.black,
                                      ),
                                      labelText: 'First Name',
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.010,
                                  ),
                                  TextFormField(
                                    key: Key("regLastNameForm"),
                                    controller: lastNameController,
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      labelText: 'Last Name',
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.010,
                                  ),
                                  TextFormField(
                                    key: Key("regPassField"),
                                    controller: passwordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Password',
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.010,
                                  ),
                                  TextFormField(
                                    key: Key("regConfirmPassField"),
                                    controller: cpasswordController,
                                    obscureText: true,
                                    decoration: InputDecoration(
                                      hintText: 'Confirm Password',
                                    ),
                                    validator: (value) {
                                      if (value != passwordController.text) {
                                        return 'Wrong password';
                                      } else {
                                        return null;
                                      }
                                    },
                                  ),
                                  SizedBox(
                                    height: height * 0.05,
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    key: Key("regButton"),
                                    onPressed: () async {
                                      final isValid =
                                          _formKey.currentState!.validate();
                                      if (isValid) {
                                        try {
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                            email: emailController.text,
                                            password: passwordController.text,
                                          )
                                              .then((result) {
                                            if (result != null) {
                                              if (result.additionalUserInfo!
                                                  .isNewUser) {
                                                admin.uniqueId =
                                                    result.user!.uid;
                                                admin.firstName =
                                                    firstNameController.text;
                                                admin.lastName =
                                                    lastNameController.text;
                                                createAdminUserData(
                                                  result.user!.uid,
                                                  emailController.text,
                                                  firstNameController.text,
                                                  lastNameController.text,
                                                  passwordController.text,
                                                );
                                                createAdminData();
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                  const SnackBar(
                                                    content: Text(
                                                      regSuccessSnackbar,
                                                      key: Key(
                                                          regSuccessSnackbar),
                                                    ),
                                                  ),
                                                );
                                              }
                                              Navigator.of(context).pop();
                                              Navigator.of(context).push(
                                                MaterialPageRoute(
                                                  fullscreenDialog: true,
                                                  builder: (context) =>
                                                      WebLogin(),
                                                ),
                                              );
                                            } else {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                const SnackBar(
                                                  content: Text(
                                                    regFailedSnackbar,
                                                    key: Key(
                                                        "regFailedSnackbar"),
                                                  ),
                                                ),
                                              );
                                            }
                                          });
                                        } on FirebaseAuthException catch (e) {
                                          print(e);
                                          print(e);
                                          if (e.code ==
                                              'email-already-in-use') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  emailInUseSnackbar,
                                                ),
                                              ),
                                            );
                                          } else if (e.code ==
                                              'invalid-email') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  invalidEmailSnackbar,
                                                ),
                                              ),
                                            );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                content: Text(
                                                  regErrorSnackbar,
                                                ),
                                              ),
                                            );
                                          }
                                        }
                                      }
                                    },
                                    style: ElevatedButton.styleFrom(
                                      primary: Color(0xFF26A98A),
                                      fixedSize: Size(
                                        width * 0.28,
                                        height * 0.045,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                    ),
                                    child: Text(
                                      btnTextRegister,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Mulish',
                                        fontWeight: FontWeight.w600,
                                        fontSize: height * 0.018,
                                        decoration: TextDecoration.none,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.030,
                                  ),
                                  GoogleButtonWeb(
                                      auth: auth, currentUser: currentUser),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
