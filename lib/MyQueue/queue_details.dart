import 'dart:async';
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
    _startTimer();
    getTokenDetailsApi();

  }
  late final Uri _url;
  getUrl(){
    _url = Uri.parse('https://qtoken.co.in/Apicontroller/download_bookings/${widget.tokenTd}');
    print('____Som___fff___${_url}_________');

  }

  late Timer _timer;
  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 10), (timer) async {
      getTokenDetailsApi();

    });
  }

  Future<void> _launchUrl() async {
    if (await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  bool isLodding =  false;
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
          style: const TextStyle(fontSize: 17),
        ),
        actions: [
          isLodding ? Center(child: Transform.scale(
            scale: 0.5,
              child: const CircularProgressIndicator(color: AppColors.whit,))):  IconButton(
            icon: const Icon(Icons.refresh_sharp),
            tooltip: 'Refresh',
            onPressed: (){
              setState(() {
                isLodding = true;
              });
              Future.delayed(const Duration(seconds: 1),(){
                getTokenDetailsApi();
              });

            },
          ),
          Padding(
          padding: const EdgeInsets.only(right: 10),
          child: InkWell(
              onTap: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context)=>CounterViewBookingScreen(tokenId: widget.tokenTd,))).then((value) => getTokenDetailsApi());
              },

                  child: const Center(child: Icon(Icons.add,color: AppColors.whit,size: 26,))),
        ),
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: InkWell(
                onTap: () async {
                  await  _launchUrl();
                },
                child: const Icon(Icons.download)),
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


      body: RefreshIndicator(
        onRefresh: () {
          return Future.delayed(const Duration(seconds: 1),(){
            getTokenDetailsApi();
          });
        },
        child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context,i){
            return SingleChildScrollView(
              child: Column(
                children: [
                  getTokenDetailsModel  == null ? const Center(child: CircularProgressIndicator()):
                  Container(
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
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
                                              const Icon(Icons.person,color: AppColors.primary),
                                              const SizedBox(width: 2,),
                                              Text("${getTokenDetailsModel?.data?[i].name}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),

                                            ],
                                          ),
                                          Row(
                                            children: [
                                              const Icon(Icons.person,color: AppColors.primary),
                                              const SizedBox(width: 2,),
                                              Text("(Age ${getTokenDetailsModel?.data?[i].age})",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),

                                            ],
                                          ),

                                          getTokenDetailsModel?.data?[i].isFirst == 1 ?  Row(
                                            children: [
                                              const Icon(Icons.timer,size:22,color: AppColors.primary),
                                              Text("${getTokenDetailsModel?.data?[i].time}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                            ],
                                          ): const SizedBox.shrink(),
                                          const SizedBox(height: 2,),
                                          Row(children: [
                                            const Icon(Icons.location_on_outlined,color: AppColors.primary),
                                            Text("${getTokenDetailsModel?.data?[i].city}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),)
                                          ],),

                                        ],
                                      ),

                                      const SizedBox(height: 5,),
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
                                                  child: Center(child: Text("${getTokenDetailsModel?.data?[i].tokenNumber}",style: const TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500),)),
                                                ),
                                                const SizedBox(height: 10,),
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

                                                                title: const Text("Pending Booking Confirmation",style: TextStyle(fontSize: 15),),
                                                                content: const Text("Are you sure you want to Pending this booking?"),

                                                                actions: <Widget>[
                                                                  // Text(""),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                    children: [
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          Navigator.of(context).pop(false); // Cancel exit
                                                                        },
                                                                        child: const Text("NO"),
                                                                      ),
                                                                      TextButton(
                                                                        onPressed: () {
                                                                          getStatusSkipApi(getTokenDetailsModel?.data?[i].id);
                                                                          Navigator.of(context).pop(false); // C
                                                                        },
                                                                        child: const Text("Yes"),
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
                                                    ):const SizedBox(),
                                                    const SizedBox(width: 5,),
                                                    getTokenDetailsModel?.data?[i].isFirst == 1 ?InkWell(
                                                      onTap: (){
                                                        showDialog(
                                                          context: context,
                                                          builder: (context) {
                                                            return Container(
                                                              height: 100,
                                                              width: 150,
                                                              child: AlertDialog(

                                                                title: const Column(
                                                                  children: [
                                                                    Text("Next Booking Confirmation",style: TextStyle(fontSize: 18),),
                                                                    SizedBox(height: 10,),
                                                                    Text("Are you sure you want to complete this\n booking?",style: TextStyle(fontSize: 12)),
                                                                  ],
                                                                ),

                                                                actions: <Widget>[
                                                                  // Text(""),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                                    children: [
                                                                      InkWell(
                                                                        onTap: (){
                                                                          Navigator.of(context).pop(false);
                                                                      },
                                                                        child: Container(
                                                                                width: 60,
                                                                                height: 40,
                                                                          decoration: BoxDecoration(
                                                                              color: AppColors.primary,
                                                                            borderRadius: BorderRadius.circular(10)
                                                                        ),
                                                                          child: const Center(child: Text("NO",style: TextStyle(color: AppColors.whit),)),
                                                                        ),
                                                                      ),

                                                                      InkWell(
                                                                        onTap: (){
                                                                          getStatusApi(getTokenDetailsModel?.data?[i].id,);
                                                                          Navigator.of(context).pop(false); // C
                                                                        },
                                                                        child: Container(
                                                                          width: 60,
                                                                          height: 40,
                                                                          decoration: BoxDecoration(
                                                                              color: AppColors.primary,
                                                                              borderRadius: BorderRadius.circular(10)
                                                                          ),
                                                                          child: const Center(child: Text("YES",style: TextStyle(color: AppColors.whit

                                                                          ),)),
                                                                        ),
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
                                                      child: Row(
                                                             children: [
                                                               Icon(Icons.timer,color: AppColors.primary,),
                                                               Text("${getTokenDetailsModel?.data?[i].time}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                                             ],
                                                       ),)
                                                  ],
                                                ),
                                                const SizedBox(height: 10,),


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
                        physics: const NeverScrollableScrollPhysics(),
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
                                                const Icon(Icons.person,color: AppColors.primary),
                                                const SizedBox(width: 2,),
                                                Text("${getTokenDetailsModel?.skipedBookings?[i].name}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                                const SizedBox(width: 5,),
                                                Text("(Age:${getTokenDetailsModel?.skipedBookings?[i].age})",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                              ],
                                            ),
                                            const SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                const Icon(Icons.timer,size:22,color: AppColors.primary),
                                                Text("${getTokenDetailsModel?.skipedBookings?[i].time}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                              ],
                                            ),
                                            const SizedBox(height: 5,),
                                            Row(children: [
                                              const Icon(Icons.location_on_outlined,color: AppColors.primary),
                                              Text("${getTokenDetailsModel?.skipedBookings?[i].city}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),)
                                            ],
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 5,),
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
                                                    child: Center(child: Text("${getTokenDetailsModel?.skipedBookings?[i].tokenNumber}",style: const TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500),)),
                                                  ),
                                                  const SizedBox(height: 10,),
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
                                                  ):const SizedBox(),



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
                        physics: const NeverScrollableScrollPhysics(),
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
                                                const Icon(Icons.person,color: AppColors.primary),
                                                const SizedBox(width: 2,),
                                                Text("${getTokenDetailsModel?.completeBookings?[i].name}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                                // SizedBox(width: 5,),
                                                // Text("(Age:${getTokenDetailsModel?.completeBookings?[i].age})",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                              ],
                                            ),

                                            Row(
                                              children: [
                                                const Icon(Icons.person,color: AppColors.primary),
                                                const SizedBox(width: 2,),
                                                Text("(Age:${getTokenDetailsModel?.completeBookings?[i].age})",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                              ],
                                            ),
                                            const SizedBox(height: 5,),
                                            Row(
                                              children: [
                                                const Icon(Icons.timer,size:22,color: AppColors.primary,),
                                                Text("${getTokenDetailsModel?.completeBookings?[i].time}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                              ],
                                            ),
                                            const SizedBox(height: 5,),
                                            Row(children: [
                                              const Icon(Icons.location_on_outlined,color: AppColors.primary),
                                              Text("${getTokenDetailsModel?.completeBookings?[i].city}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),)
                                            ],
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 5,),
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
                                                    child: Center(child: Text("${getTokenDetailsModel?.completeBookings?[i].tokenNumber}",style: const TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500),)),
                                                  ),
                                                  const SizedBox(height: 10,),

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
                                                  ) :const SizedBox()
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
            );
          },
        ),
      ),
    );
  }



getStatusApi(String? id,) async {
  var headers = {
    'Cookie': 'ci_session=ef51cb02d985a63bdab71e9a7b0dbdf944badd53'
  };
  var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}Apicontroller/update_booking_status'));
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
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}Apicontroller/update_booking_status'));
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
    var request = http.MultipartRequest('POST', Uri.parse('${baseUrl}Apicontroller/get_token_bookings'));
    request.fields.addAll({
      'token_id':widget.tokenTd.toString()
    });
  print('____Som__sss____${request.fields}_________');
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = GetTokenDetailsModel.fromJson(jsonDecode(result));
      setState(() {
        isLodding = false;
        getTokenDetailsModel = finalResult;
      });
    }
    else {
    print(response.reasonPhrase);
    }

  }

}
