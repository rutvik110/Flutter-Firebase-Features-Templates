import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/controllers/authcontroller.dart';
import 'package:flutter_firebase_feature_templates/routes/app_routes.dart';
import 'package:flutter_firebase_feature_templates/services/auth/authapi.dart';

import '../login/login.dart';

//Build it as a separate view
class EnterOTP extends StatelessWidget {
  EnterOTP({
    Key? key,
    required this.verification_id,
    required this.resendtoken,
    required this.number,
  }) : super(key: key);

  final String? verification_id;
  final String? resendtoken;
  final String? number;
  final TextEditingController otpcontroller = TextEditingController();
  Future<void> otpcallback(OTPSTATUS status, List<String> messages) async {
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: otpcontroller,
            decoration: const InputDecoration(labelText: 'Enter otp'),
          ),
          const SizedBox(
            height: 10,
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: ElevatedButton(
              onPressed: () async {
                await AuthController.loginUserWithPhone(number!, otpcallback, resendtoken);
              },
              child: const Text('Resend otp'),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              //sign in with otp
              await AuthAPI.signinwithcredentials(
                verification_id!,
                otpcontroller.value.text,
              );
              Navigator.pop(context);
            },
            child: const Text('SUBMIT'),
          )
        ],
      ),
    );
  }
}
