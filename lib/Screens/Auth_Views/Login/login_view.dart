
import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Auth_Views/Login/login_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Utils/extentions.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/auth_custom_design.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formkey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _mobile = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginController(),
      builder: (controller) =>
          Scaffold(
            backgroundColor: AppColors.primary,
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: WillPopScope(
                onWillPop: () async {
                  SystemNavigator.pop();
                  return true; // This line is necessary to avoid a lint warning
                },
                child: Container(
                  height: MediaQuery
                      .of(context)
                      .size
                      .height,
                  // decoration: const BoxDecoration(
                  //   image: DecorationImage(
                  //     image: AssetImage("assets/images/punbabComman.png"),
                  //     fit: BoxFit.cover,
                  //   ),
                  // ),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        const SizedBox(height: 50,),


                        Image.asset(
                          "assets/images/SPLASH LOGO.png", height: 150, width: 200,),
                        const SizedBox(height: 40,),
                        const Text("Login", style: TextStyle(
                            color: AppColors.whit,
                            fontWeight: FontWeight.bold,
                            fontSize: 25),),
                        // Padding(
                        //   padding: const EdgeInsets.symmetric(horizontal: 20),
                        //   child: textField(
                        //       title: 'Mobile Number',
                        //       prefixIcon: Icons.phone,
                        //       inputType: TextInputType.phone,
                        //       maxLength: 10,
                        //       controller: _mobile),
                        // ),
                        const SizedBox(height: 150,),
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          width: double.maxFinite,
                          height: 50,
                          decoration: CustomBoxDecoration.myCustomDecoration(),
                          child: TextFormField(
                            maxLength: 10,
                            keyboardType: TextInputType.number,
                            controller: _mobile,
                            decoration: const InputDecoration(
                                counterText: "",
                                hintText: "Mobile Number",
                                contentPadding: EdgeInsets.only(left: 10),
                                //  prefixIcon: Icon(Icons.call),
                                border: InputBorder.none
                            ),
                            style: const TextStyle(fontSize: 14),

                            validator: (val) {

                              if (val!.isEmpty) {
                                return "Mobile cannot be empty";
                              } else if (val.length < 10) {
                                return "Please enter mobile must 10 digit";
                              }
                            },
                          ),
                        ),
                        const SizedBox(height: 60,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AppButton(
                              title: controller.isLoading == true
                                  ? 'please wait...'
                                  : 'Send OTP', onTap: () {
                            if (_formkey.currentState!.validate()) {
                              controller.sendOtp(mobile: _mobile.text);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "Please enter mobile number");
                            }
                          }),
                        ),
                        const SizedBox(
                          height: 120,
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Don't have an account?",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.whit),
                            ),
                            TextButton(
                                onPressed: () {
                                  Get.toNamed(signupScreen);
                                },
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(
                                      color: AppColors.whit,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold
                                  ),
                                ))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
    );
  }
}
//   String validateMobile(String value) {
//     String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
//     RegExp regExp = new RegExp(patttern);
// }
