abstract class AuthResult {
  late String result;
}

class AuthSuccess implements AuthResult {
  AuthSuccess(String result) {
    this.result = result.replaceAll(RegExp(r'-'), ' ');
  }

  @override
  late String result;
}

class AuthError implements AuthResult {
  AuthError(String result) {
    this.result = result.replaceAll(RegExp(r'-'), ' ');
  }

  @override
  late String result;
}
