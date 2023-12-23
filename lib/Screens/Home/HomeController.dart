// import 'dart:convert';
//
// import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
//
// import 'package:booknplay/Services/api_services/apiConstants.dart';
// import 'package:carousel_slider/carousel_controller.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
//
//
// import '../../Services/api_services/apiStrings.dart';
//
// class HomeController extends AppBaseController{
//
//   final CarouselController carouselController = CarouselController();
//
//
//   RxBool isGroundLoading = false.obs ;
//
//   String? onChangeResult ;
//
//
//
//   @override
//   Future<void> onInit() async {
//     // TODO: implement onInit
//     super.onInit();
//     homeSlider();
//     homeCategory();
//     homeGround('');
//
//     // TODO: implement initState
//   }
//
//
//   RxInt currentIndex = 0.obs ;
//   RxInt catCurrentIndex = 0.obs ;
//
//   Future<void> homeSlider() async {
//     apiBaseHelper.getAPICall(homeSliderAPI).then((getData) {
//       bool error = getData['status'];
//       String msg = getData['message'];
//       if (error) {
//         Fluttertoast.showToast(msg: msg);
//         sliderList = (getData['data'] as List).map((e) => SliderDataList.fromJson(e)).toList();
//       } else {
//         Fluttertoast.showToast(msg: msg);
//
//       }
//     });
//   }
//
//
//   Future<void> homeCategory() async {
//     apiBaseHelper.getAPICall(homeCategoryAPI).then((getData) {
//       bool error = getData['status'];
//       String msg = getData['message'];
//       if (error) {
//         Fluttertoast.showToast(msg: msg);
//         catList = (getData['data'] as List).map((e) => HomeCatList.fromJson(e)).toList();
//
//       } else {
//         Fluttertoast.showToast(msg: msg);
//         update();
//       }
//     });
//   }
//
//   void handleOnChangedResult(String? result) {
//
//     onChangeResult = result;
//
//   }
//
//   Future<void> homeGround(String catId) async {
//     isGroundLoading.value = true ;
//     apiBaseHelper.getAPICall(Uri.parse('${baseUrl}all_ground?category=$catId')).then((getData) {
//       bool error = getData['status'];
//       String msg = getData['message'];
//       if (error) {
//         groundList = (getData['data'] as List).map((e) => GroundList.fromJson(e)).toList();
//         isGroundLoading.value = false ;
//
//         update();
//
//       } else {
//         Fluttertoast.showToast(msg: msg);
//         isGroundLoading.value = false ;
//         //update();
//       }
//     });
//   }
//
//   void selectedCategory(int index){
//     catCurrentIndex.value = index ;
//     catList.forEach((element) {element.isSelected = false ;});
//     catList[index].isSelected = true ;
//     homeGround(catList[index].id.toString() ?? '');
//   }
// }
