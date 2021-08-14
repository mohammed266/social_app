

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

Widget defaultFormField({
  TextEditingController controller,
  String hint,
  bool secure,
  TextInputType textInputType,
  // bool icon = false,
  Function validate,
  Function onSave,
  Function onChanged,
  Function onSubmit,
  Widget prefix,
  Color color = Colors.white,
}) {
  return TextFormField(
    controller: controller,
    validator: validate,
    onSaved: onSave,
    onChanged: onChanged,
    keyboardType: textInputType,
    obscureText: secure,
    onFieldSubmitted: onSubmit,
    decoration: InputDecoration(
      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      fillColor: color,
      hintText: hint,
      hintStyle: TextStyle(
        color: Color(0xFFBFBFBF),
        fontSize: 13,
      ),
      filled: true,
      suffixIcon: prefix,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    ),
  );
}

Widget defaultAppBar({
  @required BuildContext context,
  List<Widget> actions,
  String title,
})=>  AppBar(
  title: Text(
    title,
  ),
  titleSpacing: 0.0,
  leading: IconButton(
    iconSize: 17,
    onPressed: () {
      Navigator.pop(context);
    },
    icon: Icon(Icons.arrow_back_ios),
    color: Colors.black,
  ),
  actions: actions,
);

Widget myDivider() => Padding(
  padding: const EdgeInsetsDirectional.only(start: 20),
  child: Container(
    width: double.infinity,
    height: 1,
    color: Colors.grey[300],
  ),
);


Widget defaultButton({
  text,
  function,
  color,
  double r = 10,
  Color c = Colors.white,
}) {
  return Container(
    width: double.infinity,
    height: 40,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(r),
      color: color,
    ),
    child: FlatButton(
      onPressed: function,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13,
          color: c,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  );
}

void navigateTo(context, widget) => Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => widget),
);

void navigateAndFinished(context, widget) => Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
      (route) => false,
);

Widget defaultTextButton({@required Function onPressed,@required String text}) =>  TextButton(
  onPressed: onPressed,
  child: Text(text.toUpperCase(),style: TextStyle(color: Colors.blue),),
);

void showToast({
  @required String msg,
  @required ToastState state,
}) => Fluttertoast.showToast(
  msg: msg,
  toastLength: Toast.LENGTH_LONG,
  gravity: ToastGravity.BOTTOM,
  timeInSecForIosWeb: 3,
  backgroundColor: chooseToastColor(state),
  textColor: Colors.white,
  fontSize: 16.0,
);

enum ToastState {SUCCESS,ERROR,WARNING}

Color chooseToastColor(ToastState state){
  Color color;
  switch(state){
    case ToastState.SUCCESS :
      color = Colors.green;
      break;
    case ToastState.WARNING :
      color = Colors.amber;
      break;
    case ToastState.ERROR :
      color = Colors.red;
      break;
  }

  return color;
}