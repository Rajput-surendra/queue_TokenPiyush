import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:get/get.dart';

class MyBookingController extends AppBaseController{

  bool? isFrom;
  String? onSearch;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    // isFrom = Get.arguments ;

    // print('${isFrom}____________');

  }


  void handleOnChangedResult(String? result) {

    onSearch = result;

  }
}

