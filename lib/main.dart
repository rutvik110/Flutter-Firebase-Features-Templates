import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/view/authroot.dart';
import 'package:flutter_firebase_feature_templates/modules/home/view/home.dart';
import 'package:flutter_firebase_feature_templates/routes/app_routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<FirebaseApp>(
      future: Firebase.initializeApp(),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          return MaterialApp(
            initialRoute: Routes.AUTHROOT,
            routes: {
              Routes.HOME: (context) => const Home(),
              Routes.AUTHROOT: (context) => const AuthRoot(),
            },
          );
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(snapshot.error.toString()),
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
