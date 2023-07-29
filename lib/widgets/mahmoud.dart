import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lastcashir/components/custom_button.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:lastcashir/widgets/center_page.dart';

import '../components/constants.dart';

class Mahmoud extends StatelessWidget {
  const Mahmoud({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController searchByID = TextEditingController();
    TextEditingController searchByName = TextEditingController();
    List<dynamic> list = [] ;
    var scaffoldKey  =GlobalKey<ScaffoldState>();
    return BlocConsumer<cubit, States>(
        builder: (context, state) {
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: const Text("Search"),
              backgroundColor: primaryColor,
            ),
            body: SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [

                    Row(
                      children: [
                        Expanded(
                          flex: 1,
                          child: textField(
                              onChangedFunction: (value) {
                            cubit.get(context).searchByIdFunction(id: int.parse(value!));
                            list = cubit.get(context).searchById;
                          }, context,
                              text: 'Search by Id',
                              prefixIcon: Icons.search,
                              controller: searchByID,
                              type: TextInputType.number),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          flex: 3,
                          child: textField(
                              onChangedFunction: (value) {
                                cubit.get(context).searchByNameFunction(name: value.toString());
                                list = cubit.get(context).searchByName;

                              },context,
                              text: 'Search by name',
                              prefixIcon: Icons.search,
                              controller: searchByName,
                              type: TextInputType.name),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30,
                    ),
                   centerPage(context, allItem: false, list: list, users: false),
                  ],
                ),
              ),
            ),
          );
        },
        listener: (context, state) {});
  }
}
