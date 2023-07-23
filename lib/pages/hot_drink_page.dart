import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';

import '../components/custom_button.dart';
import '../widgets/center_page.dart';
import 'home_page.dart';

class HotDrink extends StatelessWidget {
  const HotDrink({Key? key}) : super(key: key);

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
                      MaterialPageRoute(builder: (context) => HomePage()),
                      (route) => false);
                },
                icon: Icon(Icons.arrow_back_ios_new),
              ),
              elevation: 0,
              title: Text("Hot Drink"),
              backgroundColor: HexColor('#549AAB')),
          body: Row(
            children: [
              LeftPage(context, allItems: false),
              CenterPage(context, allItem: false, scaffoldKey: scaffoldKey, list: cubit.get(context).hotDrinks),
              RightPage(context),
            ],
          ),
        );
      },
      listener: (context, state) {},
    );
  }
}
