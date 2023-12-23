import 'dart:async';
import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Local_Storage/shared_pre.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Models/auth_response_model.dart';

class LoginController extends AppBaseController {
  bool isHidden = true;

  var phone = '';

  String login = 'Email';
  int num = 0;

  bool isLoading = false;

  User? userData;

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

  Future<void> sendOtp({required String mobile}) async {
    update();
    isLoading= true;

    var param = {
      'mobile': mobile,
      'app_key':"#63Y@#)KLO57991(\$457D9(JE4dY3d2250f\$%#(mhgamesapp!xyz!punjablottery)8fm834(HKU8)5grefgr48mg1"
    };
    apiBaseHelper.postAPICall(sendOTPAPI, param).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
      String otp = getData['otp'];
      if (status) {
        Fluttertoast.showToast(msg: msg);

        Get.toNamed(otpScreen, arguments: [mobile, otp]);
        update();
        isLoading = false;
      } else {
        Fluttertoast.showToast(msg: msg);
      }
      isLoading = false;
    });
  }


}
