import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/controllers/authcontroller.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/view/authwrapper.dart';
import 'package:flutter_firebase_feature_templates/services/auth/authapi.dart';

class AuthRoot extends StatelessWidget {
  const AuthRoot({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthController.authstream, 

      builder: (BuildContext context,snapshot) {
        return AuthWrapper(user: snapshot.data); 
      },
    );

  }
}
