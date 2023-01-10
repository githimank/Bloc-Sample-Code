import 'package:bloc_practice/screens/sign_in/bloc/sign_in_events.dart';
import 'package:bloc_practice/screens/sign_in/bloc/sign_in_state.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(SignInInitialState()) {
    on<SignInTextChangedEvent>((event, emit) {
      if (EmailValidator.validate(event.emailValue) == false) {
        emit(SignInErrorState(
            errorMessage: "Please Enter a Valid Email Address"));
      } else if (event.passwordValue.length < 8) {
        emit(SignInErrorState(errorMessage: "Please Enter a Valid Password"));
      } else {
        emit(SignInValidState());
      }
    });
    on<SignInSubmittedEvent>((event, emit) {
      emit(SignInLoadingState());
    });
  }
}
