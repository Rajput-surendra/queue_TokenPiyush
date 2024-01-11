import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../../../Local_Storage/shared_pre.dart';
import '../../../Models/HomeModel/signUp_cat_model.dart';
import '../../../Routes/routes.dart';

class SignupController extends AppBaseController {
  RxBool isLoading = false.obs ;

  @override
  Future<void> onInit() async {
    // TODO: implement onInit
    super.onInit();
    // TODO: implement initState
    getCateApi();
  }
  String? role;
  Future<void> registerUser(
      {
      required String mobile,
      required String? name,
      required String? email,
      required String? password,
      required String? address,
      required String? city,
      required String? catId,
      required bool? selected,
      }) async {
    isLoading.value = true ;
    var param = {
      'userName': name,
      'mobile': mobile,
      'role': selected ==  false ? 'user' :'counter',
      'address':address,
      'email':email,
      'password':password,
      'city':city,
      'cat_id':catId.toString()
    };

    apiBaseHelper.postAPICall(getUserRegister, param).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
      role = getData['data']['role'];

      // String msg = getData['msg'];
      if (status) {
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
      } else {
        Fluttertoast.showToast(msg: msg);
      }
      isLoading.value = false ;
    });
  }

  GetCatModel? getCatModel;
  Future<void> getCateApi() async {
    apiBaseHelper.postAPICall2(getCatAPI).then((getData) {
      print('_____getData_____${getData}_________');
      getCatModel = GetCatModel.fromJson(getData);
    update();

      //isLoading.value = false;
    });
  }


}
