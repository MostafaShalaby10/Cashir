import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/components/constants.dart';
import 'package:lastcashir/pages/admin/adminhomepage.dart';

import '../components/custom_button.dart';
import '../cubits/cubit.dart';
import '../cubits/states.dart';
import '../widgets/center_page.dart';
import 'home_page.dart';

class AllItems extends StatelessWidget {
  const AllItems({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var scaffoldKey = GlobalKey<ScaffoldState>();

    return BlocConsumer<cubit, States>(
      builder: (context, state) {
        return Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => AdminHomePage()),
                      (route) => false);
                },
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              elevation: 0,
              title: Text("All Items Ubdate And Delete"),
              backgroundColor: primaryColor),
          body: Row(
            children: [
              leftPage(context, allItems: true, users: false),
              centerPage(context,
                  allItem: true,

                  list: cubit.get(context).orders, users: false),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
