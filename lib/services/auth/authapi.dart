import 'package:firebase_auth/firebase_auth.dart' as fauth;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_firebase_feature_templates/models/userdata.dart';
import 'package:flutter_firebase_feature_templates/utilities/database_data_paths.dart';
import 'package:flutter_firebase_feature_templates/utilities/enums.dart';
import 'package:flutter_firebase_feature_templates/utilities/interfaces/AuthResult.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart' as sa;

fauth.FirebaseAuth _auth = fauth.FirebaseAuth.instance;

class AuthAPI {
  //function to create user doc
  static Stream<User?> get authstream {
    return _auth.authStateChanges();
  }

  // static Future<void> createuserdoc(fauth.User user) async {
  //   final docref = userscollection.doc(user.uid);

  //   await docref.set({
  //     "name": user.displayName ?? 'ND',
  //     "emailid": user.email,
  //     "profilepic": user.photoURL ??
  //         "https://image.shutterstock.com/image-vector/user-login-authenticate-icon-human-260nw-1365533969.jpg",
  //   });
  // }

  // static Stream<UserData> getuserdoc(fauth.User user) {
  //   return userscollection.doc(user.uid).snapshots().map((doc) => UserData.fromDoc(doc));
  // }

  static Future<void> signOut() async {
    try {
      await GoogleSignIn.standard().signOut();
      await _auth.signOut();
    } catch (e) {
      print(e);
    }
  }

  static Future<AuthResult> signUpUserWithEmail(String email, String password) async {
    AuthResult authResult;
    try {
      final fauth.UserCredential _authResult =
          await _auth.createUserWithEmailAndPassword(email: email.trim(), password: password);
      //Do anything here i.e. required when the user signs up for first time.

      if (_authResult.user != null) {
        //await createuserdoc(_authResult.user!);
      }
      authResult = AuthSuccess('Success');
      return authResult;
    } on fauth.FirebaseAuthException catch (result) {
      authResult = AuthError(result.code);
      return authResult;
    } catch (e) {
      print('e');
      authResult = AuthError('Something went wrong. Please check your connection.');

      return authResult;
    }
  }

  static Future<AuthResult> loginSocialUser(SOCIALLOGIN loginmethods) async {
    AuthResult authResult;
    try {
      switch (loginmethods) {
        case SOCIALLOGIN.GOOGLE:
          await loginUserWithGoogle();
          break;

        case SOCIALLOGIN.APPLE:
          await loginUserWithApple();
          break;
        default:
      }

      authResult = AuthSuccess('Success');
      return authResult;
    } on fauth.FirebaseAuthException catch (result) {
      authResult = AuthError(result.code);
      return authResult;
    } catch (e) {
      print(e.toString());
      authResult = AuthError('Something went wrong. Please check your connection.');

      return authResult;
    }
  }

  static Future<AuthResult> loginUserWithEmail(String email, String password) async {
    AuthResult authResult;

    try {
      await _auth.signInWithEmailAndPassword(email: email.trim(), password: password);
      authResult = AuthSuccess('Success');
      return authResult;
    } on fauth.FirebaseAuthException catch (result) {
      authResult = AuthError(result.code);
      return authResult;
    } catch (e) {
      print(e.toString());
      authResult = AuthError('Something went wrong. Please check your connection.');

      return authResult;
    }
  }

  static Future<void> loginUserWithGoogle() async {
    GoogleSignIn _googleSignIn = GoogleSignIn();

    GoogleSignInAccount? _googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication? _googleAuth = await _googleUser?.authentication;
    final fauth.AuthCredential credential =
        fauth.GoogleAuthProvider.credential(idToken: _googleAuth?.idToken, accessToken: _googleAuth?.accessToken);
    final fauth.UserCredential _authResult = await _auth.signInWithCredential(credential);

    if (_authResult.user != null) {
      if (_authResult.additionalUserInfo!.isNewUser) {
        //Do anything here i.e. required when the user signs up for first time.

        //await createuserdoc(_authResult.user!);
      }
    }
  }

  static Future<void> loginUserWithApple() async {
    sa.AuthorizationCredentialAppleID _appleSignIn = await sa.SignInWithApple.getAppleIDCredential(scopes: []);

    final fauth.AuthCredential credential =
        fauth.OAuthProvider("apple.com").credential(idToken: _appleSignIn.identityToken);
    final fauth.UserCredential _authResult = await _auth.signInWithCredential(credential);

    if (_authResult.user != null) {
      if (_authResult.additionalUserInfo!.isNewUser) {
        //Do anything here i.e. required when the user signs up for first time.

       // await createuserdoc(_authResult.user!);
      }
    }
  }
}
