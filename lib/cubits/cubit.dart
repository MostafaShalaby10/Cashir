import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastcashir/cubits/states.dart';

class cubit extends Cubit<States>
{
  cubit() : super(InitialState());
  static cubit get(context) => BlocProvider.of(context);

  List <String> items = ["All items" , "Food" , "Cold Drinks" , "Hot Drinks" , "Deserts"];
  List <IconData> icons = [Icons.category , Icons.fastfood_outlined , Icons.water_drop_outlined , Icons.water_drop_outlined , Icons.message];
  List <String> orders = ["Original Burger" , "Ranch Burger" , "Orange" , "Apple" , "Chicken","Original Burger" , "Ranch Burger" , "Orange" , "Apple" , "Chicken"] ;
  List <int> quantity = [1 , 2 , 4 , 5 , 10,1 , 2 , 4 , 5 , 10] ;
  List <double> cost = [33.5 , 100 , 50.4 , 200 , 185,33.5 , 100 , 50.4 , 200 , 185] ;
}

