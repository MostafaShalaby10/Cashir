import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/pages/home_page.dart';


import '../components/custom_button.dart';
import '../widgets/center_page.dart';

class AddItem extends StatefulWidget {
  const AddItem({Key? key}) : super(key: key);

  @override
  State<AddItem> createState() => _AddItemState();
}

TextEditingController itemIDController = TextEditingController();
TextEditingController itemNameController = TextEditingController();
TextEditingController itemPriceController = TextEditingController();
bool foodValue = false ;
bool dessertValue = false ;
bool coldDrinkValue = false ;
bool hotDrinkValue = false ;

class _AddItemState extends State<AddItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: (){
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>const HomePage()), (route) => false);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new
            ),
          ),
          elevation: 0,
          title: const Text("Add Item"),
          backgroundColor: HexColor('#549AAB')),
      body: Row(
        children: [
          LeftPage(context , allItems: false),
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
                        "item ID",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      textField(
                          text: "Type item id",
                          prefixIcon: Icons.add,
                          controller: itemIDController,
                          type: TextInputType.number,
                          raduis: 10),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "item Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      textField(
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
                      textField(
                          text: "Type item price",
                          prefixIcon: Icons.add,
                          controller: itemPriceController,
                          type: TextInputType.number,
                          raduis: 10),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "item ID",
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
                              child: checkBoxItem(function: (value){
                                setState(() {
                                  foodValue = value!;
                                  if(foodValue)
                                  {
                                    coldDrinkValue = false ;
                                    hotDrinkValue = false ;
                                    dessertValue = false ;
                                  }
                                });
                              }, text: "Food", value: foodValue),
                            ),
                            Expanded(
                              child: checkBoxItem(function: (value){
                                setState(() {
                                  dessertValue = value!;
                                  if(dessertValue)
                                  {
                                    coldDrinkValue = false ;
                                    hotDrinkValue = false ;
                                    foodValue = false ;
                                  }
                                });
                              }, text: "Dessert", value: dessertValue),
                            ),
                            Expanded(
                              child: checkBoxItem(function: (value){
                                setState(() {
                                  coldDrinkValue = value!;
                                  if(coldDrinkValue)
                                  {
                                    hotDrinkValue = false ;
                                    dessertValue = false ;
                                    foodValue = false ;
                                  }
                                });
                              }, text: "Cold Drinks", value: coldDrinkValue),
                            ),
                            Expanded(
                              child: checkBoxItem(function: (value){
                                setState(() {
                                  hotDrinkValue = value!;
                                  if(hotDrinkValue)
                                    {
                                      coldDrinkValue = false ;
                                      dessertValue = false ;
                                      foodValue = false ;
                                    }
                                });
                              }, text: "Hot Drinks", value: hotDrinkValue),
                            ),

                          ],
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Center(
                        child: button(
                            context: context,
                            text: "ADD item",
                            color: HexColor("#123740"),
                            minWidth: MediaQuery.of(context).size.width / 6,
                            height: MediaQuery.of(context).size.height / 12  ,
                            function: (){}),
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
  }
}
