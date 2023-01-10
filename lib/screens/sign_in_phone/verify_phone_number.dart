import 'package:bloc_practice/screens/sign_in_phone/auht_cubit/auth_cubit.dart';
import 'package:bloc_practice/screens/sign_in_phone/auht_cubit/auth_state.dart';
import 'package:bloc_practice/screens/sign_in_phone/home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyPhoneNumber extends StatelessWidget {
  VerifyPhoneNumber({super.key});

  final TextEditingController otpController = TextEditingController();
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
        title: const Text("Verify Phone Number"),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              children: [
                TextField(
                  maxLength: 6,
                  controller: otpController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "Enter 6-Digit OTP",
                      counterText: ""),
                ),
                const SizedBox(
                  height: 20,
                ),
                BlocConsumer<AuthCubit, AuthState>(
                  listener: (context, state) {
                    if (state is AuthLoggedInState) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      Navigator.pushReplacement(context,
                          MaterialPageRoute(builder: ((context) {
                        return const HomeScreen();
                      })));
                    }

                    if (state is AuthErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(state.errorMessage),
                        backgroundColor: Colors.red,
                        duration: const Duration(seconds: 3),
                      ));
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
                            BlocProvider.of<AuthCubit>(context)
                                .verifyOtp(otp: otpController.text);
                          },
                          child: const Text("Verify")),
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
