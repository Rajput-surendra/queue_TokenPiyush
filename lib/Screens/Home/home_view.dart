import 'dart:convert';

import 'package:booknplay/Routes/routes.dart';
import 'package:booknplay/Screens/Dashboard/dashboard_view.dart';
import 'package:booknplay/Screens/Home/HomeController.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/get_slider_model.dart';

import '../../Models/get_counter_model.dart';
import '../../MyQueue/my_queue.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../Counter/counter_view.dart';
import '../CreateToken/add_create_token_view.dart';
import '../CreateToken/create_token_view.dart';
import '../Notification/notification_view.dart';
import '../Search/search_view.dart';

import 'package:http/http.dart'as http;

import '../Subscription/sub_plan_view.dart';

class HomeScreen extends StatefulWidget {
   HomeScreen({Key? key,this.nameC,this.cityC,this.catId,this.counterId}) : super(key: key);
  String? nameC,cityC,catId,counterId;
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 1;
 @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // getSlider();
     getFilterApi();
     referCode();
    //checkStatusApi();

  }
  String? userRole;
  referCode() async {
    userRole = await SharedPre.getStringValue('userRole');
    userId =  await SharedPre.getStringValue('userId');
    setState(() {
      checkStatusApi();
    });
  }
  String? userId;


  final CarouselController carouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whit,
        appBar: AppBar(
          automaticallyImplyLeading: false,

          shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(50.0),bottomRight: Radius.circular(50),
            ),),
          toolbarHeight: 60,
          title: const Text("QUEUE TOKEN",style: TextStyle(fontSize: 17),),
          actions: [
            userRole == 'user' ?  InkWell(onTap: (){
              Navigator.pop(context);

            },
                child: const Icon(Icons.search)):SizedBox.shrink(),
            const SizedBox(width: 15,),
            Padding(
              padding: const EdgeInsets.only(right: 10
              ),
              child: InkWell(
                onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>NotificationScreen()));
                },
                  child: Image.asset("assets/images/notification.png",height: 15,width:20,color: AppColors.whit,)),
            ),
          ],
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),
              gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.9,
                  colors: <Color>[AppColors.primary, AppColors.secondary]),
            ),
          ),
        ),

        body:getCounterModel == null ? Center(child: CircularProgressIndicator()): userRole == "user" ? userUI() :counterUI()
      ),
    );
  }



  ///////////////////////UserSite//////////////////
  userUI(){
    return getCounterModel == null ?const Center(child: CircularProgressIndicator()) :RefreshIndicator(
      onRefresh: () {
        return Future.delayed(const Duration(seconds: 2),(){
         // getSlider();
        getFilterApi();

        });
      },
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context,i){
            return  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Welcome To Queue Token',style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.black
                  ),),
                ),


                // getCatListView(controller),
                //sliderPointers (controller.catList , controller.catCurrentIndex.value ),
                const SizedBox(height: 5,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    todayToken()
                  ],
                )

              ],
            );
          }),
    );
  }
  int _currentPost = 0;
   _buildDots() {
    List<Widget> dots = [];
    if (getSliderModel == null) {
    } else {
      for (int i = 0; i < getSliderModel!.sliderdata!.length; i++) {
        dots.add(
          Container(
            margin: const EdgeInsets.all(1.5),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPost == i ?  AppColors.profileColor : AppColors.secondary,
            ),
          ),
        );
      }
    }
    return dots;
  }
  GetSliderModel? getSliderModel;
  Future<void> getSlider() async {
    // isLoading.value = true;
    var param = {
      'app_key': ""
    };
    apiBaseHelper.postAPICall(getSliderAPI, param).then((getData) {
      bool status = getData['status'];
      String msg = getData['msg'];
      if (status == true) {
        setState(() {
          getSliderModel = GetSliderModel.fromJson(getData);
        });
      } else {
        Fluttertoast.showToast(msg: msg);
      }
    });
  }

  todayToken(){
    return Container(
     // height: MediaQuery.of(context).size.height,
      child:getCounterModel?.todaysTokens?.isEmpty ?? false ? Center(child: Text("No Today Token")): ListView.builder(
          scrollDirection: Axis.vertical,
            shrinkWrap: true,
           reverse: true,
           physics: const NeverScrollableScrollPhysics(),
          itemCount:getCounterModel?.todaysTokens?.length ?? 0,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>CounterScreen(
                  cId: getCounterModel!.todaysTokens![index].counterId,
                  tokenId: getCounterModel!.todaysTokens![index].id,
                  date:getCounterModel!.todaysTokens![index].date ,
                  fTime: getCounterModel!.todaysTokens![index].fromTime,
                  toTime: getCounterModel!.todaysTokens![index].toTime,
                  cToken: getCounterModel!.todaysTokens![index].currentToken,
                exTime: getCounterModel!.todaysTokens![index].expactedTime,)));
              },
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                    height: 115,

                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/lotteryback.png"), fit: BoxFit.fill)),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10,top: 8),
                              child: Row(
                                children: [
                                  const Text("Counter Name:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                  const SizedBox(width: 2,),
                                  Row(
                                    children: [
                                      Text("${getCounterModel!.todaysTokens![index].companyName}",style: const TextStyle(color: AppColors.whit,fontSize: 12),),
                                      //Text(" to ${getCounterModel!.todaysTokens![index].toTime}",style: const TextStyle(color: AppColors.whit,fontSize: 12),),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8,top: 6),
                              child: Row(
                                children: [

                                  const Text("Date:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
                                  const SizedBox(width: 2,),
                                  Text("${getCounterModel!.todaysTokens![index].date!}",style: const TextStyle(color: AppColors.whit,fontSize: 12),)
                                ],
                              ),
                            )
                          ],
                        ),

                        SizedBox(height: 10,),
                       Padding(
                         padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                         child: Column(
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [

                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     const Text("Name :",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                     const SizedBox(width: 2,),
                                     Text("${getCounterModel!.todaysTokens![index].userName}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                   ],
                                 ),
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     const Text("City : ",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                     const SizedBox(width: 2,),
                                     Text("${getCounterModel!.todaysTokens![index].city}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                   ],
                                 ),
                                 Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     const Text("Counter Id :",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                     const SizedBox(width: 2,),
                                     Text("${getCounterModel!.todaysTokens![index].uniqueId}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                   ],
                                 ),
                               ],
                             ),
                             SizedBox(height:12),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     const Text("Current Token :",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                     const SizedBox(width: 2,),
                                     Text("${getCounterModel!.todaysTokens![index].currentToken}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                   ],
                                 ),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     const Text("Expected Time : ",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
                                     const SizedBox(width: 2,),
                                     Text("${getCounterModel!.todaysTokens![index].expactedTime}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
                                   ],
                                 ),
                               ],
                             )


                           ],
                         ),
                       ),
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                children: [


                                ],
                              )

                            ],
                          ),
                        )

                      ],
                    )
                ),
              ),
            );
          }
      ),
    );
  }
//   tomorrowToken(){
//     return  Container(
//       child: getCounterModel?.upcomingTokens?.isEmpty ?? false ? Center(child: const Text("No UpcomingTokens")):ListView.builder(
//           itemCount:getCounterModel?.upcomingTokens?.length  ?? 0,
//           scrollDirection: Axis.vertical,
//           shrinkWrap: true,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             return InkWell(
//               onTap: (){
//                 Navigator.push(context, MaterialPageRoute(builder: (context)=>CounterScreen(cId:
//                 getCounterModel!.upcomingTokens![index].counterId,
//                   tokenId: getCounterModel!.upcomingTokens![index].id,
//                   date:getCounterModel!.upcomingTokens![index].date ,
//                   fTime: getCounterModel!.upcomingTokens![index].fromTime,
//                   toTime: getCounterModel!.upcomingTokens![index].toTime,
//                   tTotal: getCounterModel!.upcomingTokens![index].totalToken,)));
//               },
//               child: Padding(
//                 padding: const EdgeInsets.all(5.0),
//                 child:  Container(
//                     height: 100,
//                     width: 280,
//                     decoration: const BoxDecoration(
//                         image: DecorationImage(
//                             image: AssetImage("assets/images/lotteryback.png"), fit: BoxFit.fill)),
//                     child: Column(
//                       children: [
//                         Row(
//                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                           children: [
//                             Padding(
//                               padding: const EdgeInsets.only(left: 10,top: 6),
//                               child: Row(
//                                 children: [
//                                   const Text("Expected Time:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
//                                   const SizedBox(width: 2,),
//                                   Row(
//                                     children: [
//                                       Text("${getCounterModel!.upcomingTokens![index].fromTime}",style: const TextStyle(color: AppColors.whit,fontSize: 12),),
//                                       Text(" to ${getCounterModel!.upcomingTokens![index].toTime}",style: const TextStyle(color: AppColors.whit,fontSize: 12),),
//                                     ],
//                                   )
//                                 ],
//                               ),
//                             ),
//                             Padding(
//                               padding: const EdgeInsets.only(right: 8,top: 6),
//                               child: Row(
//                                 children: [
//
//                                   const Text("Date:",style: TextStyle(color: AppColors.whit,fontSize: 12),),
//                                   const SizedBox(width: 2,),
//                                   Text("${getCounterModel!.upcomingTokens![index].date!}",style: const TextStyle(color: AppColors.whit,fontSize: 12),)
//                                 ],
//                               ),
//                             )
//                           ],
//                         ),
//
//                         Padding(
//                           padding: const EdgeInsets.only(left: 5,right: 10,top: 10),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                             children: [
//                               Padding(
//                                 padding: const EdgeInsets.all(8.0),
//                                 child: Row(
//                                   children: [
//                                     const SizedBox(height: 2,),
//                                     Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: [
//                                         Row(
//                                           children: [
//                                             const Text("City Name:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
//                                             const SizedBox(width: 2,),
//                                             Text("${getCounterModel!.upcomingTokens![index].companyName}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
//                                           ],
//                                         ),
//                                         Row(
//                                           children: [
//                                             const SizedBox(height: 10,),
//                                             const Text("Name :",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
//                                             const SizedBox(width: 2,),
//                                             Text("${getCounterModel!.upcomingTokens![index].userName!}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),)
//                                           ],
//                                         ),
//                                         const SizedBox(height: 2,),
//                                         Row(
//                                           children: [
//                                             const Text("Current Token:",style: TextStyle(color: AppColors.fntClr,fontSize: 12),),
//                                             const SizedBox(width: 2,),
//                                             Text("${getCounterModel!.upcomingTokens![index].currentToken}",style: const TextStyle(color: AppColors.fntClr,fontSize: 12,fontWeight: FontWeight.bold),),
//                                           ],
//                                         ),
//
//
//                                       ],
//                                     )
//                                   ],
//                                 ),
//                               ),
//
//                             ],
//                           ),
//                         ),
//
//                       ],
//                     )
//                 ),
//               ),
//             );
//           }
//       ),
//     );
// }

  GetHomeTokenModel? getCounterModel;
  getFilterApi() async {
    var headers = {
      'Cookie': 'ci_session=052f7198d39c07d7c57fb2fed6a242b3b8aaa2de'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/counters'));
    request.fields.addAll({
      userName?.isEmpty ?? false ? "" : 'counter_name': userName.toString(),
      cityName?.isEmpty ?? false? "" : 'counter_city': cityName.toString(),
      catNewId == null ? "" : 'counter_category': catNewId.toString(),
      cId?.isEmpty ?? false? "" : 'unique_id': cId.toString(),
      'filter_date':dayId.toString()
    });
    print("------Surendra----rrrrrrr---${request.fields}----------");
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =  await response.stream.bytesToString();
      var finalResult  = GetHomeTokenModel.fromJson(jsonDecode(result));
      setState(() {
        getCounterModel =  finalResult;
        print(getCounterModel);
      });
      Fluttertoast.showToast(msg: "${finalResult.message}");

    }
    else {
      print(response.reasonPhrase);
    }

  }
///////////////////////UserSite//////////////////
////////////////////////Counter///////////
counterUI(){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 15),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                //   InkWell(
                //     onTap: (){
                //       Navigator.push(context, MaterialPageRoute(builder: (context)=>SubscriptionScreen()));
                //     },
                //     child: Container(
                //       height: 120,
                // decoration: BoxDecoration(
                //     borderRadius:BorderRadius.circular(10),
                //     gradient: const LinearGradient(
                //         colors: [
                //           AppColors.primary,
                //           Color(0xFF00CCFF),
                //         ],
                //         begin: FractionalOffset(0.0, 1.0),
                //         end: FractionalOffset(1.0, 0.0),
                //         stops: [0.0, 1.1],
                //         tileMode: TileMode.clamp),
                //      ),
                //       child: Center(child: const Text("Subscription",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 15),)),
                //     ),
                //   ),
                //   const SizedBox(height: 10,),
                  InkWell(
                   onTap: () async {
                     if(status == 0){
                     await  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddCreateTokenScreen())).then((value) => checkStatusApi());
                     }else{
                       Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTokenScreen()));
                     }

                   },

                      child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                AppColors.primary,
                                Color(0xFF00CCFF),
                              ],
                              begin: FractionalOffset(0.0, 1.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.1],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: const Text("Create Queue Counter ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 15),),),

                    ),
                  ),
                  const SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> MyQueueScreen()));
                    },
                    child: Container(
                      height: 120,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(
                              colors: [
                                AppColors.primary,
                                Color(0xFF00CCFF),
                              ],
                              begin: FractionalOffset(0.0, 1.0),
                              end: FractionalOffset(1.0, 0.0),
                              stops: [0.0, 1.1],
                              tileMode: TileMode.clamp),
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: const Text("My Queue",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.bold,fontSize: 15),)),

                    ),
                  ),


                ],
              ),
            )
          ],
        ),
      ),
    );
   }
   int? status;
   checkStatusApi() async {
     var headers = {
       'Cookie': 'ci_session=bf32b2a3ee26e7283f83bbed06a9a212f774886d'
     };
     var request = http.MultipartRequest('POST', Uri.parse('${baseUrl1}/Apicontroller/check_tockens'));
     request.fields.addAll({
       'user_id':userId.toString()
     });
    print('____Som___request.fields___${request.fields}_________');
     request.headers.addAll(headers);
     http.StreamedResponse response = await request.send();
     if (response.statusCode == 200) {
       var result  = await response.stream.bytesToString();
       var finalResult =  jsonDecode(result);
       status = finalResult['data'];
       print('____Som______${status}_________');
     }
     else {
     print(response.reasonPhrase);
     }

   }
  int _currentPostCounter = 0;
  _buildDotsCounter() {
    List<Widget> dots = [];
    if (getSliderModel == null) {
    } else {
      for (int i = 0; i < getSliderModel!.sliderdata!.length; i++) {
        dots.add(
          Container(
            margin: const EdgeInsets.all(1.5),
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: _currentPost == i ?  AppColors.profileColor : AppColors.secondary,
            ),
          ),
        );
      }
    }
    return dots;
  }

}
