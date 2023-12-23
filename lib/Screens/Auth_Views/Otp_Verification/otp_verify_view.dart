import 'package:booknplay/Constants.dart';
import 'package:booknplay/Screens/Auth_Views/Otp_Verification/otp_verify_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/auth_custom_design.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../Routes/routes.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  State<OTPVerificationScreen> createState() => _Otp();
}

class _Otp extends State<OTPVerificationScreen> {
  String? newPin ;
  @override
  Widget build(BuildContext context) {

    return GetBuilder(
      init: OTPVerifyController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: AppColors.primary,
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Container(
              height: MediaQuery.of(context).size.height,
              // decoration: const BoxDecoration(
              //   image: DecorationImage(
              //     image: AssetImage("assets/images/punbabComman.png"),
              //     fit: BoxFit.cover,
              //   ),
              // ),
              child: Padding(
                padding: const EdgeInsets.only(right:20,left: 20,top: 90),
                child: Column(
                  children: [
                    const SizedBox(height: 100,),
                    const Text("Verification",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 25),),
                    const SizedBox(height: 100,),

                    const Text('Code has been sent to',style: TextStyle(color: AppColors.whit),),
                    Text(controller.data[0].toString(),style: const TextStyle(fontSize: 20,color: AppColors.whit),),
                    // controller.otp == "null" ?
                    // Text('OTP: ',style: const TextStyle(fontSize: 20,color: AppColors.whit),):
                    Text('OTP: ${controller.otp}',style: const TextStyle(fontSize: 20,color: AppColors.whit),),

                    const SizedBox(height: 50,),
                    PinCodeTextField(

                      //errorBorderColor:Color(0xFF5ACBEF),
                      //defaultBorderColor: Color(0xFF5ACBEF),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                       // controller.otp = value.toString() ;
                       newPin = value.toString();
                      },
                      textStyle: const TextStyle(color: AppColors.whit),
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(10),
                         activeColor: AppColors.whit,
                         inactiveColor: AppColors.whit,
                         fieldHeight: 60,
                         fieldWidth: 60,
                         inactiveFillColor: AppColors.whit,
                         activeFillColor: Colors.white,
                      ),
                      //pinBoxRadius:20,
                      appContext: context, length: 4 ,
                    ),

                    const SizedBox(height: 20,),
                    const Text("Haven't received the verification code?",style: TextStyle(color: AppColors.whit,fontSize: 16),),
                    InkWell(onTap: (){
                      controller.resendSendOtp();
                      //sendOtp(mobile: controller.data[0].toString());
                    },
                        child: const Text('Resend',style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: AppColors.whit),)),
                    const SizedBox(height: 50,),
                    // Obx(() => Padding(padding: const EdgeInsets.only(left: 25, right: 25), child: controller.isLoading.value ? const Center(child: CircularProgressIndicator(),) :
                    //
                    // )
                  AppButton(onTap: (){
                    if(newPin != controller.otp){
                      Fluttertoast.showToast(msg: "Please enter correct pin");

                    } else if(newPin == null) {
                      Fluttertoast.showToast(msg: "Please enter pin");
                    }
                    else{
                      controller.verifyOTP();
                    }
                  },title: 'Verify OTP')

                  ],
                ),
              ),
            ),
          ),


        );
      }
    );
  }



}