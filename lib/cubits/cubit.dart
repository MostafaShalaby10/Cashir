import 'dart:typed_data';
import 'package:lastcashir/components/constants.dart';
import 'package:lastcashir/widgets/center_page.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:bloc/bloc.dart';
import 'package:pdf/pdf.dart' as pdf;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:lastcashir/main.dart';
import 'package:sqflite/sqflite.dart';




import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastcashir/components/constants.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';



class cubit extends Cubit<States> {
  cubit() : super(InitialState());

  static cubit get(context) => BlocProvider.of(context);
  Color? color;

  List<String> items = ["All items","Food", "Cold Drinks", "Hot Drinks", "Deserts"];
  List<IconData> icons = [
    Icons.category,
    Icons.fastfood_outlined,
    Icons.water_drop_outlined,
    Icons.water_drop_outlined,
    Icons.message
  ];
  List<dynamic> users = [];
  List<dynamic> orders = [];
  List<dynamic> food = [];
  List<dynamic> billList = [];
  List<dynamic> billSpecific = [];
  List<dynamic> detailsList = [];
  List<dynamic> dessert = [];
  List<dynamic> coldDrinks = [];
  List<dynamic> hotDrinks = [];
  List<dynamic> searchById = [];
  List<dynamic> searchByName = [];
  List<dynamic> list = [];

  double total = 0;

  void changeColor() {
    color = Colors.green;
  }

  List<List> bill = [];

  void addBill({required List list}) {
    bill.add(list);
    print("Bill is : $bill");
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
  String billTable = "bill";
  String detailsTable = "details";
  int versionCode = 1;

  Database? db;

  void createDb() async {
    emit(LoadingCreateDataBase());
    await openDatabase(dbName, version: versionCode,
        onCreate: (database, version) {
      database
          .execute(
              "create table $userTable (id integer primary key , name text , password text , email text ) ;"
              " create table $itemTable (id integer primary key , label text , category text , price double ) ;"
              "create table $billTable (id integer primary key , name text , total double , date text );"
              "create table $detailsTable (details_id integer , item text , quantity integer ,price double ,  FOREIGN KEY (details_id) REFERENCES $billTable(id) )")
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
    users = [];
    emit(LoadingGetUserData());
    db?.rawQuery("SELECT * FROM $userTable").then((value) {
      users.add(value);
      print(users);
      emit(SuccessfullyGetUserData());
    }).catchError((error) {
      print("Error in getData");
      print(error.toString());
      emit(ErrorGetUserData());
    });
  }

  void getItemData() {
    orders = [];
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
      list = orders;
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
      print("saddsasda");
      emit(SuccessfullyUpdateItemData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorUpdateItemData());
    });
  }

  void updateUserData({
    required int id,
    required String email,
    required String name,
    required String password,
  }) async {
    emit(LoadingUpdateUserData());

    db?.rawUpdate(
      'UPDATE $userTable SET name = ? , email = ? , password=? WHERE id = ?',
      ['$name', '$email', '$password', id],
    ).then((value) {
      print("update");
      getUserData();
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
      print("delete successfully");
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
      name = value[0]["name"].toString();
    }).catchError((error) {
      print(error.toString());
      emit(ErrorLogin());
    });
  }

  void searchByIdFunction({required int id}) {
    searchById = [];

    db
        ?.rawQuery("SELECT * FROM $itemTable WHERE id LIKE '%$id%' ")
        .then((value) {
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
    searchByName = [];

    db
        ?.rawQuery("SELECT * FROM $itemTable WHERE label LIKE '%$name%'")
        .then((value) {
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

  void createBill(
      {required String name,
      required double total,
      required String date}) async {
    emit(LoadingCreateBill());
    await db!.transaction((txn) async {
      await txn
          .rawInsert(
              "insert into $billTable (name , total , date ) values ('$name' ,  '$total' , '$date')")
          .then((value) {
        for (int i = 0; i < bill.length; i++) {
          createDetails(
              id: value,
              item: bill[i][0],
              quantity: bill[i][1],
              price: bill[i][2]);
        }
        getBillData();
        getDetailsData(id: value);

        print("create bill success");
        clearBill();
        emit(SuccessfullyCreateBill());
      }).catchError((error) {
        print("insert error");
        print(error.toString());
        emit(ErrorCreateBill());
      });
    });
  }

  // "create table $detailsTable (details_id integer , item text , quantity integer ,price double ,  FOREIGN KEY (details_id) REFERENCES $billTable(id) )")

  void createDetails(
      {required int id,
      required String item,
      required int quantity,
      required double price}) async {
    emit(LoadingCreateDetails());
    await db!.transaction((txn) async {
      await txn
          .rawInsert(
              "insert into $detailsTable (details_id , item , quantity , price ) values ('$id' ,  '$item' , '$quantity' , '$price')")
          .then((value) {
        print("create details success");
        emit(SuccessfullyCreateDetails());
      }).catchError((error) {
        print("details error");
        print(error.toString());
        emit(ErrorCreateDetails());
      });
    });
  }

  void getBillData() {
    billList = [];
    emit(LoadingGetBillData());
    print("dsajisadjisad");
    db?.rawQuery("SELECT * FROM $billTable").then((value) {
      print(value[value.length - 1]);
      billList.add(value);
      // print(billList);
      // print(billList.length);
      print(billList[0][billList[0].length - 1]);
      print(billList.length - 1);
      // getDetailsData();
      // showData();
      emit(SuccessfullyGetBillData());
    }).catchError((error) {
      print(error.toString());
      emit(ErrorGetBillData());
    });
  }

  void getDetailsData({required int id}) {
    detailsList = [];
    emit(LoadingGetDetailsData());
    db?.rawQuery("SELECT * FROM $detailsTable WHERE details_id = ?", [id]).then(
        (value) {
      print("details table : $value");
      detailsList.add(value);
      emit(SuccessfullyGetDetailsData());
    }).catchError((error) {
      print("Error in getData Details");
      print(error.toString());
      emit(ErrorGetDetailsData());
    });
  }


  void changeList({required List<dynamic> testlist}) {
    emit(LoadingChangeList());
    print(testlist);
    list = testlist;
    emit(SuccessfullyChangeList());
  }

  Future<Uint8List> generatePdf( PdfPageFormat format, String title) async {
    final pdf = pw.Document(version: PdfVersion.pdf_1_5, compress: true);
    final font = await PdfGoogleFonts.nunitoExtraLight();

    pdf.addPage(
      pw.Page(

        pageFormat: format,
        build: (context) {
          return pw.Container(
            width: double.infinity,
            child: pw.Column(

              crossAxisAlignment: pw.CrossAxisAlignment.center,
              children: [
                pw.Text(
                  'Name of Cafe',
                  style: pw.TextStyle(
                      fontWeight: pw.FontWeight.bold, fontSize: 50),

                ),
                pw.SizedBox(height: 8,),
                pw.Text(
                  '${billList[0][billList[0].length - 1]["date"].toString()}',
                  style: pw.TextStyle(
                      fontSize: 20),

                ),

                pw.SizedBox(height: 16,),
                pw.Padding(
                  padding: pw.EdgeInsets.all(10.0),
                  child: pw.Row(
                    children: [
                      pw.Text(
                        'Number of Receipt : ${detailsList[0][0]['details_id'].toString()}',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 20),

                      ),


                    ],
                  ),
                ),
                pw.Padding(
                  padding: pw.EdgeInsets.all(10.0),
                  child: pw.Row(
                    children: [
                      pw.Text(
                        'Cashier name : ${billList[0][billList[0].length - 1]["name"].toString()}',
                        style: pw.TextStyle(
                            fontWeight: pw.FontWeight.bold, fontSize: 20),

                      ),


                    ],
                  ),
                ),

                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(
                      vertical: 20, horizontal: 40),
                  child: pw.Row(
                    children: [
                      pw.Expanded(child: pw.Text('Name')),
                      pw.Expanded(child: pw.Text('Qantity')),
                      pw.Expanded(child: pw.Text('Price')),
                    ],
                  ),
                ),

                pw.Expanded(
                  child: pw.ListView.separated(
                      itemBuilder: (context, index) =>
                          pw.Padding(
                            padding:
                            pw.EdgeInsets.symmetric(
                                vertical: 20, horizontal: 40),
                            child: pw.Row(
                              children: [
                                pw.Expanded(
                                    child: pw.Text(
                                        '${detailsList[0][index]["item"]}')),
                                pw.Expanded(
                                    child: pw.Text(
                                        '${detailsList[0][index]["quantity"]
                                            .toString()}')),
                                pw.Expanded(
                                    child: pw.Text(
                                        '${detailsList[0][index]["price"]}')),
                              ],
                            ),
                          ),
                      separatorBuilder: (context, index) =>
                          pw.Container(
                            height: 1,
                          ),
                      itemCount: detailsList[0].length),
                ),


                pw.Padding(
                  padding: pw.EdgeInsets.symmetric(
                      horizontal: 40, vertical: 20),
                  child: pw.Row(
                    children: [
                      pw.Text('Total:', style: pw.TextStyle(
                          fontWeight: pw.FontWeight.bold, fontSize: 25),),
                      pw.SizedBox(width: 10,),
                      pw.Text('${billList[0][billList[0].length - 1]["total"].toString()}',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold,
                            fontSize: 25),),
                    ],
                  ),
                ),



              ]
              ,
            )
            ,
          );
        },
      ),
    );

    return pdf.save();
  }

}
