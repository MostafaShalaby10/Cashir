import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/authontication/loginPage.dart';
import 'package:lastcashir/components/custom_button.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:lastcashir/pages/admin/allusers.dart';
import 'package:lastcashir/pages/admin/bills.dart';
import 'package:lastcashir/pages/all_items.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit , States>(builder: (context , state){
      return  Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Text("Simple Cafe"),
          backgroundColor: HexColor('#549AAB'),
          actions: [

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

        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                button(
                    context: context,
                    text: "Users",
                    color: HexColor('#549AAB'),
                    minWidth: MediaQuery.of(context).size.width/4,
                    height:MediaQuery.of(context).size.height/4 ,
                    function: (){
                      cubit.get(context).getUserData();
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AllUsers()));
                    }),
                SizedBox(width: 20,),
                button(
                    context: context,
                    text: "Items",
                    color: HexColor('#549AAB'),
                    minWidth: MediaQuery.of(context).size.width/4,
                    height:MediaQuery.of(context).size.height/4 ,
                    function: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>const AllItems()));
                    }),
                SizedBox(width: 20,),
                button(
                    context: context,
                    text: "Bills",
                    color: HexColor('#549AAB'),
                    minWidth: MediaQuery.of(context).size.width/4,
                    height:MediaQuery.of(context).size.height/4 ,
                    function: (){
                      cubit.get(context).getBillData();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => ShowBill()));                    }),
              ],
            ),
          ),
        ),
      );
    }, listener: (context , state){});
  }
}
