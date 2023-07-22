import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

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

    return BlocConsumer<cubit,States>(
      builder: (context,state){
        return  Scaffold(
          key: scaffoldKey,
          appBar: AppBar(
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: (){
                  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
                },
                icon: Icon(
                    Icons.arrow_back_ios_new
                ),
              ),
              elevation: 0,
              title: Text("All Items Ubdate And Delete"),

              backgroundColor: HexColor('#549AAB')),

          body: Row(
            children: [
              LeftPage(context , allItems: true),
              CenterPage(context,allItem: true , scaffoldKey:scaffoldKey  ),

            ],
          ),

        );
      },
      listener: (context, state) {},
    );
  }
}
