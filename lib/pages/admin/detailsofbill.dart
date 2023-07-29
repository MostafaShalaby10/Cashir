import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/pages/admin/bills.dart';

import '../../components/constants.dart';
import '../../cubits/cubit.dart';
import '../../cubits/states.dart';

class Details extends StatelessWidget {
  const Details({Key? key}) : super(key: key);

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
                      MaterialPageRoute(builder: (context) => ShowBill()),
                      (route) => false);
                },
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              title: Text("Bills"),
              backgroundColor:primaryColor,
            ),
            body: Padding(
              padding: const EdgeInsets.all(15.0),
              child: ConditionalBuilder(
                condition: state is! LoadingGetDetailsData,
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
                          "Item",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),
                        )),
                        Expanded(
                            child: Text(
                          "Quantity",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),
                        )),
                        Expanded(
                            child: Text(
                          "Price",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 17),
                        )),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: ListView.separated(
                            itemBuilder: (context, index) => Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 15.0),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Text(
                                    "${cubit.get(context).detailsList[0][index]['details_id'].toString()}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 17),
                                  )),
                                  Expanded(
                                      child: Text(
                                    "${cubit.get(context).detailsList[0][index]["item"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 17),
                                  )),
                                  Expanded(
                                      child: Text(
                                    "${cubit.get(context).detailsList[0][index]["quantity"].toString()}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 17),
                                  )),
                                  Expanded(
                                      child: Text(
                                    "${cubit.get(context).detailsList[0][index]["price"]}",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(fontSize: 17),
                                  )),
                                ],
                              ),
                            ),
                            separatorBuilder: (context, index) => Container(
                                  height: 1,
                                  width: double.infinity,
                                  color: Colors.black,
                                ),
                            itemCount:
                                cubit.get(context).detailsList[0].length),
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
