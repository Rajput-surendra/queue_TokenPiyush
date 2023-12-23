import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

import '../../../Models/auth_response_model.dart';
import '../../../Services/api_services/apiStrings.dart';

class ForgotPasswordController extends AppBaseController {

  bool isHidden = true;

  var phone = '';

  String? Login;
  int num = 0;

  RxBool isLoading = false.obs ;
  User? userData ;


  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    // TODO: implement initState
  }

  void togglePaaswordView() {
    isHidden = !isHidden;
  }

  void updateLoginType(String value) {
    if (value == 'Email') {
      num = 0;
    }else{
      num = 1;
    }
    Login = value;
    update();
  }

  // Future<void> forgotEmail(
  //     {required String email}) async {
  //      isLoading.value = true ;
  //
  //   var param = {
  //     'email': email,
  //   };
  //   apiBaseHelper.postAPICall(forgotAPI, param).then((getData) {
  //     bool error = getData['status'];
  //     String msg = getData['message'];
  //     if (error) {
  //       Fluttertoast.showToast(msg: msg);
  //       Get.toNamed(loginScreen);
  //     } else {
  //
  //       Fluttertoast.showToast(msg: msg);
  //
  //     }
  //     isLoading.value = false ;
  //   });
  // }
}