import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:lastcashir/pages/admin/adminhomepage.dart';
import 'package:lastcashir/pages/admin/detailsofbill.dart';

import '../home_page.dart';

class ShowBill extends StatelessWidget {
  const ShowBill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, States>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
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
              title: Text("Bills"),
              backgroundColor: HexColor('#549AAB'),
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ConditionalBuilder(
                condition: state is! LoadingGetBillData,
                builder: (context) => Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                            child: Text(
                          "Id",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),
                        )),
                        Expanded(
                            child: Text(
                          "name",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),
                        )),
                        Expanded(
                            child: Text(
                          "total",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),
                        )),
                        Expanded(
                            child: Text(
                          "date",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),
                        )),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView.separated(
                            itemBuilder: (context, index) => InkWell(
                                  onTap: () {
                                    cubit.get(context).getDetailsData(
                                        id: cubit.get(context).billList[0]
                                            [index]['id']);
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Details()));
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                            child: Text(
                                          "${cubit.get(context).billList[0][index]['id'].toString()}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 17),
                                        )),
                                        Expanded(
                                            child: Text(
                                          "${cubit.get(context).billList[0][index]["name"]}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 17),
                                        )),
                                        Expanded(
                                            child: Text(
                                          "${cubit.get(context).billList[0][index]["total"].toString()}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 17),
                                        )),
                                        Expanded(
                                            child: Text(
                                          "${cubit.get(context).billList[0][index]["date"]}",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 17),
                                        )),
                                        // Expanded(
                                        //     child: Text(
                                        //   "${cubit.get(context).detailsList[index]["item"]}",
                                        //   textAlign: TextAlign.center,
                                        //   style: TextStyle(fontSize: 17),
                                        // )),
                                        // Expanded(
                                        //     child: Text(
                                        //   "${cubit.get(context).detailsList[index]["quantity"].toString()}",
                                        //   textAlign: TextAlign.center,
                                        //   style: TextStyle(fontSize: 17),
                                        // )),
                                        // Expanded(
                                        //     child: Text(
                                        //   "${cubit.get(context).detailsList[index]["price"].toString()}",
                                        //   textAlign: TextAlign.center,
                                        //   style: TextStyle(fontSize: 17),
                                        // )),
                                      ],
                                    ),
                                  ),
                                ),
                            separatorBuilder: (context, index) => Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Colors.black,
                                ),
                            itemCount: cubit.get(context).billList[0].length),
                      ),
                    ),
                  ],
                ),
                fallback: (context) => Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
