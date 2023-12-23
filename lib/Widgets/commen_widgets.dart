import 'package:booknplay/Constants.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Utils/extentions.dart';
import 'package:flutter/material.dart';

import 'drawer_icon_tab_widget.dart';

Widget textView(String text, {TextAlign? textAlign, FontWeight? fontWeight}) {
  return Text(
    text,
    style: const TextStyle(
      fontSize: 16,
    ),
    textAlign: textAlign,
  );
}

Widget textField(
    {String? title,
    TextEditingController? controller,
    IconData? prefixIcon,
    IconData? suffixIcon,
    int? maxLength,
    TextInputType? inputType}) {
  return Container(
    width: double.maxFinite,
    height: 50,
    padding: const EdgeInsets.all(5.0),
    decoration: CustomBoxDecoration.myCustomDecoration(),
    child: TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 14),
      validator: (val) {
        if (val!.isEmpty) {
          print('${maxLength != null &&  val.length > 10}_________');

          return "${title} field cannot be empty";

        } else if (maxLength != null &&  val.length > 10) {
          return "Please enter must 10 digit";
        }
      },
      maxLength: maxLength,
      keyboardType: inputType,
      decoration: CustomInputDecoration.myCustomInputDecoration(
        labelText: title,
        hintText: title,
        prefixIcon: prefixIcon,
      ),
    ),
  );
}
Widget textField1(
    {String? title,
      TextEditingController? controller,
      IconData? prefixIcon,
      IconData? suffixIcon,
      int? maxLength,
      TextInputType? inputType}) {
  return Container(
    width: double.maxFinite,
    height: 50,
    padding: const EdgeInsets.all(5.0),
    decoration: CustomBoxDecoration.myCustomDecoration(),
    child: TextFormField(
      controller: controller,
      style: const TextStyle(fontSize: 14),

      maxLength: maxLength,
      keyboardType: inputType,
      decoration: CustomInputDecoration.myCustomInputDecoration(
        labelText: title,
        hintText: title,
        prefixIcon: prefixIcon,
      ),
    ),
  );
}

Widget screenStackContainer(BuildContext context){
  return Stack(
    children: [
      Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            // Top-left corner radius
            topRight: Radius.circular(30),
            // Bottom-right corner with no rounding
          ),
        ),
      ),
      Padding(
        padding: EdgeInsets.only(
            top: MediaQuery.of(context).size.height * 0.007),          child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        decoration: const BoxDecoration(
          color: AppColors.whit,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            // Top-left corner radius
            topRight: Radius.circular(30),
            // Bottom-right corner with no rounding
          ),
        ),
      ),
      ),
    ],
  );
}

Widget searchWidget(Function(String?) handleOnChangedResult){

  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)),
    elevation: 3,
    child: TextField(
      onChanged: (value){
        handleOnChangedResult(value);
      },
      decoration: const InputDecoration(
        hintText: "Search",
        border: InputBorder.none,
        contentPadding: EdgeInsets.only(top: 15),
        prefixIcon: Icon(Icons.search),
      ),
    ),
  );
}

Widget otherTextField({TextEditingController? controller, String? hint, bool? isSecure }){

  return Card(
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)),
    elevation: 3,
    child: TextFormField(
      controller: controller,
      obscureText: isSecure ?? false,
      decoration:  InputDecoration(
        hintText: hint ?? '',
        border: InputBorder.none,
        contentPadding: const EdgeInsets.only(top: 0,left: 10),
      ),
    ),
  );
}

