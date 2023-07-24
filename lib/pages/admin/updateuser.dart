import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/pages/admin/allusers.dart';

import '../../components/custom_button.dart';
import '../../cubits/cubit.dart';
import '../../cubits/states.dart';
import '../../widgets/center_page.dart';
import '../add_item_page.dart';
import '../all_items.dart';

class UpdateUser extends StatelessWidget {
  final String name;

  final String password;

  final String email;
  final String id;

  const UpdateUser(
      {Key? key,
      required this.name,
      required this.password,
      required this.email,
      required this.id})
      : super(key: key);

  @override
  Widget build(BuildContext context) {


    TextEditingController userNameController = TextEditingController();
    TextEditingController userPasswordController = TextEditingController();
    TextEditingController userEmailController = TextEditingController();



    return BlocConsumer<cubit, States>(builder: (context, state) {
      userPasswordController.text = password;
      userEmailController.text = email;
      userNameController.text = name;
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
            leftPage(context, allItems: false, users: false),
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
                          "User Name",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        textField(context,
                            text: "Type User name",
                            prefixIcon: Icons.add,
                            controller: userNameController,
                            type: TextInputType.number,
                            raduis: 10),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "User email",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        textField(context,
                            text: "Type User email",
                            prefixIcon: Icons.add,
                            controller: userEmailController,
                            type: TextInputType.number,
                            raduis: 10),
                        const SizedBox(
                          height: 10,
                        ),
                        const Text(
                          "User Password",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 17),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        textField(context,
                            text: "Type User password",
                            prefixIcon: Icons.add,
                            controller: userPasswordController,
                            type: TextInputType.number,
                            raduis: 10),
                        const SizedBox(
                          height: 20,
                        ),
                        Center(
                          child: button(
                              context: context,
                              text: "Update user",
                              color: HexColor("#123740"),
                              minWidth: MediaQuery.of(context).size.width / 6,
                              height: MediaQuery.of(context).size.height / 12,
                              function: () {
                                cubit.get(context).updateUserData(
                                    id: int.parse(id),
                                    email: userEmailController.text,
                                    name: userNameController.text,
                                    password: userPasswordController.text);
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
      if (state is SuccessfullyUpdateUserData) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>const AllUsers()));
      }
    });
  }
}
