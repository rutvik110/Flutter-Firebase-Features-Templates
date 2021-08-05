import 'package:flutter/material.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/view/login/login.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/view/register/register.dart';

class LogInOrRegister extends StatefulWidget {
  const LogInOrRegister({Key? key}) : super(key: key);

  @override
  _LogInOrRegisterState createState() => _LogInOrRegisterState();
}

class _LogInOrRegisterState extends State<LogInOrRegister> {
  late bool login;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    login = true;
  }

  void changestatus() {
    setState(() {
      login = !login;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (login) {
      return Login(
        changescreens: changestatus,
      );
    } else {
      return Register(
        changescreens: changestatus,
      );
    }
  }
}
