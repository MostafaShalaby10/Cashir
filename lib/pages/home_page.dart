import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';


import '../widgets/center_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit,States>(
      builder: (context,state){
        return  Scaffold(
          appBar: AppBar(
              elevation: 0,
              title: Text("Simple Cafe"),
              backgroundColor: HexColor('#549AAB')),

          body: Row(
            children: [
             LeftPage(context , allItems: false),
              CenterPage(context,allItem: false),
              RightPage(context),
            ],
          ),

        );
      },
      listener: (context, state) {},
    );
  }

}

