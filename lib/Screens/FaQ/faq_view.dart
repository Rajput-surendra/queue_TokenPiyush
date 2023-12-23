import 'package:booknplay/Services/api_services/apiStrings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../Models/get_faq_model.dart';
import '../../Services/api_services/apiConstants.dart';
import '../../Utils/Colors.dart';

class FaqScreen extends StatefulWidget {
  const FaqScreen({Key? key, }) : super(key: key);

  @override
  State<FaqScreen> createState() => _FaqScreenState();
}

class _FaqScreenState extends State<FaqScreen> {
  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getFaq();
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
          title: const Text("Faq",style: TextStyle(fontSize: 17),),
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
        body:
        faqModel == null ? Center(child: CircularProgressIndicator()):  faqModel?.faqs?.length == 0 ?Text("No Faqs"): Container(
          height: MediaQuery.of(context).size.height/1,
          child: ListView.builder(
            key: Key('builder ${selected.toString()}'),
            itemCount:faqModel?.faqs?.length ?? 0,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(0),
                      border: Border.all(color: AppColors.fntClr)
                  ),
                  child: ExpansionTile(

                    textColor: AppColors.fntClr,
                    iconColor: AppColors.fntClr,
                    collapsedTextColor: AppColors.whit,
                    collapsedIconColor: AppColors.whit,
                    collapsedBackgroundColor: AppColors.secondary,
                    key:  Key(index.toString()),
                    initiallyExpanded: index == selected ,
                    title: Row(
                      children: [

                        Text('${faqModel?.faqs?[index].question}'),
                       // Text('${faqModel?.faqs?[index].answer}'),
                      ],
                    ),
                    onExpansionChanged: (isExpanded) {

                      if(isExpanded) {
                        setState(()  {
                          const Duration(milliseconds: 2000);
                          selected = index;
                        });

                      }else{
                        setState(() {
                          selected = -1;
                        });

                      }


                    },
                    children:[

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                            width: 350,
                            child: Text("${faqModel?.faqs?[index].answer}",overflow: TextOverflow.ellipsis,maxLines: 10,style: TextStyle(color: AppColors.fntClr),)),
                      )

                    ],
                  ),

                ),

              );

            },

          ),
        ),

      ),
    );
  }
  int? selected = 0;
  FaqModel?faqModel;
  Future<void> getFaq() async {
    apiBaseHelper.postAPICall2(getFagsAPI).then((getData) {
      setState(() {
        faqModel = FaqModel.fromJson(getData);
      });

      //isLoading.value = false;
    });
  }
}