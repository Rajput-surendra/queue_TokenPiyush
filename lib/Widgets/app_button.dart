

import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/material.dart';

class AppButton extends StatelessWidget {
  const AppButton({Key? key,this.onTap, this.title }) : super(key: key);

 final String? title ;
  final VoidCallback? onTap ;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      width: double.maxFinite,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
            elevation: 5,
            backgroundColor: AppColors.whit,
            shape: RoundedRectangleBorder(
              borderRadius:
              BorderRadius.circular(30),
            )),
        child:  Text(
          title ?? '',
          style: const TextStyle(
            //decoration: TextDecoration.underline,
            color: AppColors.fntClr,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
