import 'dart:async';
import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Local_Storage/shared_pre.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Models/auth_response_model.dart';
import '../../PushNotification/notification_service.dart';

class LoginController extends AppBaseController {
  bool isHidden = true;

  var phone = '';

  String login = 'Email';
  int num = 0;

  bool isLoading = false;

  //User? userData;

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
    } else {
      num = 1;
    }
    login = value;
    update();
  }
  //
  // Future<void> loginUser({
  //   required String email,
  //   required String password,
  // }) async {
  //   isLoading.value = true;
  //
  //   var param = {
  //     'email': email,
  //     'password': password,
  //     'device_key': '9638528510',
  //   };
  //   apiBaseHelper.postAPICall(getUserLogin, param).then((getData) async {
  //     bool error = getData['status'];
  //     String msg = getData['message'];
  //
  //     if (error) {
  //       Fluttertoast.showToast(msg: msg);
  //
  //       User? userData = User();
  //
  //       userData = User.fromJson(getData['user']);
  //
  //       SharedPre.setValue(SharedPre.userData, userData.toJson());
  //       SharedPre.setValue(SharedPre.isLogin, true);
  //
  //       // SharedPre.setValue('userData', jsonEncode(getData['user']));
  //       Get.toNamed(bottomBar);
  //
  //       //String user = await SharedPre.getStringValue('userData');
  //
  //       //var data = jsonDecode(user);
  //     } else {
  //       Fluttertoast.showToast(msg: msg);
  //     }
  //     isLoading.value = false;
  //   });
  // }
  String? role;
  Future<void> sendOtp({required String email,password}) async {
    // String? token ;
    // try{
    //   token  = await FirebaseMessaging.instance.getToken();
    //
    // } on FirebaseException{
    // }
    //print('____Som______${token}_________');
    update();
    isLoading= true;

    var param = {
      'email': email,
      'password':password,
      'type':'email',
      'app_key':""
    };
    print('____Som______${param}_________');
    apiBaseHelper.postAPICall(sendOTPAPI, param).then((getData) {
      bool status = getData['status'];
       String msg = getData['msg'];
           print('____Som______${status}_________');
      if (status == true) {
        print('____Som______${status}_________');
        role = getData['data']['role'];
        SharedPre.setValue('userData', getData['data']['user_name']);
        SharedPre.setValue('userMobile', getData['data']['mobile']);
        SharedPre.setValue('userReferCode', getData['data']['referral_code']);
        SharedPre.setValue('balanceUser', getData['data']['wallet_balance']);
        SharedPre.setValue('userId', getData['data']['user_id'].toString());
        SharedPre.setValue('userRole', getData['data']['role']);
        Fluttertoast.showToast(msg: msg);
        if(role == "user"){
          Get.offAllNamed(search);
        }else{
          if(role == 'user'){
            Get.offAllNamed(bottomBar);
          }else{
            Get.offAllNamed(bottomBar1);
          }
        }
      }
      else {
        print('____Som______${status}_________');
        Fluttertoast.showToast(msg: "Invalid email & password");
        update();
        isLoading = false;

      }
     update();
      isLoading = false;
    });
  }


}
