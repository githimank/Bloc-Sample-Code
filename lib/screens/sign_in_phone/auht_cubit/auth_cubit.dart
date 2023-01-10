import 'package:bloc_practice/screens/sign_in_phone/auht_cubit/auth_state.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  AuthCubit() : super(AuthInitialState()) {
    User? currentUser = _auth.currentUser;
    if (currentUser != null) {
      emit(AuthLoggedInState(firebaseUser: currentUser));
    } else {
      emit(AuthLoggedOutState());
    }
  }

  String? _verificationID;

  void sendOtp({required String phoneNumber}) async {
    emit(AuthLoadingState());
    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (phoneAuthCredential) {
        signInWithPhone(credential: phoneAuthCredential);
      },
      verificationFailed: (error) {
        emit(AuthErrorState(errorMessage: error.message.toString()));
      },
      codeSent: (verificationId, forceResendingToken) {
        _verificationID = verificationId;
        emit(AuthCodeSentState());
      },
      codeAutoRetrievalTimeout: (verificationId) {
        _verificationID = verificationId;
      },
    );
  }

  void verifyOtp({required String otp}) {
    emit(AuthLoadingState());
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: _verificationID.toString(), smsCode: otp);
    signInWithPhone(credential: credential);
  }

  void signInWithPhone({required PhoneAuthCredential credential}) async {
    try {
      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      if (userCredential.user != null) {
        emit(AuthLoggedInState(firebaseUser: userCredential.user!));
      }
    } on FirebaseException catch (e) {
      emit(AuthErrorState(errorMessage: e.message.toString()));
    }
  }

  void signOut() {
    _auth.signOut();
    emit(AuthLoggedOutState());
  }
}
