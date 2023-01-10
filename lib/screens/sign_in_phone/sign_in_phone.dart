import 'package:bloc_practice/screens/sign_in_phone/auht_cubit/auth_cubit.dart';
import 'package:bloc_practice/screens/sign_in_phone/home_page.dart';
import 'package:bloc_practice/screens/sign_in_phone/verify_phone_number.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'auht_cubit/auth_state.dart';

class AuthenticationScreen extends StatelessWidget {
  const AuthenticationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) => previous is AuthInitialState,
      builder: (context, state) {
        if (state is AuthLoggedInState) {
          return const HomeScreen();
        } else if (state is AuthLoggedOutState) {
          return SignInPhoneScreen();
        }
        return const Scaffold();
      },
    );
  }
}

class SignInPhoneScreen extends StatelessWidget {
  SignInPhoneScreen({
    Key? key,
  }) : super(key: key);

  final TextEditingController phoneController = TextEditingController();

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
        title: const Text("Sign In With Phone"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                TextField(
                  controller: phoneController,
                  maxLength: 10,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter Phone Number",
                      counterText: ""),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthCodeSentState) {
                      Navigator.push(context,
                          MaterialPageRoute(builder: ((context) {
                        return VerifyPhoneNumber();
                      })));
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    return SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: CupertinoButton(
                          color: Colors.blue,
                          onPressed: () {
                            String phoneNumber = "+91${phoneController.text}";
                            BlocProvider.of<AuthCubit>(context)
                                .sendOtp(phoneNumber: phoneNumber);
                          },
                          child: const Text("Sign In")),
                    );
                  },
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
