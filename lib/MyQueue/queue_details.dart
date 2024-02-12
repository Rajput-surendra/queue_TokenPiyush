import 'dart:convert';
import 'dart:io';


import 'package:booknplay/Services/api_services/apiConstants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Models/HomeModel/get_token_details_model.dart';
import '../../Utils/Colors.dart';
import '../Screens/Counter/counter_view_booking.dart';

class QueueDetails extends StatefulWidget {
  QueueDetails({Key? key,this.tokenTd,this.changeName}) : super(key: key);
  String? tokenTd,changeName;
  @override
  State<QueueDetails> createState() => _QueueDetailsState();
}

class _QueueDetailsState extends State<QueueDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUrl();
    getTokenDetailsApi();
  }
  late final Uri _url;
  getUrl(){
    _url = Uri.parse('https://qtoken.co.in/Apicontroller/download_bookings/${widget.tokenTd}');
    print('____Som___fff___${_url}_________');

  }

  Future<void> _launchUrl() async {
    if (await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  @override
  Widget build(BuildContext context) {
    print('____Som______${widget.tokenTd}_________');
    return Scaffold(
      backgroundColor: AppColors.whit,
      appBar: AppBar(
        centerTitle: true,
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(Icons.arrow_back)),
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(50.0),
            bottomRight: Radius.circular(50),
          ),
        ),
        toolbarHeight: 60,
        // centerTitle: true,
        title:  Text(
          "${widget.changeName}",
          style: TextStyle(fontSize: 17),
        ),
        actions: [
          Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
              onTap: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context)=>CounterViewBookingScreen(tokenId: widget.tokenTd,))).then((value) => getTokenDetailsApi());
              },

                  child: Center(child: Icon(Icons.add,color: AppColors.whit,size: 26,))),
        ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () async {
                  await  _launchUrl();
                },
                child: Icon(Icons.download)),
          )
        ],




        flexibleSpace: Container(
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10.0),
              bottomRight: Radius.circular(10),
            ),
            gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.1,
                colors: <Color>[AppColors.primary, AppColors.secondary]),
          ),
        ),

      ),


      body: SingleChildScrollView(
        child: Column(
          children: [
            getTokenDetailsModel  == null ? Center(child: CircularProgressIndicator()):
            Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:getTokenDetailsModel?.data?.length  ?? 0,
                  itemBuilder: (c,i){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.person),
                                      SizedBox(width: 2,),
                                      Text("${getTokenDetailsModel?.data?[i].name}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                      SizedBox(width: 5,),
                                      Text("(Age:${getTokenDetailsModel?.data?[i].age})",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                    ],
                                  ),
                                  // SizedBox(height: 5,),
                                  // Row(
                                  //   children: [
                                  //     Icon(Icons.call,size:22),
                                  //     Text("${getTokenDetailsModel?.data?[i].mobile}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                  //   ],
                                  // ),
                                  SizedBox(height: 5,),
                                  Row(children: [
                                    Icon(Icons.location_on_outlined),
                                    Text("${getTokenDetailsModel?.data?[i].city}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),)
                                  ],
                                  ),
                                ],
                              ),

                            SizedBox(height: 5,),
                             Row(
                               children: [
                                 Padding(
                                   padding: const EdgeInsets.only(right: 5),
                                   child: Column(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       Container(
                                         height: 30,
                                         width: 30,
                                         decoration: BoxDecoration(
                                             color: AppColors.primary,
                                             borderRadius: BorderRadius.circular(50)
                                         ),
                                         child: Center(child: Text("${getTokenDetailsModel?.data?[i].tokenNumber}",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500),)),
                                       ),
                                       SizedBox(height: 10,),
                                       Row(
                                         children: [
                                           getTokenDetailsModel?.data?[i].isFirst == 1 ? InkWell(
                                             onTap: (){
                                               showDialog(
                                                 context: context,
                                                 builder: (context) {
                                                   return Container(
                                                     height: 100,
                                                     width: 150,
                                                     child: AlertDialog(

                                                       title: Text("Pending Booking Confirmation",style: TextStyle(fontSize: 15),),
                                                       content: Text("Are you sure you want to Pending this booking?"),

                                                       actions: <Widget>[
                                                         // Text(""),
                                                         Row(
                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                           children: [
                                                             TextButton(
                                                               onPressed: () {
                                                                 Navigator.of(context).pop(false); // Cancel exit
                                                               },
                                                               child: Text("NO"),
                                                             ),
                                                             TextButton(
                                                               onPressed: () {
                                                                 getStatusSkipApi(getTokenDetailsModel?.data?[i].id);
                                                                 Navigator.of(context).pop(false); // C
                                                               },
                                                               child: Text("Yes"),
                                                             ),
                                                           ],
                                                         )
                                                       ],
                                                     ),
                                                   );
                                                 },
                                               );
                                             },
                                             child: Container(
                                               height: 30,
                                               width: 80,
                                               decoration: BoxDecoration(
                                                   color: Colors.orange,
                                                   borderRadius: BorderRadius.circular(10)
                                               ),
                                               child: const Center(child:Text("Pending ",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500))
                                               ),
                                             ),
                                           ):SizedBox(),
                                           SizedBox(width: 5,),
                                           getTokenDetailsModel?.data?[i].isFirst == 1 ?InkWell(
                                             onTap: (){
                                               showDialog(
                                                 context: context,
                                                 builder: (context) {
                                                   return Container(
                                                     height: 100,
                                                     width: 150,
                                                     child: AlertDialog(

                                                       title: Text("Next Booking Confirmation",style: TextStyle(fontSize: 15),),
                                                       content: Text("Are you sure you want to complete this booking?"),

                                                       actions: <Widget>[
                                                         // Text(""),
                                                         Row(
                                                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                           children: [
                                                             TextButton(
                                                               onPressed: () {
                                                                 Navigator.of(context).pop(false); // Cancel exit
                                                               },
                                                               child: Text("NO"),
                                                             ),
                                                             TextButton(
                                                               onPressed: () {
                                                                 getStatusApi(getTokenDetailsModel?.data?[i].id,);
                                                                 Navigator.of(context).pop(false); // C
                                                               },
                                                               child: Text("Yes"),
                                                             ),
                                                           ],
                                                         )
                                                       ],
                                                     ),
                                                   );
                                                 },
                                               );
                                             },

                                             child: Container(
                                               height: 30,
                                               width: 80,
                                               decoration: BoxDecoration(
                                                   color: Colors.yellow,
                                                   borderRadius: BorderRadius.circular(10)
                                               ),
                                               child: const Center(child:Text("Next",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500))
                                               ),
                                             ),
                                           ):InkWell(
                                             child: Container(
                                             height: 30,
                                             width: 80,
                                             decoration: BoxDecoration(
                                                 color: AppColors.secondary,
                                                 borderRadius: BorderRadius.circular(10)
                                             ),
                                             child: const Center(child:Text("Upcoming",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500))
                                             ),
                                           ),)
                                         ],
                                       ),
                                       SizedBox(height: 10,),


                                     ],
                                   ),
                                 ),

                               ],
                             ),


                          ],),

                      ],
                    ),
                  ),
                );
              }),
            ),
            //getTokenDetailsModel == null ? Center(child: CircularProgressIndicator()):getTokenDetailsModel?.skipedBookings?.isEmpty ?? false ? Center(child: Text("No Booking List Found!!")):
            Container(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:getTokenDetailsModel?.skipedBookings?.length?? 0,
                  itemBuilder: (c,i){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person),
                                          SizedBox(width: 2,),
                                          Text("${getTokenDetailsModel?.skipedBookings?[i].name}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                          SizedBox(width: 5,),
                                          Text("(Age:${getTokenDetailsModel?.skipedBookings?[i].age})",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Icon(Icons.call,size:22),
                                          Text("${getTokenDetailsModel?.skipedBookings?[i].mobile}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(children: [
                                        Icon(Icons.location_on_outlined),
                                        Text("${getTokenDetailsModel?.skipedBookings?[i].city}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),)
                                      ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius: BorderRadius.circular(50)
                                              ),
                                              child: Center(child: Text("${getTokenDetailsModel?.skipedBookings?[i].tokenNumber}",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500),)),
                                            ),
                                            SizedBox(height: 10,),
                                            getTokenDetailsModel?.skipedBookings?[i].status == "2"?InkWell(
                                              onTap: (){
                                                // getStatusApi(getTokenDetailsModel?.completeBookings?[i].id);
                                              },
                                              child: Container(
                                                height: 30,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: Colors.orange,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: const Center(child:Text("Pending",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500))
                                                ),
                                              ),
                                            ):SizedBox(),



                                          ],
                                        ),
                                      )
                                    ],
                                  )

                                ],),

                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),
            //getTokenDetailsModel == null ? Center(child: CircularProgressIndicator()):getTokenDetailsModel?.completeBookings?.isEmpty ?? false ? Center(child: Text("No Booking List Found!!")):
            Container(
              child: ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount:getTokenDetailsModel?.completeBookings?.length?? 0,
                  itemBuilder: (c,i){
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Icon(Icons.person),
                                          SizedBox(width: 2,),
                                          Text("${getTokenDetailsModel?.completeBookings?[i].name}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                          SizedBox(width: 5,),
                                          Text("(Age:${getTokenDetailsModel?.completeBookings?[i].age})",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(
                                        children: [
                                          Icon(Icons.call,size:22),
                                          Text("${getTokenDetailsModel?.completeBookings?[i].mobile}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                        ],
                                      ),
                                      SizedBox(height: 5,),
                                      Row(children: [
                                        Icon(Icons.location_on_outlined),
                                        Text("${getTokenDetailsModel?.completeBookings?[i].city}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),)
                                      ],
                                      ),
                                    ],
                                  ),

                                  SizedBox(height: 5,),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(right: 5),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                  color: AppColors.primary,
                                                  borderRadius: BorderRadius.circular(50)
                                              ),
                                              child: Center(child: Text("${getTokenDetailsModel?.completeBookings?[i].tokenNumber}",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500),)),
                                            ),
                                            SizedBox(height: 10,),

                                            getTokenDetailsModel?.completeBookings?[i].status == "1" ?InkWell(
                                              onTap: (){

                                              },
                                              child: Container(
                                                height: 30,
                                                width: 80,
                                                decoration: BoxDecoration(
                                                    color: Colors.green,
                                                    borderRadius: BorderRadius.circular(10)
                                                ),
                                                child: const Center(child:Text("Complete",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500))
                                                ),
                                              ),
                                            ) :SizedBox()
                                          ],
                                        ),
                                      )
                                    ],
                                  )

                                ],),

                            ],
                          ),
                        ),
                      ),
                    );
                  }),
            ),

          ],
        ),
      ),
    );
  }



getStatusApi(String? id,) async {
  var headers = {
    'Cookie': 'ci_session=ef51cb02d985a63bdab71e9a7b0dbdf944badd53'
  };
  var request = http.MultipartRequest('POST', Uri.parse('https://qtoken.co.in/Apicontroller/update_booking_status'));
  request.fields.addAll({
    'booking_id':id.toString(),
    'status':"1"
  });
  print('request.fields${request.fields}_________');
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
   var result  = await response.stream.bytesToString();
   var finalResult  = jsonDecode(result);
   Fluttertoast.showToast(msg: "${finalResult['message']}");
   getTokenDetailsApi();
  }
  else {
  print(response.reasonPhrase);
  }

}
  getStatusSkipApi(String? id) async {
    var headers = {
      'Cookie': 'ci_session=ef51cb02d985a63bdab71e9a7b0dbdf944badd53'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://qtoken.co.in/Apicontroller/update_booking_status'));
    request.fields.addAll({
      'booking_id':id.toString(),
      'status':"2"
    });
    print('request.fields${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalResult  = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      getTokenDetailsApi();
    }
    else {
      print(response.reasonPhrase);
    }

  }
  GetTokenDetailsModel ? getTokenDetailsModel;
  getTokenDetailsApi() async {
    var headers = {
      'Cookie': 'ci_session=10ea41bcc3ecad102955cc279e8adb576c63be86'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://qtoken.co.in/Apicontroller/get_token_bookings'));
    request.fields.addAll({
      'token_id':widget.tokenTd.toString()
    });
  print('____Som______${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetTokenDetailsModel.fromJson(jsonDecode(result));
      setState(() {
        getTokenDetailsModel = finalResult;
      });
    }
    else {
    print(response.reasonPhrase);
    }

  }

}
