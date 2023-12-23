
import 'package:booknplay/Constants.dart';
import 'package:booknplay/Screens/Auth_Views/Forgot_Password/forgot_password_controller.dart';
import 'package:booknplay/Utils/extentions.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/auth_custom_design.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _UserLogin();
}

class _UserLogin extends State<ForgotPasswordScreen> {
  TextEditingController emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {

    return GetBuilder(
      init: ForgotPasswordController(),
      builder: (controller) {
        return Scaffold(
          body: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: <Widget>[
                Stack(
                  children: [
                    customAuthDegine(context, 'Forgot Password?',image: AppConstants.forgotPassword),
                    Padding(
                      padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height / 3.0),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            // Top-left corner radius
                            topRight: Radius.circular(30),// Bottom-right corner with no rounding
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(right:20,left: 20, top: 30),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                 textView("Enter Email associated\nwith your account",textAlign: TextAlign.center),
                                const SizedBox(height: 30,),
                                Container(
                                  width: double.maxFinite,
                                  height: 50,
                                  padding: const EdgeInsets.all(5.0),
                                  decoration: CustomBoxDecoration
                                      .myCustomDecoration(),
                                  child: TextFormField(
                                    controller: emailController,
                                    keyboardType: TextInputType.emailAddress,
                                    decoration: CustomInputDecoration.myCustomInputDecoration(
                                        labelText: 'Email',
                                        hintText: "Email",
                                        prefixIcon: Icons.email
                                    ),
                                  ),
                                ),

                                const SizedBox(height: 30,),

                                Obx(
                                      () => Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 25),
                                      child: controller.isLoading.value
                                          ? const Center(
                                        child:
                                        CircularProgressIndicator(),
                                      )
                                          : AppButton(
                                        title: 'Submit',
                                        onTap: () {
                                          if(_formKey.currentState!.validate()) {
                                        //    controller.forgotEmail(email: emailController.text,);
                                          }
                                        },
                                      )),
                                ),
                            // Padding(
                            //   padding: const EdgeInsets.only(left: 25, right: 25),
                            //   child: AppButton(title: 'Submit',onTap: (){
                            //
                            //   }),
                            // ),

                              ],
                            ),
                          ),

                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }
    );
  }
}