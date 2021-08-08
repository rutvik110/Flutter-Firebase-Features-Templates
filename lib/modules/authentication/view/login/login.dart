import 'package:flutter/material.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/controllers/authcontroller.dart';
import 'package:flutter_firebase_feature_templates/routes/app_routes.dart';
import 'package:flutter_firebase_feature_templates/utilities/enums.dart';
import 'package:flutter_firebase_feature_templates/utilities/interfaces/AuthResult.dart';
import 'package:flutter_firebase_feature_templates/utilities/interfaces/authin.dart';
import 'package:flutter_firebase_feature_templates/utilities/regx.dart';

enum OTPSTATUS {
  VERIEFIED,
  CODESENT,
  FAILED,
  TIMEOUT,
}

class Login extends StatelessWidget implements AuthIn {
  Login({Key? key, this.changescreens}) : super(key: key);

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final Duration duration = const Duration(milliseconds: 300);

  Future<void> otpcallback(OTPSTATUS status) async {
    switch (status) {
      case OTPSTATUS.VERIEFIED:
        break;
      case OTPSTATUS.CODESENT:
        break;

      case OTPSTATUS.FAILED:
        break;
      case OTPSTATUS.TIMEOUT:
        break;
      default:
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: TweenAnimationBuilder(
          duration: duration,
          tween: Tween<double>(begin: 0, end: 1),
          builder: (context, double animation, child) => AnimatedPadding(
            duration: duration,
            padding: EdgeInsets.only(bottom: 150 * (1 - animation)),
            child: AnimatedOpacity(
              opacity: animation,
              duration: duration,
              child: child!,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: emailcontroller,
                        validator: (value) {
                          if (RegExp(emailregx).hasMatch(value!)) {
                            return null;
                          }
                          return "Please Enter a valid Email Id.";
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      TextFormField(
                        controller: passwordcontroller,
                        validator: (value) {
                          if (value!.isNotEmpty) {
                            return null;
                          }
                          return "Please Enter a valid password.";
                        },
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              AuthResult authResult = await AuthController.loginUserWithEmail(
                                  emailcontroller.value.text, passwordcontroller.value.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(authResult.result)),
                              );
                            }
                          },
                          child: const Text("EMAIL LOG IN")),
                    ],
                  )),
              ElevatedButton(
                onPressed: () async {
                  Navigator.pushNamed(context, Routes.OTPLOGIN);
                },
                child: const Text('Phone SIGN IN'),
              ),
              ElevatedButton(
                onPressed: () async {
                  AuthResult authResult = await AuthController.loginSocialUser(SOCIALLOGIN.GOOGLE);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(authResult.result)),
                  );
                },
                child: const Text('GOOGLE SIGN IN'),
              ),
              ElevatedButton(
                onPressed: () async {
                  //Apple sign in is not yet configured.
                  AuthResult authResult = await AuthController.loginSocialUser(SOCIALLOGIN.APPLE);

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(authResult.result)),
                  );
                },
                child: const Text('APPLE SIGN IN'),
              ),
              ElevatedButton(
                onPressed: () {
                  changescreens!();
                },
                child: const Text('Go To Register'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  late final Function? changescreens;
}
