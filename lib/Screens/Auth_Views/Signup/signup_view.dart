import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Auth_Views/Login/login_view.dart';
import 'package:booknplay/Screens/Auth_Views/Signup/signup_controller.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Utils/extentions.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/auth_custom_design.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import '../../../Models/HomeModel/signUp_cat_model.dart';
import '../../../Models/get_sub_plan_model.dart';
import '../../../Services/api_services/apiConstants.dart';
import '../../../Services/api_services/apiStrings.dart';
import '../../../Widgets/button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final passController = TextEditingController();
  final cPassController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool isVisible = false;
  bool isVisible1 = false;
  String selectedOption = "Get Token";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCat();
  }
 bool? isUser = true;
  @override
  Widget build(BuildContext context) {
    return GetBuilder(
        init: SignupController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: AppColors.primary,
            body: SingleChildScrollView(
             // physics: const NeverScrollableScrollPhysics(),
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
                child: Padding(
                  padding: const EdgeInsets.only(
                      right: 10, left: 10, top: 30),
                  child: SingleChildScrollView(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          SizedBox(height: 50,),
                          const Text("Sign Up", style: TextStyle(color: AppColors
                              .whit, fontWeight: FontWeight.bold, fontSize: 40),),
                          const SizedBox(height: 30,),
                          // Image.asset("assets/images/SIGN UP.png", height: 150,
                          //   width: 200,),
                          const SizedBox(height: 10,),
                             Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: [
                                        Radio(
                                          value: 'Get Token',
                                          groupValue: selectedOption,
                                          activeColor: AppColors.whit,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedOption = value.toString();
                                            });
                                          },
                                        ),
                                        const Text('Get Token',style: TextStyle(color: AppColors.whit),),
                                      ],
                                    ),
                                    const SizedBox(width: 20),
                                    Row(
                                      children: [
                                        Radio(
                                          value: 'Create Queue',
                                          groupValue: selectedOption,
                                          activeColor: AppColors.whit,
                                          focusColor: AppColors.whit,
                                          onChanged: (value) {
                                            setState(() {
                                              selectedOption = value.toString();
                                            });
                                          },
                                        ),
                                        const Text('Create Queue',style: TextStyle(color: AppColors.whit),),
                                      ],
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10.0),
                                if (selectedOption == 'Create Queue')
                                Column(
                                  children: [
                                    Container(
                                      height: 55,
                                      child: Card(
                                        elevation: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.all(0.0),
                                          child: DropdownButtonHideUnderline(
                                            child: DropdownButton2<SignUpCat>(
                                              hint:  const Text('Select Category',
                                                style: TextStyle(
                                                    //color: AppColors.subTxtClr,fontSize:12
                                                ),),
                                              value: animalCat,
                                              isExpanded: true,
                                              icon:  const Icon(Icons.keyboard_arrow_down_rounded,  color:AppColors.fntClr,size: 25,),
                                              style:  const TextStyle(color: AppColors.secondary,fontWeight: FontWeight.bold),
                                              underline: Padding(
                                                padding: const EdgeInsets.only(left: 0,right: 0),
                                                child: Container(
                                                  // height: 2,
                                                  color:  AppColors.whit,
                                                ),
                                              ),
                                              onChanged: (SignUpCat? value) {
                                                setState(() {
                                                  animalCat = value!;
                                                  catId =  animalCat?.id;
                                                });
                                              },
                                              items: getCatModel?.data?.map((items) {
                                                return DropdownMenuItem(
                                                  value: items,
                                                  child:  Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 2),
                                                        child: Container(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(top: 0),
                                                              child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:AppColors.subTxtClr),),
                                                            )),
                                                          ),
                                                       ],
                                                    ),
                                                 );
                                              }).toList(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15,),
                                    Container(
                                 width: double.maxFinite,
                                 height: 50,
                                     padding: const EdgeInsets.all(5.0),
                                       decoration: CustomBoxDecoration.myCustomDecoration(),
                                     child: TextFormField(
                                       controller: nameController,
                                       decoration: const InputDecoration(
                                           hintText: "hospital/bank/business name",
                                           contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                         border: InputBorder.none
                                       ),
                                       style: const TextStyle(fontSize: 14),
                                       validator: (val) {
                                         if (val!.isEmpty) {
                                           return " name cannot be empty";
                                         } else if (val.length < 4) {
                                           return "Please enter must 5 digit";
                                         }
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
                                        controller: emailController,
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
                                        maxLength: 10,
                                        keyboardType: TextInputType.number,
                                        controller: mobileController,
                                        decoration: const InputDecoration(
                                          counterText: "",
                                          hintText: "Enter Mobile Number",
                                          contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                         // prefixIcon: Icon(Icons.call),
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
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Container(
                                      width: double.maxFinite,
                                      height: 50,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: CustomBoxDecoration.myCustomDecoration(),
                                      child: TextFormField(
                                        controller: cityController,
                                        decoration: const InputDecoration(
                                            hintText: "Enter City Name",
                                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                            border: InputBorder.none
                                        ),
                                        style: const TextStyle(fontSize: 14),
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "City cannot be empty";
                                          } else if (val.length < 2) {
                                            return "Please enter must 2 digit";
                                          }
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
                                        controller: addressController,
                                        decoration: const InputDecoration(
                                            hintText: "Enter Address Name",
                                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                            border: InputBorder.none
                                        ),
                                        style: const TextStyle(fontSize: 14),
                                        validator: (val) {
                                          if (val!.isEmpty) {
                                            return "Address cannot be empty";
                                          } else if (val.length < 2) {
                                            return "Please enter must 2 digit";
                                          }
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
                                        controller: passController,
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

                                    Container(
                                      width: double.maxFinite,
                                      height: 50,
                                      padding: const EdgeInsets.all(5.0),
                                      decoration: CustomBoxDecoration.myCustomDecoration(),
                                      child: TextFormField(
                                        obscureText: isVisible ? false : true,
                                        controller: cPassController,
                                        decoration:  InputDecoration(
                                            hintText: "Enter Confirm Password",
                                            contentPadding: EdgeInsets.only(left: 10,top: 8),
                                            border: InputBorder.none,
                                          suffixIcon: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                isVisible ? isVisible = false : isVisible = true;
                                              });
                                            },
                                            icon: Icon(
                                              isVisible
                                                  ? Icons.remove_red_eye
                                                  : Icons.visibility_off,
                                              color:  AppColors.primary,
                                            ),
                                          ),
                                        ),
                                        style: const TextStyle(fontSize: 14),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Please confirm your password';
                                          } else if (value != passController.text) {
                                            return 'Passwords do not match';
                                          }
                                          return null;
                                        },
                                      ),
                                    ),
                                  ],
                                )

                              ],
                            ),
                          ),

                          if (selectedOption == 'Get Token')
                           Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Column(
                               children: [
                                 Container(
                                   width: double.maxFinite,
                                   height: 50,
                                   padding: const EdgeInsets.all(5.0),
                                   decoration: CustomBoxDecoration.myCustomDecoration(),
                                   child: TextFormField(
                                     controller: nameController,
                                     decoration: const InputDecoration(
                                         hintText: "Enter Name",
                                         contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                         border: InputBorder.none
                                     ),
                                     style: const TextStyle(fontSize: 14),
                                     validator: (val) {
                                       if (val!.isEmpty) {
                                         return "name cannot be empty";
                                       } else if (val.length < 2) {
                                         return "Please enter must 2 digit";
                                       }
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
                                     controller: emailController,
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
                                     maxLength: 10,
                                     keyboardType: TextInputType.number,
                                     controller: mobileController,
                                     decoration: const InputDecoration(
                                         counterText: "",
                                         hintText: "Enter Mobile Number",
                                         contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                         // prefixIcon: Icon(Icons.call),
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
                                 const SizedBox(
                                   height: 15,
                                 ),
                                 Container(
                                   width: double.maxFinite,
                                   height: 50,
                                   padding: const EdgeInsets.all(5.0),
                                   decoration: CustomBoxDecoration.myCustomDecoration(),
                                   child: TextFormField(
                                     controller: cityController,
                                     decoration: const InputDecoration(
                                         hintText: "Enter City Name",
                                         contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                                         border: InputBorder.none
                                     ),
                                     style: const TextStyle(fontSize: 14),
                                     validator: (val) {
                                       if (val!.isEmpty) {
                                         return "City cannot be empty";
                                       } else if (val.length < 2) {
                                         return "Please enter must 2 digit";
                                       }
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
                                     controller: passController,
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
                                           color: AppColors.primary,
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

                                 Container(
                                   width: double.maxFinite,
                                   height: 50,
                                   padding: const EdgeInsets.all(5.0),
                                   decoration: CustomBoxDecoration.myCustomDecoration(),
                                   child: TextFormField(
                                     obscureText: isVisible ? false : true,
                                     controller: cPassController,
                                     decoration:  InputDecoration(
                                       hintText: "Enter Confirm Password",
                                       contentPadding: EdgeInsets.only(left: 10,top: 8),
                                       border: InputBorder.none,
                                       suffixIcon: IconButton(
                                         onPressed: () {
                                           setState(() {
                                             isVisible ? isVisible = false : isVisible = true;
                                           });
                                         },
                                         icon: Icon(
                                           isVisible
                                               ? Icons.remove_red_eye
                                               : Icons.visibility_off,
                                           color:  AppColors.primary,
                                         ),
                                       ),
                                     ),
                                     style: const TextStyle(fontSize: 14),
                                     validator: (value) {
                                       if (value == null || value.isEmpty) {
                                         return 'Please confirm your password';
                                       } else if (value != passController.text) {
                                         return 'Passwords do not match';
                                       }
                                       return null;
                                     },
                                   ),
                                 ),
                               ],
                             ),
                           ),
                            SizedBox(height: 10,),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              child: AppButton(
                              title: 'SignUp',
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  if (selectedOption == 'Get Token') {

                                    controller.registerUser(
                                    mobile: mobileController.text,
                                     name: nameController.text,
                                     email: emailController.text,
                                      address: "",
                                      city:cityController.text,
                                      password:passController.text,
                                      catId: "",
                                      selected: false,
                                    );
                                  } else if (selectedOption == 'Create Queue') {
                                    controller.registerUser(
                                      mobile: mobileController.text,
                                      name: nameController.text,
                                      email: emailController.text,
                                      password:passController.text,
                                      address: addressController.text,
                                      city: cityController.text,
                                      catId: catId.toString(),
                                      selected: true,
                                    );
                                  }
                                } else {
                                  Fluttertoast.showToast(
                                      msg: "All field are required");
                                }
                              },
                          ),
                            ),
                             Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account?",
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white),
                              ),
                              TextButton(
                                onPressed: () {
                                  Get.toNamed(loginScreen);
                                },
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(
                                      color: AppColors.whit,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
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
        });


  }


  String? catId;
  SignUpCat? animalCat;
  GetCatModel ? getCatModel;
  Future<void> getCat() async {
    var param = {
      'app_key': ""
    };
    apiBaseHelper.postAPICall(getCatAPI, param).then((getData) {
      String msg = getData['message'];
      getCatModel = GetCatModel.fromJson(getData);
      setState(() {
        Fluttertoast.showToast(msg: msg);
      });
    });
  }
  GetSubscriptionModel? getSubscriptionModel;



  // GetCatModel? getCatModel;
  // Future<void> getLottery() async {
  //   apiBaseHelper.postAPICall2(getCatAPI).then((getData) {
  //     setState(() {
  //       getCatModel = GetCatModel.fromJson(getData);
  //     });
  //
  //     //isLoading.value = false;
  //   });
  // }

}
