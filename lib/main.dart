import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastcashir/authontication/loginPage.dart';
import 'package:lastcashir/authontication/signupPage.dart';
import 'package:lastcashir/pages/add_item_page.dart';
import 'package:lastcashir/pages/all_items.dart';
import 'package:lastcashir/pages/cold_drink_page.dart';
import 'package:lastcashir/widgets/mahmoud.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';


import 'cubits/cubit.dart';
import 'cubits/states.dart';
import 'pages/home_page.dart';


Future  main() async {

  await WidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit()..createDb() ,
      child: BlocConsumer<cubit , States>(
          builder: (context, state) {
            return  const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: HomePage(),
            );
          },
          listener: (context, state) {}),
    );
  }
}