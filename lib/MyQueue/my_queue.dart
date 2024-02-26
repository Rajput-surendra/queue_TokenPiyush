import 'dart:convert';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/get_token_model.dart';
import '../../Models/HomeModel/signUp_cat_model.dart';

import 'package:http/http.dart' as http;

import '../../Models/get_counter_model.dart';
import '../../Models/get_sub_plan_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Utils/extentions.dart';
import '../Screens/CreateToken/add_create_token_view.dart';
import 'queue_details.dart';

class MyQueueScreen extends StatefulWidget {
  MyQueueScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<MyQueueScreen> createState() => _MyQueueScreenState();
}

class _MyQueueScreenState extends State<MyQueueScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }

  String? userId;
  getUserId() async {
    userId = await SharedPre.getStringValue('userId');
    setState(() {
      getTokenApi();

    });
  }


  final nameController = TextEditingController();
  final mobileController = TextEditingController();
   String? pId;
  @override
  Widget build(BuildContext context) {
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
            "Queue List",
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
        body:   RefreshIndicator(
          onRefresh: () {
            return Future.delayed(const Duration(seconds: 2),(){
             getTokenApi();
            });
          },
          child:  /*getTokenModel?.todayTokens == null? Center(child: Center(child: const CircularProgressIndicator())):*/ getTokenModel?.todayTokens == null ?const Center(child: Text("No Tokens")): ListView.builder(
              itemCount: 1,
              itemBuilder: (context,i){
                return  SingleChildScrollView(
                    child:Padding(
                      padding: const EdgeInsets.all(8.0),
                      child:getTokenModel == null ? const Center(child: CircularProgressIndicator()): Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 10,),
                          getTokenModel?.todayTokens == null ?? false ? const SizedBox.shrink() : const Text("Today's Token", style: TextStyle(color: AppColors.fntClr, fontSize: 18, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 10,),
                          Container(

                            child: getTokenModel?.todayTokens?.isEmpty ?? false ? const Center(child: Text("No Todays Tokens")):ListView.builder(
                                itemCount: getTokenModel?.todayTokens?.length ?? 0,
                                  shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                scrollDirection: Axis.vertical,
                                itemBuilder: (context,i){
                                  return  InkWell(
                                      onTap: (){
                                        Navigator.push(context, MaterialPageRoute(builder: (context)=> QueueDetails(tokenTd: getTokenModel?.todayTokens?[i].id,changeName: getTokenModel?.todayTokens?[i].userName,)));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/1.1,
                                      child: Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              const SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text("Name:"),
                                                  Text(" ${getTokenModel?.todayTokens?[i].userName}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),

                                                ],
                                              ),
                                              const SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text("Counter Id:"),
                                                  Text(" ${getTokenModel?.todayTokens?[i].uniqueId}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),

                                                ],
                                              ),
                                              const SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  const Text("From:"),
                                                  Text(" ${getTokenModel?.todayTokens?[i].fromTime}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),
                                                ],
                                              ),

                                              const SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text("To :"),
                                                  Text(" ${getTokenModel?.todayTokens?[i].toTime}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              const SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text("Token Time:"),
                                                  Text(" ${getTokenModel?.todayTokens?[i].timePerClient} minutes ",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              const SizedBox(height: 5,),

                                            ],

                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          ),
                          const SizedBox(height: 20,),
                          getTokenModel?.tomorrowTokens == null ?? false ? const SizedBox.shrink() :  const Text(
                            "Tomorrow Token",
                            style: TextStyle(
                                color: AppColors.fntClr,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 10,),
                          Container(
                            width: MediaQuery.of(context).size.width/1.0,
                            child:getTokenModel?.tomorrowTokens?.isEmpty ?? false ? const Center(child: Text("No Tomorrow Tokens")): ListView.builder(
                                scrollDirection: Axis.vertical,
                                shrinkWrap: true,
                                reverse: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: getTokenModel?.tomorrowTokens?.length ?? 0,
                                itemBuilder: (context,i){
                                  return  InkWell(
                                    onTap: (){
                                      Navigator.push(context, MaterialPageRoute(builder: (context)=> QueueDetails(tokenTd: getTokenModel?.tomorrowTokens?[i].id,changeName: getTokenModel?.tomorrowTokens?[i].userName,)));
                                    },
                                    child: Container(
                                      width: MediaQuery.of(context).size.width/1.2,
                                      child: Card(
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [

                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text("Name:"),
                                                  Text(" ${getTokenModel?.tomorrowTokens?[i].userName}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              const SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text("Counter Id:"),
                                                  Text(" ${getTokenModel?.tomorrowTokens?[i].uniqueId}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              const SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [

                                                  const Text("From:"),
                                                  Text(" ${getTokenModel?.tomorrowTokens?[i].fromTime}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              const SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text("To:"),
                                                  Text(" ${getTokenModel?.tomorrowTokens?[i].toTime}",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              const SizedBox(height: 5,),
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                children: [
                                                  const Text("Token Time:"),
                                                  Text(" ${getTokenModel?.tomorrowTokens?[i].timePerClient} minutes ",style: const TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),
                                                ],
                                              ),
                                              const SizedBox(height: 5,),

                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }),
                          )
                        ],
                      ),
                    )
                );
              }),
        )



    );
  }
  deleteApi(String tokenId) async {
    var headers = {
      'Cookie': 'ci_session=6209e4620ed9a80d257831fa946958bd2d88c53e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/delete_token'));
    request.fields.addAll({
      'token_id':tokenId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      setState(() {
        Fluttertoast.showToast(msg: "${finalResult['message']}");
        getTokenApi();
      });
    }
    else {
    print(response.reasonPhrase);
    }

  }

  GetTokenModel? getTokenModel;
  getTokenApi() async {
    var headers = {
      'Cookie': 'ci_session=052f7198d39c07d7c57fb2fed6a242b3b8aaa2de'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/counter_tokens'));
    request.fields.addAll({
      'user_id':userId.toString()
    });
    print('______request____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result =  await response.stream.bytesToString();
      var finalResult  = GetTokenModel.fromJson(jsonDecode(result));
      setState(() {
        getTokenModel =  finalResult;

      });
      Fluttertoast.showToast(msg: "${finalResult.message}");

    }
    else {
      print(response.reasonPhrase);
    }

  }
}
