// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

ShowTost({
  required String text,
  required ToastStates states,
}) =>
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 8,
        backgroundColor: chooseToastColor(states),
        textColor: Colors.white,
        fontSize: 15.0);

enum ToastStates { SUCCESS, ERROR, WARNING }

Color chooseToastColor(ToastStates states) {
  Color color;
  switch (states) {
    case ToastStates.SUCCESS:
      color = Colors.green;
      break;
    case ToastStates.ERROR:
      color = Colors.red;
      break;
    case ToastStates.WARNING:
      color = Colors.amber;
      break;
  }
  return color;
}

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  ValueChanged<String>? onSubmit,
  bool isPassword = false,
  IconData? sufix,
  Function? onTap,
  String? hint,
  bool readOnly = false,
  ValueChanged<String>? onChange,
  required String label,
  required IconData? prefix,
  Function?suffixf,
String? Function(String?)? validate

}) =>
    TextFormField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: type,
      obscureText: isPassword,
      validator: validate,
      onFieldSubmitted: onSubmit,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText:hint ,
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: OutlineInputBorder(borderRadius:BorderRadius.circular(25),
          borderSide:const BorderSide(width: 0.2), ),
        prefixIcon: Icon(
          prefix,
          color: Colors.white,
        ),
        suffixIcon: sufix != null
            ? IconButton(
          onPressed: (){suffixf!();},
              icon: Icon(
          sufix,
        ),
            )
            : null,
      ),
    );


Widget  Button({
  double width =250,
  double r = 50.0,
  required String text,

  Color back = Colors.orange,

  required Function function,
  required bool isLoading,
}) =>
    Container(
      height: 40,
      width: width,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color.fromRGBO(255, 143, 158, 1),
            Color.fromRGBO(255, 188, 143, 1),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(r),
            bottomLeft: Radius.circular(r),
            topLeft:  Radius.circular(r),
            bottomRight:  Radius.circular(r),
        ),
      ),
      child: MaterialButton(
        shape: CircleBorder(
          eccentricity: 1.0,
        ),
        onPressed: isLoading ? null : () => function(),
        child: isLoading
            ? CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        )
            : Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            letterSpacing: 2.0,
            fontSize: 20,
          ),
        ),
      ),
    );