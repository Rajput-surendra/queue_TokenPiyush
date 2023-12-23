import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../Models/contact_us_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Services/api_services/apiStrings.dart';
import '../../Utils/Colors.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({Key? key, }) : super(key: key);

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getContact();

  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.whit,
        appBar: AppBar(
          shape: const RoundedRectangleBorder(
            borderRadius:  BorderRadius.only(
              bottomLeft: Radius.circular(50.0),bottomRight: Radius.circular(50),
            ),),
          toolbarHeight: 60,
          centerTitle: true,
          title: const Text("Contact Us",style: TextStyle(fontSize: 17),),
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
        body:contactUsModel == null ? Center(child: CircularProgressIndicator(color: AppColors.primary,)): SingleChildScrollView(
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Container(
                width: double.infinity,
                height: 80,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("+91${contactUsModel?.mobile1}"),
                      SizedBox(height: 5,),
                      Text("${contactUsModel?.email1}"),
                      SizedBox(height: 5,),
                      Text("${contactUsModel?.msg}"),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  ContactUsModel?contactUsModel;
  Future<void> getContact() async {
    apiBaseHelper.postAPICall2(getContactAPI).then((getData) {
      setState(() {
        contactUsModel = ContactUsModel.fromJson(getData);
      });

      //isLoading.value = false;
    });
  }
}