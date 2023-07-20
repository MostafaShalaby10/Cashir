import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:lastcashir/authontication/loginPage.dart';
import 'package:lastcashir/components/custom_button.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Container(
            width: MediaQuery.of(context).size.width / 4,
            height: MediaQuery.of(context).size.height / 1.6,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15), color: Colors.white),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "User Signup",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 25),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  textField(
                      text: "Name",
                      prefixIcon: Icons.person_outline,
                      controller: nameController,
                      type: TextInputType.name),
                  const SizedBox(
                    height: 25,
                  ),
                  textField(
                      text: "E-mail",
                      prefixIcon: Icons.email,
                      controller: emailController,
                      type: TextInputType.emailAddress),
                  const SizedBox(
                    height: 25,
                  ),
                  textField(
                      text: "Password",
                      prefixIcon: Icons.lock_outline,
                      controller: passController,
                      type: TextInputType.visiblePassword,
                      isPass: isPassword,
                      suffixIcon:
                          isPassword ? Icons.visibility : Icons.visibility_off,
                      function: () {
                        setState(() {
                          isPassword = !isPassword;
                        });
                      }),
                  const SizedBox(
                    height: 25,
                  ),
                  textField(
                      text: "CONF-Password",
                      prefixIcon: Icons.lock_outline,
                      controller: confPassController,
                      type: TextInputType.visiblePassword,
                      isPass: isConfPassword,
                      suffixIcon: isConfPassword
                          ? Icons.visibility
                          : Icons.visibility_off,
                      function: () {
                        setState(() {
                          isConfPassword = !isConfPassword;
                        });
                      }),
                  SizedBox(
                    height: 20,
                  ),
                  button(
                      context: context,
                      text: "Signup",
                      color: HexColor('#549AAB'),
                      minWidth: MediaQuery.of(context).size.width / 2,
                      height: MediaQuery.of(context).size.height / 12,
                      function: () {
                        Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (context) => Login()),
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
