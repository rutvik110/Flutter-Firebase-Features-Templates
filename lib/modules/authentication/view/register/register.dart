import 'package:flutter/material.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/controllers/authcontroller.dart';
import 'package:flutter_firebase_feature_templates/utilities/interfaces/AuthResult.dart';
import 'package:flutter_firebase_feature_templates/utilities/interfaces/authin.dart';
import 'package:flutter_firebase_feature_templates/utilities/regx.dart';

class Register extends StatelessWidget implements AuthIn {
  Register({Key? key, this.changescreens}) : super(key: key);

  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();
  final Duration duration = const Duration(milliseconds: 300);
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
                          return "Please enter a valid email.";
                        },
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      TextFormField(
                        controller: passwordcontroller,
                        validator: (value) {
                          if (RegExp(passwordregx1).hasMatch(value!)) {
                            return null;
                          }
                          return "Please enter a valid password.";
                        },
                        decoration: const InputDecoration(
                          labelText: 'Password',
                        ),
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              AuthResult authResult = await AuthController.signUpUserWithEmail(
                                  emailcontroller.value.text, passwordcontroller.value.text);
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(authResult.result)),
                              );
                            }
                          },
                          child: const Text("EMAIL SIGN IN")),
                    ],
                  )),
              ElevatedButton(
                onPressed: () {
                  changescreens!();
                },
                child: const Text('Go To Log In'),
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
