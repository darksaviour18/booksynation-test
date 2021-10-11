import 'package:booksynation/page/onboarding.dart';
import 'package:booksynation/page/patient_info/widgets/patientData.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleButtonMobile extends StatefulWidget {
  @override
  _GoogleButtonMobileState createState() => _GoogleButtonMobileState();
}

class _GoogleButtonMobileState extends State<GoogleButtonMobile> {
  bool _isProcessing = false;
  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: [
    'email',
  ]);

  @override
  Widget build(BuildContext context) {
    GoogleSignInAccount? userGoogle = _googleSignIn.currentUser;

    return DecoratedBox(
      decoration: ShapeDecoration(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: BorderSide(color: Colors.blueGrey, width: 3),
        ),
        color: Colors.white,
      ),
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          primary: Colors.blueGrey.shade100,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.blueGrey, width: 3),
          ),
          elevation: 0,
        ),
        onPressed: () async {
          setState(() {
            _isProcessing = true;
          });
          await _googleSignIn.signIn().then((result) {
            if (result != null) {
              print('Google UID: ' + result.id);
              isGoogleUser = true;

              patient.uniqueId = result.id;
              // getPatientDataGoogle(userGoogle);
              // createPatientData();
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (context) => OnBoard(),
                ),
              );
            }
          }).catchError((error) {
            print('Registration Error: $error');
          });
          // try {
          //   await _googleSignIn.signIn();
          //   setState(() {});
          //   print('User: $user');
          // } catch (error) {
          //   print(error);
          // }

          // if (user != null) {
          //   Navigator.of(context).pop();
          //   Navigator.of(context).pushReplacement(
          //     MaterialPageRoute(
          //       fullscreenDialog: true,
          //       builder: (context) => OnBoard(),
          //     ),
          //   );
          // } else {
          //   ScaffoldMessenger.of(context).showSnackBar(
          //     const SnackBar(
          //       content: Text(
          //         'Login unsuccessful.',
          //       ),
          //     ),
          //   );
          // }

          setState(() {
            _isProcessing = false;
          });
        },
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
          child: _isProcessing
              ? CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(
                    Colors.blueGrey,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Image(
                      image: AssetImage("images/google_logo.png"),
                      height: 30.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text(
                        'Google',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.blueGrey,
                        ),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }
}
