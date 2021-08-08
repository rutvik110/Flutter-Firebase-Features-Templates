import 'package:flutter/material.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/controllers/authcontroller.dart';
import 'package:flutter_firebase_feature_templates/modules/authentication/view/login/login.dart';
import 'package:flutter_firebase_feature_templates/routes/app_routes.dart';
import 'package:flutter_firebase_feature_templates/utilities/interfaces/AuthResult.dart';

class OTPLogin extends StatefulWidget {
  OTPLogin({Key? key}) : super(key: key);

  @override
  _OTPLoginState createState() => _OTPLoginState();
}

class _OTPLoginState extends State<OTPLogin> {
  final TextEditingController numbercontroller = TextEditingController();

  Future<void> otpcallback(OTPSTATUS status, List<String?> messages) async {
    switch (status) {
      case OTPSTATUS.VERIEFIED:
        break;
      case OTPSTATUS.CODESENT:
        messages.add("+91" + numbercontroller.value.text);
        Navigator.pushReplacementNamed(context, Routes.ENTEROTP, arguments: messages);
        break;

      case OTPSTATUS.FAILED:
        showmessage(messages[0]!, context);
        break;
      case OTPSTATUS.TIMEOUT:
        showmessage(messages[0]!, context);
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
            controller: numbercontroller,
          ),
          ElevatedButton(
            onPressed: () async {
              AuthResult authResult =
                  await AuthController.loginUserWithPhone('+91' + numbercontroller.value.text, otpcallback);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(authResult.result),
                  backgroundColor: (authResult is AuthSuccess) ? Colors.black87 : Colors.red,
                ),
              );
            },
            child: const Text('Phone SIGN IN'),
          ),
        ],
      ),
    );
  }
}

void showmessage(String message, BuildContext context) {
  ScaffoldMessenger.maybeOf(context)!.showSnackBar(
    SnackBar(
      content: Text(message),
    ),
  );
}
