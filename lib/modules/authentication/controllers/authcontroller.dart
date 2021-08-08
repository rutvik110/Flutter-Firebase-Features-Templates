import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:flutter_firebase_feature_templates/services/auth/authapi.dart';
import 'package:flutter_firebase_feature_templates/utilities/enums.dart';
import 'package:flutter_firebase_feature_templates/utilities/interfaces/AuthResult.dart';

//Let one function do one thing unless it's really needed to put the second thing
//in that function.
//Why? Coze it's easy to debug things coze everyone's doing only one thing.

class AuthController {
  static Stream<fauth.User?> get authstream {
    return AuthAPI.authstream;
  }

  static Future<void> signOut() async {
    return AuthAPI.signOut();
  }

  static Future<AuthResult> signUpUserWithEmail(String email, String password) async {
    return AuthAPI.signUpUserWithEmail(email, password);
  }

  static Future<AuthResult> loginSocialUser(SOCIALLOGIN loginmethod) async {
    return AuthAPI.loginSocialUser(loginmethod);
  }

  static Future<AuthResult> loginUserWithEmail(String email, String password) async {
    return AuthAPI.loginUserWithEmail(email, password);
  }

  static Future<AuthResult> loginUserWithPhone(String phone_number, Function otpcallback, [String? resendtoken]) async {
    return AuthAPI.loginUserWithPhone(phone_number, otpcallback, resendtoken);
  }
}
