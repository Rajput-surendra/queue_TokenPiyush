import 'dart:convert';
import 'package:booknplay/Screens/CreateToken/create_token_view.dart';
import 'package:booknplay/Screens/Search/search_view.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/button.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/signUp_cat_model.dart';
import 'package:http/http.dart' as http;
import '../../Models/HomeModel/update_token_model.dart';
import '../../Models/get_sub_plan_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Utils/extentions.dart';
import 'package:table_calendar/table_calendar.dart';


class AddCreateTokenScreen extends StatefulWidget {
  AddCreateTokenScreen({Key? key,this.tokenId,this.isUpdate}) : super(key: key);
 String ? tokenId;
 bool? isUpdate;
  @override
  State<AddCreateTokenScreen> createState() => _AddCreateTokenScreenState();
}

class _AddCreateTokenScreenState extends State<AddCreateTokenScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUpdateApi();
    getUserId();
    getCat();
  }

  String? userId;

  getUserId() async {
    userId = await SharedPre.getStringValue('userId');
    setState(() {});
    getCatApi();
  }

String? cat_Id;
  getCatApi() async {
    var headers = {
      'Cookie': 'ci_session=55b4cc64e9d4b5f85e3ff465bbb04ff414900228'
    };
    var request = http.MultipartRequest('POST', Uri.parse('https://developmentalphawizz.com/queue_token/Apicontroller/get_counter_cat'));
    request.fields.addAll({
      'user_id':userId.toString()
    });
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result  = await response.stream.bytesToString();
      var finalResult  = jsonDecode(result);
      cat_Id= finalResult['data']['category'];
      animalCat = getCatModel?.data?.firstWhere((item) => item.id == cat_Id.toString());
      print('____Som__cat_Id____${cat_Id}_________');

      print('____Som____ddd__${animalCat!.id}_________');
      setState(() {

      });
    }
    else {
    print(response.reasonPhrase);
    }

  }
  UpdateTokenModel ? updateTokenModel;
  getUpdateApi() async {
    var headers = {
      'Cookie': 'ci_session=6209e4620ed9a80d257831fa946958bd2d88c53e'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/get_token_by_id'));
    request.fields.addAll({
      'token_id':widget.tokenId.toString()
    });
    print('____Som___token_id___${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult = UpdateTokenModel.fromJson(json.decode(result));

      updateTokenModel = finalResult;
      nameController.text = updateTokenModel!.data!.first.userName.toString();
      timeController.text = updateTokenModel!.data![0].timePerClient.toString();
      animalCat = getCatModel?.data?.firstWhere((item) => item.id == updateTokenModel!.data![0].category.toString());
      selectedValue =  items.firstWhere((e) => e==updateTokenModel!.data![0].type.toString());
      starTimeC.text = updateTokenModel!.data![0].toTime.toString();
      endTimeC.text = updateTokenModel!.data![0].fromTime.toString();
      setState(() {});
    }
    else {
      print(response.reasonPhrase);
    }

  }


  updateApi() async {
    var headers = {
      'Cookie': 'ci_session=bc0929f81a4dac0791f6d4092f1e3d7f6cdebff4'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/update_token_data'));
    request.fields.addAll({
      'user_id':userId.toString(),
      'category': animalCat!.id.toString(),
      'time_per_client':timeController.text,
      'from_time':endTimeC.text,
      'to_time':starTimeC.text,
      'user_name':nameController.text,
      'date':selectedValue.toString(),
      'token_id':widget.tokenId.toString(),

    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
       var result  = await response.stream.bytesToString();
       var finalResult  = jsonDecode(result);
       setState(() {
         Fluttertoast.showToast(msg: "${finalResult['message']}");
       });
       Navigator.pop(context);
    }
    else {
    print(response.reasonPhrase);
    }

  }


  final nameController = TextEditingController();
  final orController = TextEditingController();
  final timeController = TextEditingController();
  final starTimeC = TextEditingController();
  final endTimeC = TextEditingController();
   String? pId;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
         bottomSheet:AppButton1(
           title:widget.isUpdate ==true ? "Update": "Create",
           onTap: (){
             if(widget.isUpdate == true){
               updateApi();
             }else{
               addToken();
             }
             },),
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
          title: widget.isUpdate == true ? Text(
            "Update Queue",
            style: TextStyle(fontSize: 17),
          ):Text(
            "Create Queue",
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
            child:Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  SizedBox(height: 20),
                  Container(
                    height: 55,
                    child: Card(
                      elevation: 1,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton2<SignUpCat>(
                            hint:  const Text('Select Category',
                              style: TextStyle(
                                  color: AppColors.fntClr,fontWeight: FontWeight.w500,fontSize:12
                              ),),
                            value: animalCat,
                            isExpanded: true,
                            icon:  const Icon(Icons.keyboard_arrow_down_rounded,  color:AppColors.fntClr,size: 25,),
                            style:  const TextStyle(color: AppColors.secondary,fontWeight: FontWeight.bold),
                            underline: Padding(
                              padding: const EdgeInsets.only(left: 0,right: 0),
                              child: Container(
                                // height: 2,
                                color:  AppColors.whit,
                              ),
                            ),
                            onChanged: (SignUpCat? value) {
                              setState(() {
                                animalCat = value!;
                                catId =  animalCat?.id;
                              });
                            },
                            items: getCatModel?.data?.map((items) {
                              return DropdownMenuItem(
                                value: items,
                                child:  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Container(

                                          child: Padding(
                                            padding: const EdgeInsets.only(top: 0),
                                            child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color:AppColors.fntClr),),
                                          )),
                                    ),

                                  ],
                                ),
                              );
                            })
                                .toList(),
                          ),

                        ),
                      ),
                    ),
                  ),

                  // Padding(
                  //   padding: const EdgeInsets.all(4.0),
                  //   child: Container(
                  //     width: double.maxFinite,
                  //     height: 50,
                  //     padding: const EdgeInsets.all(5.0),
                  //     decoration: CustomBoxDecoration.myCustomDecoration(),
                  //     child: TextFormField(
                  //       controller: orController,
                  //       decoration: const InputDecoration(
                  //           hintText: "Organization Name",
                  //           contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                  //           border: InputBorder.none
                  //       ),
                  //       style: const TextStyle(fontSize: 14),
                  //       validator: (val) {
                  //         if (val!.isEmpty) {
                  //           return "Organization cannot be empty";
                  //         } else if (val.length < 4) {
                  //           return "Please enter must 5 digit";
                  //         }
                  //       },
                  //     ),
                  //   ),
                  // ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.maxFinite,
                      height: 50,
                      padding: const EdgeInsets.all(5.0),
                      decoration: CustomBoxDecoration.myCustomDecoration(),
                      child: TextFormField(
                        controller: nameController,
                        decoration: const InputDecoration(
                            hintText: "Enter Name/Counter Name",
                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                            border: InputBorder.none
                        ),
                        style: const TextStyle(fontSize: 14),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Enter Name/Counter Name cannot be empty";
                          } else if (val.length < 4) {
                            return "Please enter must 5 digit";
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Container(
                      width: double.maxFinite,
                      height: 50,
                      padding: const EdgeInsets.all(5.0),
                      decoration: CustomBoxDecoration.myCustomDecoration(),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: timeController,
                        decoration: const InputDecoration(
                            hintText: "Average time b/w two token in minutes ",
                            contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                            border: InputBorder.none
                        ),
                        style: const TextStyle(fontSize: 14),
                        validator: (val) {
                          if (val!.isEmpty) {
                            return "Token b/w two in minutes cannot be empty";
                          } else if (val.length < 4) {
                            return "Please enter must 5 digit";
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  // const Text("Select Time"),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  Card(
                    elevation: 2,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        icon:  const Icon(Icons.keyboard_arrow_down_rounded,  color:AppColors.fntClr,size: 25,),
                        hint:  const Text('Select Days',
                          style: TextStyle(
                              color: AppColors.fntClr,fontWeight: FontWeight.w500,fontSize:12
                          ),),
                        items: items
                            .map((String item) => DropdownMenuItem<String>(
                          value: item,
                          child: Text(
                            item,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: AppColors.fntClr,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                            .toList(),
                        value: selectedValue,
                        onChanged: (String? value) {
                          setState(() {
                            selectedValue = value;
                          });
                        },

                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("From Time",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
                              Container(
                                decoration: BoxDecoration(
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(10)
                                ),
                                child: TextFormField(
                                  readOnly: true,
                                  onTap: () async {
                                    TimeOfDay? pickedTime = await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );

                                    if (pickedTime != null) {
                                      print(pickedTime.format(context)); // Output: 10:51 PM

                                      // Construct a DateTime object with today's date and the picked time
                                      DateTime currentTime = DateTime.now();
                                      DateTime combinedDateTime = DateTime(
                                        currentTime.year,
                                        currentTime.month,
                                        currentTime.day,
                                        pickedTime.hour,
                                        pickedTime.minute,
                                      );

                                      print(combinedDateTime); // Output: 2024-01-11 22:53:00.000

                                      // Format the DateTime object as per your requirement
                                      String formattedTime = DateFormat('hh:mm a').format(combinedDateTime);
                                      print(formattedTime); // Output: 10:53 PM

                                      endTimeC.text = formattedTime;
                                      setState(() {
                                        // Update the UI or perform any other necessary actions
                                      });
                                    } else {
                                      print("Time is not selected");
                                    }
                                  },
                                  controller: endTimeC,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: AppColors.whit,
                                    filled: true,
                                    hintText: "From Time",
                                    counterText: '',
                                    labelStyle: TextStyle(color: Colors.black87),
                                    // prefixIcon: IconButton(
                                    //   onPressed: null,
                                    //   icon: Icon(
                                    //     Icons.call,
                                    //     color: MyColorName.primaryDark,
                                    //   ),
                                    // ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                        color: AppColors.secondary,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 10,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text("To Time",style: TextStyle(color: AppColors.fntClr,fontWeight: FontWeight.bold),),
                              const SizedBox(height: 5,),
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(),
                                  borderRadius: BorderRadius.circular(10)
                                ),
                                child: TextFormField(

                                  readOnly: true,
                                  onTap: () async {
                                    TimeOfDay? pickedTime = await showTimePicker(
                                      initialTime: TimeOfDay.now(),
                                      context: context,
                                    );

                                    if (pickedTime != null) {
                                      print(pickedTime.format(context)); // Output: 10:51 PM

                                      // Construct a DateTime object with today's date and the picked time
                                      DateTime currentTime = DateTime.now();
                                      DateTime combinedDateTime = DateTime(
                                        currentTime.year,
                                        currentTime.month,
                                        currentTime.day,
                                        pickedTime.hour,
                                        pickedTime.minute,
                                      );

                                      print(combinedDateTime); // Output: 2024-01-11 22:53:00.000

                                      // Format the DateTime object as per your requirement
                                      String formattedTime = DateFormat('hh:mm a').format(combinedDateTime);
                                      print(formattedTime); // Output: 10:53 PM

                                      starTimeC.text = formattedTime;
                                      setState(() {
                                        // Update the UI or perform any other necessary actions
                                      });
                                    } else {
                                      print("Time is not selected");
                                    }
                                  },

                                  controller: starTimeC,
                                  keyboardType: TextInputType.number,
                                  maxLength: 10,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    fillColor: AppColors.whit,
                                    filled: true,
                                    hintText: "To Time",
                                    counterText: '',
                                    labelStyle: TextStyle(color: Colors.black87),
                                    // prefixIcon: IconButton(
                                    //   onPressed: null,
                                    //   icon: Icon(
                                    //     Icons.call,
                                    //     color: MyColorName.primaryDark,
                                    //   ),
                                    // ),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.primary,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: const BorderSide(
                                        color: AppColors.secondary,
                                      ),
                                      borderRadius: BorderRadius.circular(8.0),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),





                        // morningShift(),


                      ],
                    ),
                  ),



                ],
              ),
            )));
  }
  String? catId;
  SignUpCat? animalCat;
  GetCatModel ? getCatModel;
  Future<void> getCat() async {
    var param = {
      'app_key': ""
    };
    apiBaseHelper.postAPICall(getCatAPI, param).then((getData) {
      String msg = getData['message'];
      getCatModel = GetCatModel.fromJson(getData);

       setState(() {
         Fluttertoast.showToast(msg: msg);
       });
    });
  }
  GetSubscriptionModel? getSubscriptionModel;
  addSubPlan(String pId) async {
    var headers = {
      'Cookie': 'ci_session=3c92729c33e9e6a6b76655065e1d039d1143a7a9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/add_subscription'));

    request.fields.addAll({
      'user_id': userId.toString(),
      'plan_id':pId,
    });
    print('_____request.fields_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var  result = await response.stream.bytesToString();
      var finalResult = jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      Navigator.push(context, MaterialPageRoute(builder: (context)=>CreateTokenScreen()));
   //   Navigator.pop(context);
    }
    else {
    print(response.reasonPhrase);
    }
  }

  addToken() async {
    var headers = {
      'Cookie': 'ci_session=a3f6c3c57d246096cf641e253ca83fd18f2258a9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/create_token'));
    request.fields.addAll({
      'user_id':userId.toString(),
      'category': animalCat!.id.toString(),
      'time_per_client':timeController.text,
      'from_time':endTimeC.text,
      'to_time':starTimeC.text,
      'user_name':nameController.text,
      'date':selectedValue.toString(),
    });
    print('_____ddddddddddd_____${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var result = await response.stream.bytesToString();
      var finalResult  = jsonDecode(result);
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
    }
    else {
    print(response.reasonPhrase);
    }
  }
  TimeOfDay? _selectedTime ;
  TimeOfDay? _selectedTime1;
  Widget morningShift() {
    return InkWell(
      onTap: () {
        _selectTime(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTime != null
                  ? '${_selectedTime!.format(context)}'
                  : 'From Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  Widget eveningShift() {
    return  InkWell(
      onTap: () {
        _chooseTime(context);
      },
      child: Container(
        // Customize the container as needed
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              _selectedTime1 != null
                  ? '${_selectedTime1!.format(context)}'
                  : 'To Time',
            ),
            Icon(Icons.arrow_drop_down),
          ],
        ),
      ),
    );
  }
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime) {

      setState(() {
        _selectedTime = pickedTime;
      });
    }

  }
  Future<void> _chooseTime(BuildContext context) async {
    final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: _selectedTime1 ?? TimeOfDay.now(),
    ) as TimeOfDay;

    if (pickedTime != null && pickedTime != _selectedTime1) {
      setState(() {
        _selectedTime1 = pickedTime;
      });
    }
  }

  final List<String> items = [
    'Today',
    'Tomorrow',
  ];
  String? selectedValue;
}
