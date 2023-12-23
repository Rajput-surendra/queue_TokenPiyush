import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Local_Storage/shared_pre.dart';
import 'package:booknplay/Models/auth_response_model.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class ChangePasswordController extends AppBaseController{

User usedata = User();
final oldPasswordController = TextEditingController();
final newPasswordController = TextEditingController();
final confirmPasswordController = TextEditingController();
@override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();

    var obj = await SharedPre.getObjs(SharedPre.userData);

    usedata = User.fromJson(obj);

  }
  RxBool isLoading = false.obs;




  // Future<void> changePassword() async{
  //
  //
  //   isLoading.value = true;
  //
  //   var param = {
  //     'user_id': usedata.id.toString(),
  //     'old_password': oldPasswordController.text,
  //     'new_password': newPasswordController.text,
  //   };
  //   apiBaseHelper.postAPICall(changePasswordAPI, param).then((getData) {
  //     bool error = getData['status'];
  //     String msg = getData['message'];
  //
  //     if (error) {
  //       Fluttertoast.showToast(msg: msg);
  //       oldPasswordController.clear();
  //     newPasswordController.clear();
  //     confirmPasswordController.clear();
  //     } else {
  //       Fluttertoast.showToast(msg: msg);
  //     }
  //     isLoading.value = false;
  //   });
  // }

}