import 'package:flutter/material.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/view/authroot.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/view/otplogin/enterotp.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/view/otplogin/otplogin.dart';
import 'package:flutter_firebase_feature_templates/modules/home/view/home.dart';

import 'app_routes.dart';

Route<dynamic> generateroute(RouteSettings settings) {
  late List<String> arguments;
  if (settings.arguments != null) {
    arguments = settings.arguments as List<String>;
  }

  switch (settings.name) {
    case Routes.HOME:
      return MaterialPageRoute(builder: (_) => const Home());

    case Routes.AUTHROOT:
      return MaterialPageRoute(builder: (_) => const AuthRoot());

    case Routes.OTPLOGIN:
      return MaterialPageRoute(builder: (_) => OTPLogin());

    case Routes.ENTEROTP:
      return MaterialPageRoute(
          builder: (_) => EnterOTP(
                verification_id: arguments[0],
                resendtoken: arguments[1],
                number: arguments[2],
              ));

    default:
      return MaterialPageRoute(
          builder: (_) => Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    const Text('No route defined'),
                  ],
                ),
              ));
  }
}
