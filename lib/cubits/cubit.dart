import 'package:bloc/bloc.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:sqflite/sqflite.dart';

class cubit extends Cubit<States> {
  cubit() : super(InitialState());

  static cubit get(context) => BlocProvider.of(context);
  Color? color;

  List<String> items = [
    "All items",
    "Food",
    "Cold Drinks",
    "Hot Drinks",
    "Deserts"
  ];
  List<IconData> icons = [
    Icons.category,
    Icons.fastfood_outlined,
    Icons.water_drop_outlined,
    Icons.water_drop_outlined,
    Icons.message
  ];
  List<dynamic> orders = [];
  List<dynamic> food = [];
  List<dynamic> dessert = [];
  List<dynamic> coldDrinks = [];
  List<dynamic> hotDrinks = [];
  List<dynamic> searchById = [];
  List<dynamic> searchByName = [];

  double total = 0;

  void changeColor() {
    color = Colors.green;
  }

  List<List> bill = [];

  void addBill({required List list}) {
    bill.add(list);
    print(bill);
    calculateBill();
    emit(CreateBill());
  }

  void calculateBill() {
    total = 0;
    for (int i = 0; i < bill.length; i++) {
      total += bill[i][2];
      print("total is $total");
    }
    emit(CalculateBill());
  }

  void clearBill() {
    total = 0;
    bill.clear();
    emit(ClearBill());
  }

  void removeBillItem({required int index}) {
    total = 0;
    bill.removeAt(index);
    calculateBill();
    emit(RemoveBillItem());
  }

  void enterQuantity(
      {required TextEditingController controller, required String number}) {
    controller.text = controller.text + number;
  }

  /*
                                              DATABASE
   */

  String dbName = "Cashier";
  String userTable = "Users";
  String itemTable = "Items";
  int versionCode = 1;

  Database? db;

  void createDb() async {
    emit(LoadingCreateDataBase());
    await openDatabase(dbName, version: versionCode,
        onCreate: (database, version) {
      database
          .execute(
              "create table $userTable (id integer primary key , name text , password text , email text ) ;"
              " create table $itemTable (id integer primary key , label text , category text , price double )")
          .then((value) {
        print("create data success");
      }).catchError((error) {
        print("fail");
        print(error.toString());
      });
    }, onOpen: (database) {
      print("database opend successfully");
    }).then((value) {
      db = value;
      getItemData();

      emit(SuccessfullyCreateDataBase());
    }).catchError((error) {
      print("Can't open data");
      print(error.toString());
      emit(ErrorCreateDataBase());
    });
  }

  void insertUserData(
      {required String name,
      required String email,
      required String password}) async {
    emit(LoadingInsertUserData());
    await db!.transaction((txn) async {
      await txn
          .rawInsert(
              "insert into $userTable (name , password , email ) values ('$name' ,  '$password' , '$email')")
          .then((value) {
        print("insert success");
        emit(SuccessfullyInsertUserData());
      }).catchError((error) {
        print("insert error");
        print(error.toString());
        emit(ErrorInsertUserData());
      });
    });
  }

  void insertItemData(
      {required String label,
      required String category,
      required double price}) async {
    emit(LoadingInsertItemData());
    await db!.transaction((txn) async {
      await txn
          .rawInsert(
              "insert into $itemTable (label , category , price ) values ('$label' ,  '$category' , '$price')")
          .then((value) {
        print("insert success");
        emit(SuccessfullyInsertItemData());
      }).catchError((error) {
        print("insert error");
        print(error.toString());
        emit(ErrorInsertItemData());
      });
    });
  }

  void getUserData() {
    emit(LoadingGetUserData());
    db?.rawQuery("SELECT * FROM $userTable").then((value) {
      print(value);
      emit(SuccessfullyGetUserData());
    }).catchError((error) {
      print("Error in getData");
      print(error.toString());
      emit(ErrorGetUserData());
    });
  }

  void getItemData() {
    orders=[];
    dessert = [];
    coldDrinks = [];
    hotDrinks = [];
    food = [];
    emit(LoadingGetItemData());
    db?.rawQuery("SELECT * FROM $itemTable ").then((value) {
      // print(value[0]["id"]);
      value.forEach((element) {
        orders.add(element);
        if (element["category"] == "food") {
          food.add(element);
        } else if (element["category"] == "dessert") {
          dessert.add(element);
        } else if (element["category"] == "hot drink") {
          hotDrinks.add(element);
        } else if (element["category"] == "cold drink") {
          coldDrinks.add(element);
        }
      });
      print(orders);
    }).catchError((error) {
      print("Error in getData");
      print(error.toString());
      emit(ErrorGetItemData());
    });
  }

  void updateItemData({
    required int id,
    required double price,
    required String name,
    required String category,
  }) async {
    emit(LoadingUpdateItemData());

    db?.rawUpdate(
      'UPDATE $itemTable SET label = ? , price = ? , category=? WHERE id = ?',
      ['$name', '$price', '$category', id],
    ).then((value) {
      emit(SuccessfullyUpdateItemData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateItemData());
    });
  }

  void updateUserData({
    required int id,
    required int email,
    required int name,
    required int password,
  }) async {
    emit(LoadingUpdateUserData());

    db?.rawUpdate(
      'UPDATE $userTable SET name = ? , email = ? , password=? WHERE id = ?',
      ['$name', '$email', '$password', id],
    ).then((value) {
      emit(SuccessfullyUpdateUserData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateUserData());
    });
  }

  void deleteItemData({
    required int id,
  }) async {
    emit(LoadingDeleteItemData());
    db?.rawUpdate(
      'DELETE FROM $itemTable  WHERE id = ?',
      [id],
    ).then((value) {
      print("deleted successfully");
      emit(SuccessfullyDeleteItemData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorDeleteItemData());
    });
  }

  void deleteUserData({
    required int id,
  }) async {
    emit(LoadingDeleteUserData());
    db?.rawUpdate(
      'DELETE FROM $userTable  WHERE id = ?',
      [id],
    ).then((value) {
      emit(SuccessfullyDeleteUserData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorDeleteUserData());
    });
  }

  void login({required String email, required String password}) {
    emit(LoadingLogin());

    db?.rawQuery("SELECT * FROM $userTable WHERE password = ? AND email = ? ",
        [password, email]).then((value) {
      value.isEmpty ? emit(ErrorLogin()) : emit(SuccessfullyLogin());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLogin());
    });
  }


  void searchByIdFunction({required int id}) {
    searchById=[];

    db?.rawQuery("SELECT * FROM $itemTable WHERE id LIKE '%$id%' ").then((value) {
      // print(value[0]["id"]);
      value.forEach((element) {
        searchById.add(element);
      });
      emit(SuccessfullySearchById());

    }).catchError((error) {
      print("Error in search by ID");
      print(error.toString());
      emit(ErrorSearchById());
    });
  }

  void searchByNameFunction({required String name}) {
    searchByName=[];

    db?.rawQuery("SELECT * FROM $itemTable WHERE label LIKE '%$name%'" ).then((value) {
      // print(value[0]["id"]);
      value.forEach((element) {
        searchByName.add(element);

      });
      emit(SuccessfullySearchByName());
    }).catchError((error) {
      print("Error in search by name");
      print(error.toString());
      emit(ErrorSearchByName());
    });
  }
}
