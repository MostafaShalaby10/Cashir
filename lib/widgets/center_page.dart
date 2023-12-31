import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import 'package:lastcashir/authontication/signupPage.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/main.dart';
import 'package:lastcashir/pages/add_item_page.dart';
import 'package:lastcashir/pages/admin/updateuser.dart';
import 'package:lastcashir/pages/fatora.dart';
import 'package:lastcashir/pages/home_page.dart';
import 'package:lastcashir/pages/update_page.dart';

import '../components/constants.dart';
import '../components/custom_button.dart';
import '../pages/all_items.dart';

import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lastcashir/components/constants.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

Widget centerPage(
  context, {
  required bool allItem,
  required List<dynamic> list,
  required bool users,
}) {
  TextEditingController controller = TextEditingController();

  var formKey = GlobalKey<FormState>();
  if (users == true) {
    return Expanded(
      flex: 6,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              color: primaryColor,
              child: Row(
                children: [
                  Expanded(child: text(text: 'ID', color: Colors.white)),
                  Expanded(child: text(text: 'Name', color: Colors.white)),
                  Expanded(child: text(text: 'email', color: Colors.white)),
                  Expanded(child: text(text: 'password', color: Colors.white)),
                  if (allItem)
                    Expanded(child: text(text: 'Edit', color: Colors.white)),
                  if (allItem)
                    Expanded(child: text(text: 'Delete', color: Colors.white)),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Expanded(
                            child: text(
                                text: list[0][index]["id"].toString(),
                                color: Colors.black)),
                        Expanded(
                            child: text(
                                text: list[0][index]["name"],
                                color: Colors.black)),
                        Expanded(
                            child: text(
                                text: list[0][index]["email"],
                                color: Colors.black)),
                        Expanded(
                            child: text(
                                text: list[0][index]["password"],
                                color: Colors.black)),
                        if (allItem)
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateUser(
                                        id: list[0][index]["id"].toString(),
                                        name: list[0][index]["name"],
                                        password: list[0][index]["password"],
                                        email: list[0][index]["email"],
                                      ),
                                    ),
                                  );
                                },
                                icon: const Icon(Icons.edit)),
                          ),
                        if (allItem)
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  cubit
                                      .get(context)
                                      .deleteUserData(id: list[0][index]["id"]);
                                  cubit.get(context).getUserData();
                                },
                                icon: const Icon(Icons.delete)),
                          ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) {
                  return Container(
                    height: 1,
                    width: double.infinity,
                    color: Colors.black,
                  );
                },
                itemCount: list[0].length,
              ),
            ),
          ),
        ],
      ),
    );
  }
  return Expanded(
    flex: 6,
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        itemCount: list.length,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 4,
            childAspectRatio: 4 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              if(!allItem)
                cubit.get(context).addBill(
                  list: [list[index]['label'], 1, list[index]["price"]]);
            },
            onDoubleTap: ()
            {
              showModalBottomSheet(context: context, builder: (context){
               return Container(
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height / 2,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black)),
                        ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                        child: Form(
                          key: formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ////////////////////////
                                Row(
                                  children: [
                                    const Text(
                                      "Name : ",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      list[index]['label'],
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Quantity : ",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: textField(context,
                                          text: "Enter quantity",
                                          prefixIcon: Icons.numbers,
                                          controller: controller,
                                          type: TextInputType.number,
                                          suffixIcon: Icons.cancel,
                                          function: () {
                                        controller.clear();
                                      }),
                                    )
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "price : ",
                                      style: TextStyle(
                                        color: Colors.green,
                                        fontSize: 17,
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      " ${list[index]["price"]}",
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          calculatorNumber(context,
                                              controller: controller,
                                              number: '1'),
                                          calculatorNumber(context,
                                              controller: controller,
                                              number: '2'),
                                          calculatorNumber(context,
                                              controller: controller,
                                              number: '3'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          calculatorNumber(context,
                                              controller: controller,
                                              number: '4'),
                                          calculatorNumber(context,
                                              controller: controller,
                                              number: '5'),
                                          calculatorNumber(context,
                                              controller: controller,
                                              number: '6'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        children: [
                                          calculatorNumber(context,
                                              controller: controller,
                                              number: '7'),
                                          calculatorNumber(context,
                                              controller: controller,
                                              number: '8'),
                                          calculatorNumber(context,
                                              controller: controller,
                                              number: '9'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          calculatorNumber(context,
                                              controller: controller,
                                              number: '0'),
                                        ],
                                      ),
                                      const SizedBox(
                                        height: 30,
                                      ),
                                      button(
                                          context: context,
                                          text: "Order",
                                          color: primaryColor,
                                          minWidth: 50,
                                          height: 50,
                                          function: () {
                                            if (formKey.currentState!
                                                .validate()) {
                                              cubit
                                                  .get(context)
                                                  .addBill(list: [
                                                list[index]["label"],
                                                int.parse(controller.text),
                                                (int.parse(controller.text) *
                                                    list[index]["price"])
                                              ]);
                                              Navigator.pop(context);
                                            }
                                          })
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
              });
            },
            child: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                final double fontSize = constraints.maxWidth * 0.07;
                final double fontSizeBigger = constraints.maxWidth * 0.09;
                final double paddingValue = constraints.maxWidth * 0.04;
                final double dividerPadding = constraints.maxWidth * 0.02;

                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Card(
                    color: Colors.white,
                    elevation: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        text(
                            text: list[index]["id"].toString(),
                            color: Colors.black),
                        Padding(
                          padding:
                              EdgeInsets.symmetric(vertical: dividerPadding),
                          child: const Divider(
                            height: 0,
                            color: Colors.grey,
                            thickness: 1,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding:
                                EdgeInsets.symmetric(horizontal: paddingValue),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text(
                                    text: list[index]["label"],
                                    color: Colors.black),
                                Expanded(
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      text(
                                          text: list[index]["category"],
                                          color: Colors.black),
                                      text(
                                          text: list[index]["price"].toString(),
                                          color: Colors.black),
                                    ],
                                  ),
                                ),
                                if (allItem)
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Update(
                                                      price: list[index]["price"]
                                                          .toString(),
                                                      name: list[index]["label"],
                                                      id: list[index]["id"],
                                                    )));
                                          },
                                          icon: Icon(Icons.edit)),
                                      IconButton(
                                          onPressed: () {
                                            showDialog(
                                                context: context,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    title: text(
                                                        text:
                                                            "Are you sure to delete ${list[index]["label"]}",
                                                        color: Colors.black),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            cubit
                                                                .get(context)
                                                                .deleteItemData(id: list[index]["id"]);
                                                            cubit.get(context).getItemData();
                                                            Navigator.pop(context);
                                                          },
                                                          child: text(
                                                              text: "Yes",
                                                              color:
                                                                  Colors.red)),
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: text(
                                                              text: "No",
                                                              color: Colors
                                                                  .black)),
                                                    ],
                                                  );
                                                });
                                          },
                                          icon: Icon(
                                            Icons.delete,
                                            color: Colors.red,
                                          )),
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    ),
  );
}

Widget leftPage(context, {required bool allItems, required bool users}) {
  if (allItems == false) {
    return Expanded(
      flex: 1,
      child: Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20),
          child: ListView.separated(
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                if (index == 0) {

                  cubit.get(context).changeList( testlist: cubit.get(context).orders);
                }
                if (index == 1) {

                  cubit.get(context).changeList( testlist: cubit.get(context).food);
                }
                if (index == 2) {
                  cubit.get(context).changeList( testlist: cubit.get(context).coldDrinks);

                }
                if (index == 3) {
                  cubit.get(context).changeList( testlist: cubit.get(context).hotDrinks);

                }
                if (index == 4) {
                  cubit.get(context).changeList( testlist: cubit.get(context).dessert);

                }
              },
              child: Row(
                children: [
                  Icon(
                    cubit.get(context).icons[index],
                    color: Colors.white,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    cubit.get(context).items[index],
                    style: const TextStyle(color: Colors.white),
                  )
                ],
              ),
            ),
            separatorBuilder: (context, index) => const SizedBox(
              height: 20,
            ),
            itemCount: cubit.get(context).items.length,
          ),
        ),
      ),
    );
  }
  if (users == true) {
    return Expanded(
      flex: 1,
      child: Container(
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20),
          child: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const SignUp()));
              },
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Icon(Icons.add),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      "Add users",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              )),
        ),
      ),
    );
  }
  return Expanded(
    flex: 1,
    child: Container(
      color: primaryColor,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20),
        child: InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddItem()));
            },
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Icon(Icons.add),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Add items",
                    style: TextStyle(color: Colors.white),
                  )
                ],
              ),
            )),
      ),
    ),
  );
}

Widget rightPage(context) {
  return Expanded(
    flex: 2,
    child: Padding(
        padding: const EdgeInsets.only(bottom: 0, left: 20, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    "Current order",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  button(
                      context: context,
                      text: "Clear all",
                      color: Colors.pink[300],
                      minWidth: MediaQuery.of(context).size.width / 14,
                      height: MediaQuery.of(context).size.height / 20,
                      function: () {
                        cubit.get(context).clearBill();
                      }),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                color: Colors.grey[300],
                height: 40,
                child: Row(
                  children: const [
                    Expanded(
                        child: Text(
                      "Item",
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      "QTY",
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      "Cost",
                      textAlign: TextAlign.center,
                    )),
                    Expanded(
                        child: Text(
                      " ",
                      textAlign: TextAlign.center,
                    )),
                  ],
                ),
              ),
              SizedBox(
                height: 450,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  cubit.get(context).bill[index][0],
                                  textAlign: TextAlign.center,
                                )),
                                Expanded(
                                  child: Text(
                                    "${cubit.get(context).bill[index][1]}",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  "${cubit.get(context).bill[index][2]}",
                                  textAlign: TextAlign.center,
                                )),
                                Expanded(
                                  child: IconButton(
                                    color: Colors.red,
                                    onPressed: () {
                                      cubit
                                          .get(context)
                                          .removeBillItem(index: index);
                                    },
                                    icon: const Icon(Icons.remove),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      separatorBuilder: (context, index) => Container(
                            width: double.infinity,
                            height: 1,
                            color: Colors.black,
                          ),
                      itemCount: cubit.get(context).bill.length),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 3),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Total ",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${cubit.get(context).total.toStringAsFixed(2)} ",
                        style: const TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: button(
                    context: context,
                    text: "Pay",
                    color: primaryColor,
                    minWidth: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 12,
                    function: () {
                      if (cubit.get(context).bill.isNotEmpty) {
                        cubit.get(context).createBill(
                            name: name.toString(),
                            total: cubit.get(context).total,
                            date:
                                "${DateFormat.yMMMd().format(DateTime.now())} ${TimeOfDay.now().format(context).toString()}");
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => FatoraDesign()));
                        cubit.get(context).total = 0;
                      } else {
                        print("Empty");
                      }
                      // cubit.get(context).clearBill();
                    }),
              ),
            ],
          ),
        )),
  );
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
                '${cubit
                    .get(context)
                    .billList[0][cubit
                    .get(context)
                    .billList[0].length - 1]["date"].toString()}',
                style: pw.TextStyle(
                    fontSize: 20),

              ),

              pw.SizedBox(height: 16,),
              pw.Padding(
                padding: pw.EdgeInsets.all(10.0),
                child: pw.Row(
                  children: [
                    pw.Text(
                      'Number of Receipt : ${cubit
                          .get(context)
                          .detailsList[0][0]['details_id'].toString()}',
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
                      'Cashier name : ${cubit
                          .get(context)
                          .billList[0][cubit
                          .get(context)
                          .billList[0].length - 1]["name"].toString()}',
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
                    pw.Expanded(child: pw.Text('Id')),
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
                                      '${cubit
                                          .get(context)
                                          .detailsList[0][index]["item"]}')),
                              pw.Expanded(
                                  child: pw.Text(
                                      '${cubit
                                          .get(context)
                                          .detailsList[0][index]["quantity"]
                                          .toString()}')),
                              pw.Expanded(
                                  child: pw.Text(
                                      '${cubit
                                          .get(context)
                                          .detailsList[0][index]["price"]}')),
                            ],
                          ),
                        ),
                    separatorBuilder: (context, index) =>
                        pw.Container(
                          height: 1,
                        ),
                    itemCount: cubit
                        .get(context)
                        .detailsList[0].length),
              ),


              pw.Padding(
                padding: pw.EdgeInsets.symmetric(
                    horizontal: 40, vertical: 20),
                child: pw.Row(
                  children: [
                    pw.Text('Total:', style: pw.TextStyle(
                        fontWeight: pw.FontWeight.bold, fontSize: 25),),
                    pw.SizedBox(width: 10,),
                    pw.Text('${cubit
                        .get(context)
                        .billList[0][cubit
                        .get(context)
                        .billList[0].length - 1]["total"].toString()}',
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
