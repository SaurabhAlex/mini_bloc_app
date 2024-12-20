import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState{}

class AuthInitialState extends AuthState{}

class AuthLoadingState extends AuthState{}

class AuthCodeSendState extends AuthState{}

class AuthVerifyCodeState extends AuthState{}

class AuthLoggedInState extends AuthState{
  final User firebaseUser;
  AuthLoggedInState(this.firebaseUser);
}

class AuthLogOutState extends AuthState{}

class AuthErrorState extends AuthState{
  final String error;
  AuthErrorState(this.error);
}





