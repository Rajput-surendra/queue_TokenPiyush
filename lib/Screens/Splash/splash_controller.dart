import 'dart:async';
import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Local_Storage/shared_pre.dart';
import 'package:booknplay/Routes/routes.dart';
import 'package:get/get.dart';


class SplashController extends AppBaseController {



  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    checkLogin();

  }




checkLogin() async{

    Timer(const Duration(seconds: 3),() async{
      final isLogin = await SharedPre.getStringValue('userId');

      if(isLogin != null && isLogin != ''){

          Get.offAllNamed(bottomBar);

      }else {

          Get.offAllNamed(loginScreen);

      }
    });




}





}