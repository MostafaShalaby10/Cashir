import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/components/constants.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:lastcashir/pages/admin/adminhomepage.dart';
import 'package:lastcashir/pages/all_items.dart';
import 'package:lastcashir/widgets/center_page.dart';

class AllUsers extends StatelessWidget {
  const AllUsers({Key? key}) : super(key: key);

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
                        MaterialPageRoute(builder: (context) => const AdminHomePage()),
                            (route) => false);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new),
                ),
                elevation: 0,
                title: const Text("Users Page"),
                backgroundColor: primaryColor),
            body: ConditionalBuilder(
                condition: state is! LoadingGetUserData,
                builder: (context) => Row(
                      children: [
                        leftPage(context, allItems: true, users: true),
                        centerPage(context,
                            allItem: true,
                            
                            list: cubit.get(context).users,
                            users: true),
                      ],
                    ),
                fallback: (context) =>
                    Center(child: CircularProgressIndicator())),
          );
        },
        listener: (context, state) {});
  }
}
