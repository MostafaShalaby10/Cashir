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

Widget CenterPage(context, {required bool allItem}) {
  TextEditingController searchByID = TextEditingController();
  TextEditingController searchByName = TextEditingController();
  return Expanded(
    flex: 6,
    child: Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
          child: Row(
            children: [
              Expanded(
                flex : 1 ,
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
                  child: Row(
                    children: [
                      Expanded(child: text(text: 'Id', color: Colors.black)),
                      Expanded(child: text(text: 'Id', color: Colors.black)),
                      Expanded(child: text(text: 'Id', color: Colors.black)),
                      Expanded(child: text(text: 'Id', color: Colors.black)),
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
                );
              },
              separatorBuilder: (context, index) {
                return Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.black,
                );
              },
              itemCount: 50,
            ),
          ),
        ),
      ],
    ),
  );
}

Widget LeftPage(context, {required bool allItems}) {
  if (allItems == false)
    return Expanded(
      flex: 1,
      child: Container(
        color: HexColor('#549AAB'),
        child: Padding(
          padding: const EdgeInsets.only(top: 30, left: 20),
          child: ListView.separated(
            itemBuilder: (context, index) => InkWell(
              onTap: () {
                if (index == 0)
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return AllItems();
                  }));
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
                      function: () {}),
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
                                  cubit.get(context).orders[index],
                                  textAlign: TextAlign.center,
                                )),
                                Expanded(
                                  child: Text(
                                    "${cubit.get(context).quantity[index]}",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  "${cubit.get(context).cost[index]}",
                                  textAlign: TextAlign.center,
                                )),
                                Expanded(
                                  child: IconButton(
                                    color: Colors.red,
                                    onPressed: () {},
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
                      itemCount: cubit.get(context).orders.length),
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
                        style:
                            TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "198",
                        style:
                            TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      children: [
                        calculatorNumber(number: '1'),
                        calculatorNumber(number: '2'),
                        calculatorNumber(number: '3'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        calculatorNumber(number: '4'),
                        calculatorNumber(number: '5'),
                        calculatorNumber(number: '6'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      children: [
                        calculatorNumber(number: '7'),
                        calculatorNumber(number: '8'),
                        calculatorNumber(number: '9'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        calculatorNumber(number: '0'),
                      ],
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
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
                    function: () {}),
              ),
            ],
          ),
        )),
  );
}
