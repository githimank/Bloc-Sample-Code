import 'package:bloc_practice/cubits/internet_cubits/internet_cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InternetCubitScreen extends StatelessWidget {
  const InternetCubitScreen({super.key});

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
      ),
      body: Center(
        child: BlocConsumer<InternetCubit, InternetCubitState>(
          listener: (context, state) {
            if (state == InternetCubitState.gained) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Internet Connected",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.green,
              ));
            } else if (state == InternetCubitState.lost) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                content: Text(
                  "Internet Lost",
                  style: TextStyle(color: Colors.white),
                ),
                backgroundColor: Colors.red,
              ));
            }
          },
          builder: (context, state) {
            if (state == InternetCubitState.gained) {
              return const Text("Connected");
            } else if (state == InternetCubitState.lost) {
              return const Text("Not Connected");
            } else {
              return const Text("Loading...");
            }
          },
        ),
      ),
    );
  }
}
