import 'package:booknplay/Screens/Search/search_view.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar.dart';
import 'package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../Constants.dart';
import '../../Utils/Colors.dart';
import '../Bookings/my_booking_view.dart';
import '../Profile/profile_view.dart';

class SearchBottom extends StatefulWidget {
  const SearchBottom({Key? key}) : super(key: key);

  @override
  State<SearchBottom> createState() => _SearchBottomState();
}
int currentIndex = 1 ;
int bottomIndex = 0;
String? userRole;
List <Widget>
pageList  = [
  SearchScreen(),
  // ResultScreen(),
  MyBookingsScreen(isFrom: false),
  ProfileScreen()
];

class _SearchBottomState extends State<SearchBottom> {
  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: () async {
        // Display a confirmation dialog when the back button is pressed.
        bool exit = await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Exit App'),
              content: Text('Are you sure you want to exit the app?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false); // Cancel exit
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true); // Confirm exit
                  },
                  child: Text('Yes'),
                ),
              ],
            );
          },
        );

        return exit ?? false; // Exit if the user confirmed (true) or continue if canceled (false).
      },
      child: Scaffold(
          bottomNavigationBar: CurvedNavigationBar(
            //buttonBackgroundColor: Colors.white,
            color: AppColors.secondary,
            backgroundColor: AppColors.whit,
            items:  const [
              CurvedNavigationBarItem(
                  child: ImageIcon(AssetImage(AppConstants.homeIcon),
                      color: AppColors.whit),
                  label: 'Home',
                  labelStyle: TextStyle(color: AppColors.whit)
              ),

              CurvedNavigationBarItem(
                  child: ImageIcon(AssetImage(AppConstants.myLotteryIcon),
                      color: AppColors.whit),
                  label: 'My Token',
                  labelStyle: TextStyle(color: AppColors.whit)
              ),
              CurvedNavigationBarItem(
                  child: ImageIcon(AssetImage(AppConstants.profileIcon),
                      color: AppColors.whit),
                  label: 'Account',
                  labelStyle: TextStyle(color: AppColors.whit)
              ),
            ],
            onTap: (index) {
              setState(() {
                bottomIndex = index;
              });

              //Handle button tap
            },
          ),
          key: _key,
          backgroundColor: AppColors.whit,
          body: pageList[bottomIndex]

      ),
    );
  }
  final GlobalKey<ScaffoldState> _key = GlobalKey();

}
