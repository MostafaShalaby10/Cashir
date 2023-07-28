import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:lastcashir/pages/all_items.dart';

import '../components/custom_button.dart';
import '../widgets/center_page.dart';
import 'home_page.dart';

class Update extends StatefulWidget {
  final String name;

  final String price;

  final int id;

  const Update(
      {Key? key, required this.name, required this.price, required this.id})
      : super(key: key);

  @override
  State<Update> createState() => _UpdateState();
}

TextEditingController itemNameController = TextEditingController();
TextEditingController itemPriceController = TextEditingController();
bool foodValue = false;

bool dessertValue = false;

bool coldDrinkValue = false;

bool hotDrinkValue = false;
String? category;

class _UpdateState extends State<Update> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, States>(builder: (context, state) {
      itemNameController.text = widget.name;
      itemPriceController.text = widget.price;

      return Scaffold(
        appBar: AppBar(
            automaticallyImplyLeading: false,
            leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const AllItems()),
                    (route) => false);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
            elevation: 0,
            title: const Text("Update Page"),
            backgroundColor: HexColor('#549AAB')),
        body: Row(
          children: [
            Expanded(
              flex: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 1.5,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "item Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        textField(context,
                            text: "Type item name",
                            prefixIcon: Icons.add,
                            controller: itemNameController,
                            type: TextInputType.number,
                            raduis: 10),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "item price",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        textField(context,
                            text: "Type item price",
                            prefixIcon: Icons.add,
                            controller: itemPriceController,
                            type: TextInputType.number,
                            raduis: 10),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "item Category",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.black)),
                          child: Row(
                            children: [
                              Expanded(
                                child: checkBoxItem(
                                    function: (value) {
                                      setState(() {
                                        foodValue = value!;
                                        category = "food";
                                        if (foodValue) {
                                          coldDrinkValue = false;
                                          hotDrinkValue = false;
                                          dessertValue = false;
                                        }
                                      });
                                    },
                                    text: "Food",
                                    value: foodValue),
                              ),
                              Expanded(
                                child: checkBoxItem(
                                    function: (value) {
                                      setState(() {
                                        dessertValue = value!;
                                        category = "dessert";
                                        if (dessertValue) {
                                          coldDrinkValue = false;
                                          hotDrinkValue = false;
                                          foodValue = false;
                                        }
                                      });
                                    },
                                    text: "Dessert",
                                    value: dessertValue),
                              ),
                              Expanded(
                                child: checkBoxItem(
                                    function: (value) {
                                      setState(() {
                                        coldDrinkValue = value!;
                                        category = "cold drink";

                                        if (coldDrinkValue) {
                                          hotDrinkValue = false;
                                          dessertValue = false;
                                          foodValue = false;
                                        }
                                      });
                                    },
                                    text: "Cold Drinks",
                                    value: coldDrinkValue),
                              ),
                              Expanded(
                                child: checkBoxItem(
                                    function: (value) {
                                      setState(() {
                                        hotDrinkValue = value!;
                                        category = "hot drink";

                                        if (hotDrinkValue) {
                                          coldDrinkValue = false;
                                          dessertValue = false;
                                          foodValue = false;
                                        }
                                      });
                                    },
                                    text: "Hot Drinks",
                                    value: hotDrinkValue),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: button(
                              context: context,
                              text: "Update item",
                              color: HexColor("#123740"),
                              minWidth: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.height / 12,
                              function: () {
                                print(widget.id);
                                cubit.get(context).updateItemData(
                                    id: widget.id,
                                    price:
                                        double.parse(itemPriceController.text),
                                    name: itemNameController.text,
                                    category: category.toString());
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }, listener: (context, state) {
      if (state is SuccessfullyUpdateItemData) {
        cubit.get(context).getItemData();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AllItems()),
            (route) => false);
      }
    });
  }
}
