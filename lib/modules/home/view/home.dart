import 'package:flutter/material.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/controllers/authcontroller.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
        
            ElevatedButton(
                onPressed: () {
                  AuthController.signOut();
                },
                child:const Text('SIGN OUT'))
          ],
        ),
      ),
    );
  }
}
