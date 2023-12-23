import 'package:booknplay/Screens/ChnagePassword/chnage_pasaword_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {



  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ChangePasswordController(),
    builder: (controller) {
     return SafeArea(
       child: Material(
         child: bodyWidget(context, controller),
       ),
     ) ;
    },);
  }

  Widget bodyWidget(BuildContext context, ChangePasswordController controller) {
    return Stack(
      children: [
        CustomAppBar(onPressedLeading: () {
          Get.back();
        },title: 'Change Password'),
        Positioned(top: 75, child: screenStackContainer(context)),
        Padding(
          padding:
          EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.11,),
          child: Container(
            width: MediaQuery.of(context).size.width,
            //height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              color: AppColors.whit,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                // Top-left corner radius
                topRight: Radius.circular(30),
                // Bottom-right corner with no rounding
              ),
            ),
            child:  SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  textView(' Old Password'),
                  otherTextField(controller: controller.oldPasswordController),
                  const SizedBox(height: 20,),
                  textView(' New Password'),
                  otherTextField(controller: controller.newPasswordController),
                  const SizedBox(height: 20,),
                  textView(' Confirm Password'),
                  otherTextField(controller: controller.confirmPasswordController,isSecure: true),
                  const SizedBox(height: 50,),
                  Obx(() => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child:controller.isLoading.value ? const Center(child: CircularProgressIndicator(color: AppColors.secondary,),)  :  AppButton(
                      title: 'Update',
                      onTap: (){
                        if(controller.oldPasswordController.text.isEmpty){
                          Fluttertoast.showToast(msg: 'please enter old password');
                        }else if(controller.newPasswordController.text != controller.confirmPasswordController.text){
                          Fluttertoast.showToast(msg: 'confirm password does not match');
                        }else {

                        //  controller.changePassword();

                        }

                      },),
                  ),),
                  const SizedBox(
                    height: 20,
                  )

                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget textView(String text){
    return  Text(text , style: TextStyle(color: AppColors.fntClr, fontSize: 20),);
  }
}
