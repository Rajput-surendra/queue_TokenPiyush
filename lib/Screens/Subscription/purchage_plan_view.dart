import 'dart:convert';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/get_purchage_plan_model.dart';
import '../../Models/HomeModel/signUp_cat_model.dart';

import 'package:http/http.dart' as http;

import '../../Models/get_counter_model.dart';
import '../../Models/get_sub_plan_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Utils/extentions.dart';

class SubscriptionPlanListScreen extends StatefulWidget {
  SubscriptionPlanListScreen({Key? key,}) : super(key: key);
  @override
  State<SubscriptionPlanListScreen> createState() => _SubscriptionPlanListScreenState();
}

class _SubscriptionPlanListScreenState extends State<SubscriptionPlanListScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();

  }
  String? userId;
  getUserId() async {
    userId = await SharedPre.getStringValue('userId');
    getSubPlan();
    setState(() {});
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
            "Subscription Plan ",
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
            child: Container(
          height: MediaQuery.of(context).size.height / 1.1,
          child:getPlanListModel == null ? const Center(child: CircularProgressIndicator(color: AppColors.secondary,)): ListView.builder(
              itemCount: getPlanListModel!.data!.length,
              itemBuilder: (c, i) {
                pId = getPlanListModel!.data![i].id;
                return Card(
                    margin: const EdgeInsets.all(16.0),
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              "${getPlanListModel!.data![i].title}",
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                             Text(
                              "₹ ${getPlanListModel!.data![i].price}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 12.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Start Date :",style: TextStyle(
                                  fontSize: 18.0,
                                ),),
                                Text(
                                  '${getPlanListModel!.data![i].startDate!.substring(0,11)}',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("End Date :",style: TextStyle(
                                  fontSize: 18.0,
                                ),),
                                Text(
                                  '${getPlanListModel!.data![i].endDate!}',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 5.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text("Status :",style: TextStyle(
                                  fontSize: 18.0,
                                ),),
                                Text(
                                  '${getPlanListModel!.data![i].status!}',
                                  style: const TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),

                          ],
                        )));
              }),
        )));
  }

  GetPlanListModel? getPlanListModel;
  getSubPlan() async {
    var headers = {
      'Cookie': 'ci_session=3c92729c33e9e6a6b76655065e1d039d1143a7a9'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/my_subscription'));

    request.fields.addAll({
      'user_id': userId.toString(),
    });
    print('____request.fields______${request.fields}_________');
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      var  result = await response.stream.bytesToString();
      var finalResult = GetPlanListModel.fromJson(json.decode(result));
      setState(() {
        getPlanListModel =  finalResult ;
      });
      Fluttertoast.showToast(msg: "${finalResult.message}");
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
