import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_feature_templates/modules/home/view/home.dart';

import 'loginorregister.dart';

class AuthWrapper extends StatelessWidget {
  AuthWrapper({Key? key, this.user}) : super(key: key);

  final User? user;

  @override
  Widget build(BuildContext context) {
    if (user != null) {
      //fetching any user specific data or anything primary data 
      //and pass it down the tree if required
      return const Home();
    } else {
      return  const LogInOrRegister(); 
    }
  }
}


