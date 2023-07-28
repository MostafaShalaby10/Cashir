import 'package:desktop_window/desktop_window.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastcashir/authontication/loginPage.dart';
import 'package:lastcashir/authontication/signupPage.dart';
import 'package:lastcashir/pages/add_item_page.dart';
import 'package:lastcashir/pages/admin/adminhomepage.dart';
import 'package:lastcashir/pages/admin/allusers.dart';
import 'package:lastcashir/pages/admin/updateuser.dart';
import 'package:lastcashir/pages/all_items.dart';
import 'package:lastcashir/pages/cold_drink_page.dart';
import 'package:lastcashir/widgets/mahmoud.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'dart:io';
import 'package:flutter/services.dart';
import 'package:window_manager/window_manager.dart';

import 'cubits/cubit.dart';
import 'cubits/states.dart';
import 'pages/home_page.dart';

import 'dart:ui' as ui;

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([]);
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

  sqfliteFfiInit();

  databaseFactory = databaseFactoryFfi;

  await windowManager.ensureInitialized();
  WindowOptions windowOptions = const WindowOptions(
    fullScreen: true
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
  runApp(const MyApp());

}

String? name;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => cubit()..createDb(),
      child: BlocConsumer<cubit, States>(
          builder: (context, state) {
            return const MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Login(),
            );
          },
          listener: (context, state) {}),
    );
  }
}
