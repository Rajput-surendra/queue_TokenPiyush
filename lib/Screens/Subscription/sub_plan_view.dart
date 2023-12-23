import 'dart:convert';
import 'package:booknplay/Utils/Colors.dart';
import 'package:booknplay/Widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/signUp_cat_model.dart';

import 'package:http/http.dart' as http;

import '../../Models/get_counter_model.dart';
import '../../Models/get_sub_plan_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Utils/extentions.dart';

class SubscriptionScreen extends StatefulWidget {
  SubscriptionScreen({
    Key? key,required this.isbool
  }) : super(key: key);
bool isbool;
  @override
  State<SubscriptionScreen> createState() => _SubscriptionScreenState();
}

class _SubscriptionScreenState extends State<SubscriptionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUserId();
    getSubscriptions();
  }

  String? userId;

  getUserId() async {
    userId = await SharedPre.getStringValue('userId');

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
            child:widget.isbool == true ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(child: const Text("6 Month Free Plan...")),
            ): Container(
          height: MediaQuery.of(context).size.height / 1.1,
          child:getSubscriptionModel == null ? const Center(child: CircularProgressIndicator(color: AppColors.secondary,)): ListView.builder(
              itemCount: getSubscriptionModel!.data!.length,
              itemBuilder: (c, i) {
                pId = getSubscriptionModel!.data![i].id;
                return Card(
                    margin: const EdgeInsets.all(16.0),
                    child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                             Text(
                              "${getSubscriptionModel!.data![i].title}",
                              style: const TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 8.0),
                             Text(
                              "₹ ${getSubscriptionModel!.data![i].price}",
                              style: const TextStyle(
                                fontSize: 18.0,
                                color: Colors.green,
                              ),
                            ),
                            const SizedBox(height: 12.0),
                             Text(
                              '${getSubscriptionModel!.data![i].duration} Days',
                              style: const TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [],
                            ),
                            const SizedBox(height: 12.0),
                            ElevatedButton(
                              onPressed: () {
                                addSubPlan(getSubscriptionModel!.data![i].id ?? "");
                              },
                              child: const Text('Subscribe'),
                            ),
                          ],
                        )));
              }),
        )));
  }

  GetSubscriptionModel? getSubscriptionModel;
  Future<void> getSubscriptions() async {
    var param = {'app_key': ""};
    apiBaseHelper.postAPICall(getSubscriptionsAPI, param).then((getData) {
      String msg = getData['message'];
      setState(() {
        getSubscriptionModel = GetSubscriptionModel.fromJson(getData);
      });

      Fluttertoast.showToast(msg: msg);
    });
  }

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
      Navigator.pop(context);
    }
    else {
    print(response.reasonPhrase);
    }

  }
}
