import 'package:flutter/material.dart';
import 'package:lastcashir/components/constants.dart';
import 'package:lastcashir/components/custom_button.dart';
import 'package:lastcashir/pages/home_page.dart';

class Tables extends StatelessWidget {
  const Tables({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView.builder(
            itemCount: 20,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 5,
                childAspectRatio: 1.5,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10),
            itemBuilder: (context, index) {
              index = index + 1;
              return MaterialButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage(tableNum: index,)));
                },
                color: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child:text(text: "$index", color: Colors.white)
              );
            }),
      ),
    ));
  }
}
