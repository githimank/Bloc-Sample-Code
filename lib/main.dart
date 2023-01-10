import 'package:bloc_practice/blocs/internet_blocs/internet_bloc.dart';
import 'package:bloc_practice/cubits/internet_cubits/internet_cubits.dart';
import 'package:bloc_practice/screens/internet_connectivity/internet_cubit_screen.dart';
import 'package:bloc_practice/screens/internet_connectivity/internet_screen.dart';
import 'package:bloc_practice/screens/sign_in/bloc/sign_in_bloc.dart';
import 'package:bloc_practice/screens/sign_in/sign_in_screen.dart';
import 'package:bloc_practice/screens/sign_in_phone/auht_cubit/auth_cubit.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'screens/sign_in_phone/sign_in_phone.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => InternetBloc(),
        ),
        BlocProvider(
          create: (context) => InternetCubit(),
        ),
        BlocProvider(
          create: ((context) => SignInBloc()),
        ),
        BlocProvider(
          create: ((context) => AuthCubit()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const WelcomeScreen(),
      ),
    );
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Welcome Screen"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: ElevatedButton(
                onPressed: (() => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const InternetScreen()))),
                child: const Text("Internet Screen")),
          ),
          Center(
            child: ElevatedButton(
                onPressed: (() => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const InternetCubitScreen()))),
                child: const Text("Internet Screen With Cubit")),
          ),
          Center(
            child: ElevatedButton(
                onPressed: (() => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => SignInScreen()))),
                child: const Text("Sign In Screen")),
          ),
          Center(
            child: ElevatedButton(
                onPressed: (() => Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        const AuthenticationScreen()))),
                child: const Text("Sign In With Phone")),
          )
        ],
      ),
    );
  }
}
