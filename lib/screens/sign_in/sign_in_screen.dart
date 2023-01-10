import 'package:bloc_practice/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:bloc_practice/screens/sign_in/bloc/sign_in_events.dart';
import 'package:bloc_practice/screens/sign_in/bloc/sign_in_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text("Sign In Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: ListView(
          children: [
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if (state is SignInErrorState) {
                  return Text(
                    state.errorMessage,
                    style: const TextStyle(color: Colors.red),
                  );
                } else {
                  return Container();
                }
              },
            ),
            TextField(
              onChanged: (value) {
                BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(
                    emailValue: emailController.text,
                    passwordValue: passwordController.text));
              },
              decoration: const InputDecoration(hintText: "Email Address"),
              controller: emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            TextField(
              onChanged: (value) {
                BlocProvider.of<SignInBloc>(context).add(SignInTextChangedEvent(
                    emailValue: emailController.text,
                    passwordValue: passwordController.text));
              },
              decoration: const InputDecoration(hintText: "Password"),
              controller: passwordController,
            ),
            const SizedBox(
              height: 30,
            ),
            BlocBuilder<SignInBloc, SignInState>(
              builder: (context, state) {
                if (state is SignInLoadingState) {
                  return const SizedBox(
                    height: 10,
                    width: 10,
                    child: CircularProgressIndicator(),
                  );
                }

                return CupertinoButton(
                  onPressed: () {
                    if (state is SignInValidState) {
                      BlocProvider.of<SignInBloc>(context).add(
                          SignInSubmittedEvent(
                              email: emailController.text,
                              password: passwordController.text));
                    }
                  },
                  color: (state is SignInValidState)
                      ? Colors.blueAccent
                      : Colors.grey,
                  child: const Text("Sign-in"),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
