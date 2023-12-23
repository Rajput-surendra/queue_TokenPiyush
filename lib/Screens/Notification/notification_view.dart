import 'package:booknplay/Utils/Colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationScreen extends StatefulWidget {
  NotificationScreen({Key? key, this.isFrom,this.gId}) : super(key: key);
  final bool? isFrom;
  String? gId;

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {

  @override
  void initState() {
    super.initState();
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
            title: const Text("Notification List",style: TextStyle(fontSize: 17),),
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
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height/1.1,
              child: ListView.builder(
                itemCount: 10,
                  itemBuilder: (context,i){
                return  const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 1,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("This is a Notification"),
                          Text("Hello Surendra"),
                        ],
                      ),
                    ),
                  ),
                );
              }),
            ),
          )

      ),
    ) ;
  }




//   String ?userId;
//   getLottery() async {
//     userId = await SharedPre.getStringValue('userId');
//     var headers = {
//       'Content-Type': 'application/json',
//       'Cookie': 'ci_session=18afbdd33b04ace40a80944d83e9e23e3ab91c3e'
//     };
//     var request = http.Request('POST', Uri.parse('https://developmentalphawizz.com/queue_token/Apicontroller/getLottery'));
//     request.body = json.encode({
//       "game_id": widget.gId,
//       "user_id": userId
//     });
//     print('_____request.body_____${request.body}_________');
//     request.headers.addAll(headers);
//     http.StreamedResponse response = await request.send();
//     if (response.statusCode == 200) {
//       var result = await response.stream.bytesToString();
//       var finalResult  =  LotteryListModel.fromJson(json.decode(result));
//       Fluttertoast.showToast(msg: "${finalResult.msg}");
//       setState(() {
//         lotteryDetailsModel = finalResult;
//
//       });
//     }
//     else {
//       print(response.reasonPhrase);
//     }
//
//   }



}
