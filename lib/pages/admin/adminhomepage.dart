import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/authontication/loginPage.dart';
import 'package:lastcashir/components/constants.dart';
import 'package:lastcashir/components/custom_button.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:lastcashir/pages/admin/allusers.dart';
import 'package:lastcashir/pages/admin/bills.dart';
import 'package:lastcashir/pages/all_items.dart';
import 'package:lastcashir/pages/home_page.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, States>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              title: Text("Simple Cafe"),
              backgroundColor: primaryColor,
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => Login()),
                          (route) => false);
                    },
                    child: Text(
                      "Logout",
                      style: TextStyle(color: Colors.black),
                    ))
              ],
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          button(
                              context: context,
                              text: "Users",
                              color: primaryColor,
                              minWidth: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 4,
                              function: () {
                                cubit.get(context).getUserData();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const AllUsers()));
                              }),
                          SizedBox(
                            width: 20,
                          ),
                          button(
                              context: context,
                              text: "Items",
                              color: primaryColor,
                              minWidth: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 4,
                              function: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const AllItems()));
                              }),
                          SizedBox(
                            width: 20,
                          ),
                          button(
                              context: context,
                              text: "Bills",
                              color: primaryColor,
                              minWidth: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 4,
                              function: () {
                                cubit.get(context).getBillData();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ShowBill()));
                              }),


                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          button(
                              context: context,
                              text: "Cashier",
                              color: primaryColor,
                              minWidth: MediaQuery.of(context).size.width / 4,
                              height: MediaQuery.of(context).size.height / 4,
                              function: () {
                                cubit.get(context).getBillData();
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const HomePage()));
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
