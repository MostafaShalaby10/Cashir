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
TextEditingController itemnameController = TextEditingController();
TextEditingController itempriceController = TextEditingController();
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
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomePage()), (route) => false);
            },
            icon: Icon(
              Icons.arrow_back_ios_new
            ),
          ),
          elevation: 0,
          title: Text("Add Item"),
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
                      Text(
                        "item ID",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      textField(
                          text: "Type item id",
                          prefixIcon: Icons.add,
                          controller: itemIDController,
                          type: TextInputType.number,
                          raduis: 10),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "item Name",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      textField(
                          text: "Type item name",
                          prefixIcon: Icons.add,
                          controller: itemnameController,
                          type: TextInputType.number,
                          raduis: 10),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "item price",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      textField(
                          text: "Type item price",
                          prefixIcon: Icons.add,
                          controller: itempriceController,
                          type: TextInputType.number,
                          raduis: 10),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "item ID",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 17),
                      ),
                      SizedBox(
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
                                });
                              }, text: "Food", value: foodValue),
                            ),
                            Expanded(
                              child: checkBoxItem(function: (value){
                                setState(() {
                                  dessertValue = value!;
                                });
                              }, text: "Dessert", value: dessertValue),
                            ),
                            Expanded(
                              child: checkBoxItem(function: (value){
                                setState(() {
                                  coldDrinkValue = value!;
                                });
                              }, text: "Cold Drinks", value: coldDrinkValue),
                            ),
                            Expanded(
                              child: checkBoxItem(function: (value){
                                setState(() {
                                  hotDrinkValue = value!;
                                });
                              }, text: "Hot Drinks", value: hotDrinkValue),
                            ),

                          ],
                        ),
                      ),
                      SizedBox(height: 20,),
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
