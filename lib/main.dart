import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastcashir/authontication/signupPage.dart';
import 'package:lastcashir/pages/cold_drink_page.dart';


import 'cubits/cubit.dart';
import 'cubits/states.dart';
import 'pages/home_page.dart';


void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit(),
      child: BlocConsumer<cubit , States>(
          builder: (context, state) {
            return  MaterialApp(
              debugShowCheckedModeBanner: false,
              home: SignUp(),
            );
          },
          listener: (context, state) {}),
    );
  }
}