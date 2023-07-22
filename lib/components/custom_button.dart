import 'package:flutter/material.dart';
import 'package:lastcashir/cubits/cubit.dart';

Widget button(
    {required context,
    required String text,
    required Color? color,
    required double minWidth,
    required double height,
    required Function() function}) {
  return MaterialButton(
    height: height,
    minWidth: minWidth,
    onPressed: function,
    color: color,
    child: Text(
      text,
      style: TextStyle(
          color: Colors.white, fontSize: 17, fontWeight: FontWeight.bold),
    ),
  );
}

Widget calculatorNumber(context,
    {required TextEditingController controller, required String number}) {
  return Expanded(
    child: InkWell(
      onTap: () {
        cubit
            .get(context)
            .enterQuantity(controller: controller, number: number);
      },
      child: CircleAvatar(
        backgroundColor: Colors.grey.withOpacity(0.5),
        child: Text(
          number,
          style: TextStyle(fontSize: 20),
        ),
      ),
    ),
  );
}

Widget textField({
  required String text,
  required IconData prefixIcon,
  required TextEditingController controller,
  bool isPass = false,
  required TextInputType type,
  IconData? suffixIcon,
  Function()? function,
  double raduis = 25,
}) {
  return TextFormField(
    validator: (value) {
      if (value!.isEmpty) {
        return "$text can't be empty";
      }
      return null;
    },
    controller: controller,
    obscureText: isPass,
    keyboardType: type,
    decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon),
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: function, icon: Icon(suffixIcon))
            : null,
        label: Text(text),
        border:
            OutlineInputBorder(borderRadius: BorderRadius.circular(raduis))),
  );
}

Widget text({required String text, required Color color}) {
  return Text(
    text,
    textAlign: TextAlign.center,
    style: TextStyle(color: color),
  );
}

Widget checkBoxItem(
    {required Function(bool?) function,
    required String text,
    required bool value}) {
  return Row(
    children: [
      Checkbox(
        value: value,
        onChanged: function,
      ),
      Text(text),
    ],
  );
}
