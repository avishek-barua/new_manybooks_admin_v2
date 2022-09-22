import 'package:firebase_auth/firebase_auth.dart';

class AfterLogin {
  String? token;
  String? email;
  String? displayName;
  String tokenType;

  AfterLogin(this.token, this.email, this.displayName, this.tokenType);
}
