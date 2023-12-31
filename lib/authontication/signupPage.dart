import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/authontication/loginPage.dart';
import 'package:lastcashir/components/constants.dart';
import 'package:lastcashir/components/custom_button.dart';
import 'package:lastcashir/cubits/cubit.dart';
import 'package:lastcashir/cubits/states.dart';
import 'package:lastcashir/pages/admin/adminhomepage.dart';
import 'package:lastcashir/pages/admin/allusers.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController confPassController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isPassword = true;
  bool isConfPassword = true;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<cubit, States>(builder: (context, state) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: IconButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) =>const AllUsers()),
                  (route) => false);
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
          elevation: 0,
          title: const Text("Add user"),
          backgroundColor: primaryColor,
        ),
        backgroundColor: Colors.grey[300],
        body: SafeArea(
          child: Center(
            child: Container(
              width: MediaQuery.of(context).size.width / 4,
              height: MediaQuery.of(context).size.height / 1.3,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15), color: Colors.white),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "User Signup",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 25),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      textField(context,
                          text: "Name",
                          prefixIcon: Icons.person_outline,
                          controller: nameController,
                          type: TextInputType.name),
                      const SizedBox(
                        height: 25,
                      ),
                      textField(context,
                          text: "E-mail",
                          prefixIcon: Icons.email,
                          controller: emailController,
                          type: TextInputType.emailAddress),
                      const SizedBox(
                        height: 25,
                      ),
                      textField(context,
                          text: "Password",
                          prefixIcon: Icons.lock_outline,
                          controller: passController,
                          type: TextInputType.visiblePassword,
                          isPass: isPassword,
                          suffixIcon: isPassword
                              ? Icons.visibility
                              : Icons.visibility_off, function: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      }),
                      const SizedBox(
                        height: 25,
                      ),
                      textField(context,
                          text: "CONF-Password",
                          prefixIcon: Icons.lock_outline,
                          controller: confPassController,
                          type: TextInputType.visiblePassword,
                          isPass: isConfPassword,
                          suffixIcon: isConfPassword
                              ? Icons.visibility
                              : Icons.visibility_off, function: () {
                        setState(() {
                          isConfPassword = !isConfPassword;
                        });
                      }),
                      const SizedBox(
                        height: 20,
                      ),
                      ConditionalBuilder(
                          condition: state is! LoadingInsertUserData,
                          builder: (context) => button(
                              context: context,
                              text: "Signup",
                              color: primaryColor,
                              minWidth: MediaQuery.of(context).size.width / 2,
                              height: MediaQuery.of(context).size.height / 12,
                              function: () {
                                if (formKey.currentState!.validate()) {
                                  if (passController.text.length >= 6 &&
                                      (passController.text ==
                                          confPassController.text)) {
                                    cubit.get(context).insertUserData(
                                        name: nameController.text,
                                        email: emailController.text,
                                        password: passController.text);
                                  } else {
                                    Fluttertoast.showToast(
                                        msg: "Check your Passwords",
                                        backgroundColor: Colors.red,
                                        toastLength: Toast.LENGTH_SHORT,
                                        textColor: Colors.white,
                                        gravity: ToastGravity.BOTTOM,
                                        timeInSecForIosWeb: 1);
                                  }
                                }
                              }),
                          fallback: (context) =>
                              const Center(child: CircularProgressIndicator())),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }, listener: (context, state) {
      if (state is SuccessfullyInsertUserData) {
        Fluttertoast.showToast(
            msg: "Created account successfully",
            backgroundColor: Colors.green,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);

        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const AdminHomePage()),
            (route) => false);
      } else if (state is ErrorInsertUserData) {
        Fluttertoast.showToast(
            msg: "Created account failed",
            backgroundColor: Colors.red,
            toastLength: Toast.LENGTH_SHORT,
            textColor: Colors.white,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1);
      }
    });
  }
}
