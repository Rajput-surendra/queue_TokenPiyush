
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
  bool isVisible1 = false;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: LoginController(),
      builder: (controller) =>
          Scaffold(
            backgroundColor: AppColors.primary,
            body: WillPopScope(
              onWillPop: () async {
                SystemNavigator.pop();
                return true; // This line is necessary to avoid a lint warning
              },
              child: SingleChildScrollView(
                child: Form(
                  key: _formkey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
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
                        const SizedBox(height: 100,),
                        Container(
                          width: double.maxFinite,
                          height: 50,
                          padding: const EdgeInsets.all(5.0),
                          decoration: CustomBoxDecoration.myCustomDecoration(),
                          child: TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: const InputDecoration(
                                hintText: "Enter Email",
                                contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                border: InputBorder.none
                            ),
                            style: const TextStyle(fontSize: 14),
                            validator: (value){
                              if (value!.isEmpty) {
                                return 'Email is required';
                              }
                              if(!value.contains('@')){
                                return 'Invalid Email';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.maxFinite,
                          height: 50,
                          padding: const EdgeInsets.all(5.0),
                          decoration: CustomBoxDecoration.myCustomDecoration(),
                          child: TextFormField(
                            obscureText: isVisible1 ? false : true,
                            controller: _password,
                            decoration:  InputDecoration(
                              hintText: "Enter Password",
                              contentPadding: EdgeInsets.only(left: 10,top: 8),
                              border: InputBorder.none,
                              suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible1 ? isVisible1 = false : isVisible1 = true;
                                  });
                                },
                                icon: Icon(
                                  isVisible1
                                      ? Icons.remove_red_eye
                                      : Icons.visibility_off,
                                  color:  AppColors.primary,
                                ),
                              ),
                            ),
                            style: const TextStyle(fontSize: 14),
                            validator: (val) {
                              if (val!.isEmpty) {
                                return "Password cannot be empty";
                              } else if (val.length < 2) {
                                return "Please enter must 2 digit";
                              }
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        const SizedBox(height: 60,),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: AppButton(
                              title: controller.isLoading == true
                                  ? 'please wait...'
                                  : 'Login', onTap: () {
                            if (_formkey.currentState!.validate()) {
                              controller.sendOtp(email: _email.text,password: _password.text);
                            } else {
                              Fluttertoast.showToast(
                                  msg: "All field are required");
                            }
                          }),
                        ),
                        const SizedBox(
                          height: 100,
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
