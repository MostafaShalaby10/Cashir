import 'dart:ffi';

import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/components/custom_button.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';

import '../widgets/center_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    var scaffoldKey = GlobalKey<ScaffoldState>();
    var formKey = GlobalKey<FormState>();
    TextEditingController searchByID = TextEditingController();
    TextEditingController searchByName = TextEditingController();
    return BlocConsumer<cubit, States>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
              elevation: 0,
              title: Text("Simple Cafe"),
              backgroundColor: HexColor('#549AAB')),
          body: ConditionalBuilder(
              condition: state is! LoadingGetItemData,
              builder: (context) => Row(
                    children: [
                      LeftPage(context, allItems: false),
                      CenterPage(context,
                          allItem: false, scaffoldKey: scaffoldKey),
                      RightPage(context),
                    ],
                  ),
              fallback: (context) =>
                  Center(child: CircularProgressIndicator())),
        );
      },
      listener: (context, state) {},
    );
  }
}
