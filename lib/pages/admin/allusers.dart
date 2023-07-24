import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';
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
            appBar: AppBar(),
            body: ConditionalBuilder(
                condition: state is! LoadingGetUserData,
                builder: (context) => Row(
                      children: [
                        leftPage(context, allItems: true, users: true),
                        centerPage(context,
                            allItem: true,
                            scaffoldKey: scaffoldKey,
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
