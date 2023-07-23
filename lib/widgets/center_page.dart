import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/pages/add_item_page.dart';
import 'package:lastcashir/pages/update_page.dart';

import '../components/custom_button.dart';
import '../pages/all_items.dart';
import '../pages/cold_drink_page.dart';
import '../pages/desert_page.dart';
import '../pages/food_page.dart';
import '../pages/hot_drink_page.dart';

Widget CenterPage(
  context, {
  required bool allItem,
  required GlobalKey<ScaffoldState> scaffoldKey,
}) {
  TextEditingController controller = TextEditingController();
  TextEditingController searchByID = TextEditingController();
  TextEditingController searchByName = TextEditingController();
  var formKey = GlobalKey<FormState>();

  return Expanded(
    flex: 6,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Row(
            children: [
              Expanded(
                flex: 1,
                child: textField(
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
                    text: 'Search by name',
                    prefixIcon: Icons.search,
                    controller: searchByName,
                    type: TextInputType.name),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16),
            color: HexColor('#123740'),
            child: Row(
              children: [
                Expanded(child: text(text: 'ID', color: Colors.white)),
                Expanded(child: text(text: 'Name', color: Colors.white)),
                Expanded(child: text(text: 'Category', color: Colors.white)),
                Expanded(child: text(text: 'Price', color: Colors.white)),
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
                  child: InkWell(
                    onTap: () {
                      if (!allItem) {
                        cubit.get(context).addBill(list: [
                          cubit.get(context).orders[index]['label'],
                          1,
                          cubit.get(context).orders[index]["price"]
                        ]);
                      }
                    },
                    onDoubleTap: () {
                      if (!allItem) {
                        scaffoldKey.currentState!.showBottomSheet((context) {
                          return Center(
                            child: Container(
                              width: MediaQuery.of(context).size.width ,
                              height: MediaQuery.of(context).size.height / 2,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25) ,
                                border: Border.all(color: Colors.black)
                              ),
                              ///////////////////////////////////////////////////////////////////////////////////////////////////////////
                              child: Form(
                                key: formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ////////////////////////
                                    Row(
                                      children: [
                                        Text(
                                          "Name : ",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 17,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          cubit.get(context).orders[index]['label'],
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Quantity : ",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 17,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: textField(
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
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "price : ",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 17,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          " ${cubit.get(context).orders[index]["price"]}",
                                          style: TextStyle(
                                            color: Colors.green,
                                            fontSize: 17,
                                          ),
                                        ),
                                      ],
                                    ),
                                    Container(
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
                                          SizedBox(
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
                                          SizedBox(
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
                                          SizedBox(
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
                                          SizedBox(
                                            height: 30,
                                          ),
                                          button(
                                              context: context,
                                              text: "Order",
                                              color: HexColor("#549AAB"),
                                              minWidth: 50,
                                              height: 50,
                                              function: () {
                                                if (formKey.currentState!
                                                    .validate()) {
                                                  cubit
                                                      .get(context)
                                                      .addBill(list: [
                                                    cubit
                                                        .get(context)
                                                        .orders[index]["label"],
                                                    controller.text,
                                                    (int.parse(controller.text) *
                                                        cubit
                                                            .get(context)
                                                            .orders[index]["price"])
                                                  ]);
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
                      }
                    },
                    child: Row(
                      children: [
                        Expanded(child: text(text: cubit.get(context).orders[index]["id"].toString(), color: Colors.black)),
                        Expanded(child: text(text: cubit.get(context).orders[index]["label"], color: Colors.black)),
                        Expanded(child: text(text: cubit.get(context).orders[index]["category"], color: Colors.black)),
                        Expanded(child: text(text: cubit.get(context).orders[index]["price"].toString(), color: Colors.black)),
                        if (allItem)
                          Expanded(
                            child: IconButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Update()));
                                },
                                icon: Icon(Icons.edit)),
                          ),
                        if (allItem)
                          Expanded(
                            child: IconButton(
                                onPressed: () {}, icon: Icon(Icons.delete)),
                          ),
                      ],
                    ),
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
              itemCount: cubit.get(context).orders.length,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget LeftPage(context, {required bool allItems}) {
  if (allItems == false) {
    return Expanded(
      flex: 1,
      child: Container(
        color: HexColor('#549AAB'),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20),
          child: ListView.separated(

            itemBuilder: (context, index) => InkWell(
              onTap: () {
                if (index == 0) {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AllItems();
                  }));
                }
                if (index == 1)
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return FoodPage();
                  }));
                if (index == 2)
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ColdDrink();
                  }));
                if (index == 3)
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return HotDrink();
                  }));
                if (index == 4)
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Desertpage();
                  }));
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
                    style: TextStyle(color: Colors.white),
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
  return Expanded(
    flex: 1,
    child: Container(
      color: HexColor('#549AAB'),
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 20),
        child: InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => AddItem()));
            },
            child: Container(
              height: MediaQuery.of(context).size.height,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.add),
                  const SizedBox(
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

Widget RightPage(context) {
  return Expanded(
    flex: 2,
    child: Padding(
        padding: EdgeInsets.only(top: 30, left: 20, right: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Current order",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Spacer(),
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
              SizedBox(
                height: 30,
              ),
              Container(
                color: Colors.grey[300],
                height: 40,
                child: Row(
                  children: [
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
              Container(
                height: 250,
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
                                    icon: Icon(Icons.remove),
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
                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                  color: Colors.grey[300],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Total ",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${cubit.get(context).total.toStringAsFixed(2)} ",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: button(
                    context: context,
                    text: "Pay",
                    color: HexColor('#549AAB'),
                    minWidth: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 12,
                    function: () {
                      cubit.get(context).total = 0;
                      cubit.get(context).clearBill();
                    }),
              ),
            ],
          ),
        )),
  );
}
