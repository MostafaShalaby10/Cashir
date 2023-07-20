import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/components/custom_button.dart';
import 'package:lastcashir/pages/home_page.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  void initState() {
    super.initState();
  }

  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  bool isPassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Container (
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 2,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "User Login",
                    style:
                        TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  textField(
                      text: "E-mail",
                      prefixIcon: Icons.email,
                      controller: emailController,
                      type: TextInputType.emailAddress),
                  const SizedBox(
                    height: 15,
                  ),
                  textField(
                      text: "Password",
                      prefixIcon: Icons.lock_outline,
                      controller: passController,
                      type: TextInputType.visiblePassword,
                      isPass: isPassword,
                      suffixIcon: isPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      function: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  button(
                      context: context,
                      text: "Login",
                      color: HexColor('#549AAB'),
                      minWidth: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 12,
                      function: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => HomePage()),
                                (route) => false);
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
