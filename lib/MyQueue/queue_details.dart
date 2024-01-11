import 'dart:convert';

import 'package:booknplay/Services/api_services/apiConstants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;

import '../../Models/HomeModel/get_token_details_model.dart';
import '../../Utils/Colors.dart';

class QueueDetails extends StatefulWidget {
  QueueDetails({Key? key,this.tokenTd}) : super(key: key);
  String? tokenTd;
  @override
  State<QueueDetails> createState() => _QueueDetailsState();
}

class _QueueDetailsState extends State<QueueDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTokenDetailsApi();
  }
  @override
  Widget build(BuildContext context) {
    print('____Som______${widget.tokenTd}_________');
    return Scaffold(
      backgroundColor: AppColors.whit,
      appBar: AppBar(
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
        centerTitle: true,
        title: const Text(
          "Queue Booking Details",
          style: TextStyle(fontSize: 17),
        ),
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
            getTokenDetailsModel == null ? Padding(padding: const EdgeInsets.all(8.0), child: Center(child: Text("No Token Details"))):
            Container(
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:getTokenDetailsModel?.data?.length  ?? 0,
                  itemBuilder: (c,i){
                return Card(
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
                                    Text("${getTokenDetailsModel?.data?[i].name}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.call),
                                    Text("${getTokenDetailsModel?.data?[i].mobile}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Icon(Icons.location_on_outlined),
                                    Text("${getTokenDetailsModel?.data?[i].city}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),)
                                  ],
                                ),
                                SizedBox(height: 5,),

                              ],
                            ),

                             Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                       color: AppColors.primary,
                                   borderRadius: BorderRadius.circular(50)
                                      ),
                                    child: Center(child: Text("${getTokenDetailsModel?.data?[i].tokenNumber}",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.w500),)),
                                  ),
                                  SizedBox(height: 10,),
                                  getTokenDetailsModel?.data?[i].status == "0"?InkWell(
                                    onTap: (){
                                      getStatusApi(getTokenDetailsModel?.data?[i].id);
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
                                  ):getTokenDetailsModel?.data?[i].status == "1" ?InkWell(
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
                                  ) :InkWell(
                                    onTap: (){

                                    },
                                    child: Container(
                                      height: 30,
                                      width: 80,
                                      decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      child: const Center(child:Text("Next",style: TextStyle(color: AppColors.whit,fontWeight: FontWeight.w500))
                                      ),
                                    ),
                                  )
                                ],
                              )
                          ],)
                      ],
                    ),
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
  GetTokenDetailsModel ? getTokenDetailsModel;
  // getTokenDetailsApi() async {
  //   var headers = {
  //     'Cookie': 'ci_session=45929e130fed326177d88ab29c494c3bef056dc2'
  //   };
  //   var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/get_token_bookings'));
  //   request.fields.addAll({
  //     'token_id':widget.tokenTd.toString()
  //   });
  //   print('_______request.fields___${request.fields}_________');
  //   request.headers.addAll(headers);
  //   http.StreamedResponse response = await request.send();
  //   if (response.statusCode == 200) {
  //     var result = await response.stream.bytesToString();
  //     var finalResult = GetTokenDetailsModel.fromJson(jsonDecode(result));
  //     setState(() {
  //       getTokenDetailsModel = finalResult;
  //     });
  //   }
  //   else {
  //     print(response.reasonPhrase);
  //   }
  // }

getStatusApi(String? id) async {
  var headers = {
    'Cookie': 'ci_session=ef51cb02d985a63bdab71e9a7b0dbdf944badd53'
  };
  var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/queue_token/Apicontroller/update_booking_status'));
  request.fields.addAll({
    'booking_id':id.toString()
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
  getTokenDetailsApi() async {
    var headers = {
      'Cookie': 'ci_session=10ea41bcc3ecad102955cc279e8adb576c63be86'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/queue_token/Apicontroller/get_token_bookings'));
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
