import 'dart:convert';

import 'package:booknplay/Constants.dart';
import 'package:booknplay/Screens/Dashboard/dashbord_counter_view.dart';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Utils/custom_clip_path.dart';
import 'package:booknplay/Widgets/app_button.dart';
import 'package:booknplay/Widgets/commen_widgets.dart';
import 'package:booknplay/Widgets/custom_appbar.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/signUp_cat_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Utils/extentions.dart';
import '../../Widgets/button.dart';
import '../Counter/counter_view.dart';
import '../Dashboard/dashboard_view.dart';
import 'package:http/http.dart'as http;
String? catNewId,userName,cityName,cId,dayId;
class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key, this.isFrom}) : super(key: key);
  final bool? isFrom;

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String? catId;
  SignUpCat? animalCat;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCateApi();
    referCode();
  }
  String? userRole;
  referCode() async {
    userRole = await SharedPre.getStringValue('userRole');
    setState(() {

    });
  }
  bool isLodding = false;
  final nameController = TextEditingController();
  final cityController = TextEditingController();
  final counterIdController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.whit,
        appBar: AppBar(
          // leading: InkWell(
          //   onTap: (){
          //     if(userRole == 'user'){
          //       Navigator.push(context,MaterialPageRoute(builder: (context)=>DashBoardScreen()));
          //     }else{
          //       Navigator.push(context,MaterialPageRoute(builder: (context)=>DashBoardCounterScreen()));
          //     }
          //
          //   },
          //     child: const Icon(Icons.arrow_back)),
          automaticallyImplyLeading: false,

          shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(50.0),bottomRight: Radius.circular(50),
            ),),
          toolbarHeight: 60,
          centerTitle: true,
          title: const Text("Search Token",style: TextStyle(fontSize: 17),),
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
          child: Padding(
            padding:  const EdgeInsets.symmetric(horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const SizedBox(height: 15,),
                Container(
                  margin: EdgeInsets.only(left: 3,right: 3),
                  width: double.maxFinite,
                  height: 50,
                  padding: const EdgeInsets.all(5.0),
                  decoration: CustomBoxDecoration.myCustomDecoration(),
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    controller:counterIdController,
                    decoration: const InputDecoration(
                        counterText: "",
                        hintText: "Search by counter Id",hintStyle: TextStyle( color: AppColors.fntClr,fontWeight: FontWeight.w500,fontSize:15),
                        contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                        border: InputBorder.none
                    ),
                    style: const TextStyle(fontSize: 14),

                  ),
                ),
                const SizedBox(height: 5,),
                Center(child: Text("or")),
                const SizedBox(height: 5,),
                Container(
                  margin: EdgeInsets.only(left: 3,right: 3),
                  width: double.maxFinite,
                  height: 50,
                  padding: const EdgeInsets.all(5.0),
                  decoration: CustomBoxDecoration.myCustomDecoration(),
                  child: TextFormField(
                    controller:cityController,
                    decoration: const InputDecoration(
                        hintText: "Search by city name",hintStyle: TextStyle( color: AppColors.fntClr,fontWeight: FontWeight.w500,fontSize:15),
                        contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                        border: InputBorder.none
                    ),
                    style: const TextStyle(fontSize: 14),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "City cannot be empty";
                      } else if (val.length < 5) {
                        return "Please enter must 5 digit";
                      }
                    },
                  ),
                ),


                const SizedBox(height: 15,),
                Container(
                  margin: EdgeInsets.only(left: 3,right: 3),
                  width: double.maxFinite,
                  height: 50,
                  padding: const EdgeInsets.all(5.0),
                  decoration: CustomBoxDecoration.myCustomDecoration(),
                  child: TextFormField(
                    controller:nameController,
                    decoration: const InputDecoration(
                        hintText: "Search by name",hintStyle: TextStyle( color: AppColors.fntClr,fontWeight: FontWeight.w500,fontSize:15),
                        contentPadding: EdgeInsets.only(left: 10,bottom: 5),
                        border: InputBorder.none
                    ),
                    style: const TextStyle(fontSize: 14),
                    validator: (val) {
                      if (val!.isEmpty) {
                        return "Name cannot be empty";
                      } else if (val.length < 5) {
                        return "Please enter must 5 digit";
                      }
                    },
                  ),
                ),
                const SizedBox(height: 15,),
                Container(
                  height: 60,
                  width: double.infinity,
                  child: Card(
                    elevation: 2,
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton2<String>(
                        isExpanded: true,
                        icon:  const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.secondary,size: 30,),
                        hint:  const Text("Select Days",
                          style: TextStyle(
                              color: AppColors.fntClr,fontWeight: FontWeight.w500,fontSize:15
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
                ),

                const SizedBox(height: 15,),
                Container(
                  width: double.infinity,
                  child: Card(
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton2<SignUpCat>(
                          hint:  const Text("Select Category",
                            style: TextStyle(
                                color: AppColors.fntClr,fontWeight: FontWeight.w500,fontSize:15
                            ),),
                          value: animalCat,
                          icon:  const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.secondary,size: 30,),
                          style:  const TextStyle(color: AppColors.secondary,fontWeight: FontWeight.bold),
                          underline: Padding(
                            padding: const EdgeInsets.only(left: 0,right: 0),
                            child: Container(
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
                                          child: Text(items.name.toString(),overflow:TextOverflow.ellipsis,style: const TextStyle(color: AppColors.fntClr),),
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
                const SizedBox(height: 50,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: AppButton1(
                    title:isLodding ? 'Please wait...': 'Get Token',
                    onTap: () {
                      if(cityController.text.isEmpty && nameController.text.isEmpty && counterIdController.text.isEmpty && catId == null ){
                        Fluttertoast.showToast(msg: "Please ablest one select",backgroundColor:AppColors.primary);
                      }else if (selectedValue == null){
                        Fluttertoast.showToast(msg: "Please Select days",backgroundColor:AppColors.primary);
                      }
                      else{
                        getFilterApi();
                      }

                    },
                  ),
                ),
              ],
            ),
          ),
        )
    ) ;
  }
  final List<String> items = [
    'today',
    'tomorrow',
  ];
  String? selectedValue;
  getFilterApi() async {
    setState(() {
      isLodding = true;
    });
  var headers = {
    'Cookie': 'ci_session=052f7198d39c07d7c57fb2fed6a242b3b8aaa2de'
  };
  var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/counters'));
  request.fields.addAll({
    'filter_date':selectedValue.toString(),
    nameController.text.isEmpty ? "":'counter_name':nameController.text,
    cityController.text.isEmpty? "":'counter_city':cityController.text,
    catId == null ? "" : 'counter_category':catId.toString(),
    counterIdController.text.isEmpty ? "":'unique_id':counterIdController.text,

  });
  request.headers.addAll(headers);
  http.StreamedResponse response = await request.send();
  if (response.statusCode == 200) {
     var result =  await response.stream.bytesToString();
     var finalResult =  jsonDecode(result);
      Fluttertoast.showToast(msg: "${finalResult['message']}");
      setState(() {
        userName = nameController.text;
        catNewId = catId;
        cId = counterIdController.text;
        cityName = cityController.text;
        dayId = selectedValue.toString();
        isLodding =  false;
      });

     if(userRole == 'user'){
       Navigator.push(context,MaterialPageRoute(builder: (context)=>DashBoardScreen()));
     }else{
       Navigator.push(context,MaterialPageRoute(builder: (context)=>DashBoardCounterScreen()));
     }
  }
  else {
    setState(() {
      isLodding = false;
    });
  print(response.reasonPhrase);
  }

}


  GetCatModel? getCatModel;
  Future<void> getCateApi() async {
    apiBaseHelper.postAPICall2(getCatAPI).then((getData) {
      getCatModel = GetCatModel.fromJson(getData);
     setState(() {});
      //isLoading.value = false;
    });
  }

}
