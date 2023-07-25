import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/authontication/loginPage.dart';
import 'package:lastcashir/components/custom_button.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:lastcashir/pages/admin/bills.dart';
import 'package:lastcashir/pages/fatora.dart';
import 'package:lastcashir/widgets/mahmoud.dart';

import '../widgets/center_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController controller = TextEditingController();
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocConsumer<cubit, States>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
            elevation: 0,
            title: Text("Simple Cafe"),
            backgroundColor: HexColor('#549AAB'),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Mahmoud()));
                  },
                  icon: Icon(Icons.search)),
              SizedBox(
                width: 10,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => Login()),
                        (route) => false);
                  },
                  child: Text("Logout", style: TextStyle(color: Colors.black),))
            ],
          ),
          body: ConditionalBuilder(
              condition: state is! LoadingGetItemData,
              builder: (context) => Row(
                    children: [
                      leftPage(context, allItems: false, users: false),
                      centerPage(context,
                          allItem: false,
                          scaffoldKey: scaffoldKey,
                          list: cubit.get(context).orders,
                          users: false),
                      rightPage(context),
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
