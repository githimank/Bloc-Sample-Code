import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthState {}

class AuthInitialState extends AuthState {}

class AuthCodeSentState extends AuthState {}

class AuthLoggedInState extends AuthState {
  final User firebaseUser;
  AuthLoggedInState({required this.firebaseUser});
}

class AuthLoggedOutState extends AuthState {}

class AuthCodeVerifiedState extends AuthState {}

class AuthErrorState extends AuthState {
  String errorMessage;
  AuthErrorState({required this.errorMessage});
}

class AuthLoadingState extends AuthState {}
