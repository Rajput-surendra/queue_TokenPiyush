import 'package:booknplay/Controllers/app_base_controller/app_base_controller.dart';
import 'package:booknplay/Screens/Auth_Views/Login/login_view.dart';
import 'package:booknplay/Screens/Bookings/my_booking_view.dart';
import 'package:booknplay/Screens/Home/home_view.dart';
import 'package:booknplay/Screens/Profile/profile_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DashboardController extends AppBaseController {


List <Widget>  pages = [
 HomeScreen(),
const MyBookingsScreen(isFrom: false),
   ProfileScreen(),
   ProfileScreen()
];

RxInt currentIndex = 1.obs ;
int bottomIndex = 0;

}