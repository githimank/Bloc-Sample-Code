import 'package:bloc_practice/screens/sign_in_phone/auht_cubit/auth_cubit.dart';
import 'package:bloc_practice/screens/sign_in_phone/auht_cubit/auth_state.dart';
import 'package:bloc_practice/screens/sign_in_phone/sign_in_phone.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal.shade600,
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Center(
              child: Text(
            "Hi, Welcome To The Home Screen",
            style: TextStyle(color: Colors.white, fontSize: 18),
          )),
          const SizedBox(
            height: 50,
          ),
          BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthLoggedOutState) {
                Navigator.popUntil(context, (route) => route.isFirst);
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: ((context) {
                  return const WelcomeScreen();
                })));
              }
            },
            child: CupertinoButton(
              color: Colors.red,
              child: const Text(
                "Logged Out",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                BlocProvider.of<AuthCubit>(context).signOut();
              },
            ),
          )
        ],
      ),
    );
  }
}
