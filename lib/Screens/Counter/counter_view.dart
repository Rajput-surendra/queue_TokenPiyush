import 'dart:convert';
import 'package:booknplay/Services/api_services/apiConstants.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/signUp_cat_model.dart';

import 'package:http/http.dart'as http;

import '../../Models/get_counter_model.dart';
import '../../Utils/extentions.dart';
class CounterScreen extends StatefulWidget {
   CounterScreen({Key? key, this.isFrom,this.cId,this.tokenId,this.exTime,this.nextToken,this.aviToken,this.date,this.toTime,this.fTime,this.cToken}) : super(key: key);
  final bool? isFrom;
  String? tokenId,cId,fTime,toTime,date;
   dynamic  cToken,exTime;
  int? nextToken,aviToken;
  // final GetCounterModel? getCounterModel;

  @override
  State<CounterScreen> createState() => _CounterScreenState();
}

class _CounterScreenState extends State<CounterScreen> {
  String? catId;
  SignUpCat? animalCat;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
  }
  String? userId;
  getUserId() async {
    userId =  await SharedPre.getStringValue('userId');
    setState(() {

    });
  }
  final _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final mobileController = TextEditingController();
  final cityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: AppButton1(
        title: isLodder ? "Please wait....": "Get Token",
        onTap: (){
          if(_formKey.currentState! .validate())
          addBookingApi();
        },
      ),
        backgroundColor: AppColors.whit,
        appBar: AppBar(
          leading: InkWell(
            onTap: (){
              Navigator.pop(context);
            },
              child: Icon(Icons.arrow_back)),
          automaticallyImplyLeading: false,
          shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(50.0),bottomRight: Radius.circular(50),
            ),),
          toolbarHeight: 60,
          centerTitle: true,
          title: Text("Booking Details ",style: TextStyle(fontSize: 17),),
          flexibleSpace: Container(
            decoration: const BoxDecoration(
              borderRadius:   BorderRadius.only(
                bottomLeft: Radius.circular(10.0),bottomRight: Radius.circular(10),),
              gradient: RadialGradient(
                  center: Alignment.center,
                  radius: 1.1,
                  colors: <Color>[AppColors.primary, AppColors.secondary]),
            ),
          ),
        ),
        body:  SingleChildScrollView(
          child:Container(
            height: MediaQuery.of(context).size.height/1.2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                        Card(
                          child: Column(
                            children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                 Row(
                                   children: [
                                     Text("Time:"),
                                     Row(
                                       children: [
                                         Text("${widget.fTime}",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.fntClr)),
                                         SizedBox(width: 5,),
                                         Text("to ${widget.toTime}",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.fntClr)),
                                       ],
                                     ),
                                   ],
                                 ),
                                 Row(
                                   children: [
                                     Text("Date:"),
                                     Text("${widget.date}",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.fntClr),),
                                   ],
                                 )
                                ],
                              ),
                            ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Text("Current Avail Token:"),
                                        Text("${widget.cToken}",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.fntClr)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text("Expected Time:"),
                                        Text("${widget.exTime}",style: TextStyle(fontWeight: FontWeight.bold,color: AppColors.fntClr),),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                    SizedBox(height: 20,),
                    Container(
                      width: double.maxFinite,
                      height: 50,
                      padding: const EdgeInsets.all(5.0),
                      decoration: CustomBoxDecoration.myCustomDecoration(),
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            hintText: "Enter Name",
                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                            border: InputBorder.none
                        ),
                        style: const TextStyle(fontSize: 14),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter name";
                          } else if (val.length < 4) {
                            return "Please enter must 4 digit";
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 50,
                      padding: const EdgeInsets.all(5.0),
                      decoration: CustomBoxDecoration.myCustomDecoration(),
                      child: TextFormField(
                        maxLength: 10,
                        keyboardType: TextInputType.number,
                        controller: mobileController,
                        decoration: const InputDecoration(
                            counterText: "",
                            hintText: "Mobile Number",
                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                            // prefixIcon: Icon(Icons.call),
                            border: InputBorder.none
                        ),
                        style: const TextStyle(fontSize: 14),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please enter mobile number";
                          } else if (val.length < 10) {
                            return "Please enter mobile must 10 digit";
                          }
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Container(
                      width: double.maxFinite,
                      height: 50,
                      padding: const EdgeInsets.all(5.0),
                      decoration: CustomBoxDecoration.myCustomDecoration(),
                      child: TextFormField(
                        controller: cityController,
                        decoration: const InputDecoration(
                            hintText: "City Name",
                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                            border: InputBorder.none
                        ),
                        style: const TextStyle(fontSize: 14),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Please city name";
                          } else if (val.length < 4) {
                            return "Please enter must 4 digit";
                          }
                        },
                      ),
                    ),
                   SizedBox(height: 50,),

                  ],
                ),
              ),
            )
          )
        )
    ) ;
  }
  bool isLodder =  false;
addBookingApi() async {
  setState(() {
    isLodder =  true;
  });
  var headers = {
    'Cookie': 'ci_session=8f48c8eae5ab612664fc312e9f4d8b6786d866ff'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/add_booking'));
  request.fields.addAll({
    'counter_id':widget.cId.toString(),
    'token_id':widget.tokenId.toString(),
    'user_id':userId.toString(),
    'name':nameController.text,
    'mobile':mobileController.text,
    'city':cityController.text,
  });
  print('_____request.fields_____${request.fields}_________');
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
    var result = await response.stream.bytesToString();
    var finalResult =  jsonDecode(result);
    Fluttertoast.showToast(msg: 'Token generate successfully');
    Navigator.pop(context);
    setState(() {
      setState(() {
        isLodder =  false;
      });
    });
  }
  else {
    setState(() {
      isLodder =  false;
    });
    print(response.reasonPhrase);
  }


}
}
