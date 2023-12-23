
import 'dart:convert';
import 'dart:io';
import 'package:booknplay/Services/api_services/apiConstants.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart'as http;
import 'package:booknplay/Widgets/button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Local_Storage/shared_pre.dart';
import '../../Models/HomeModel/get_profile_model.dart';
import '../../Utils/Colors.dart';

class EditProfileScreen extends StatefulWidget {
   EditProfileScreen({Key? key,this.getProfileModel}) : super(key: key);
 final GetProfileModel? getProfileModel;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {

  @override
  void initState() {
    // TODO: implement initState
    nameController.text = widget.getProfileModel?.profile?.userName ?? "" ;
    mobileController.text = widget.getProfileModel?.profile?.mobile ?? "" ;
    cityController.text = widget.getProfileModel?.profile?.city ?? "" ;
    image = widget.getProfileModel?.profile?.image  ?? '';
    super.initState();

    referCode();
  }
  String? userId;
  referCode() async {
    userId = await SharedPre.getStringValue('userId');


  }
    String ? image;
  final ImagePicker _picker = ImagePicker();
  bool isEditProfile = false ;
  File? imageFile;
  TextEditingController nameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  Future<bool> showExitPopup1() async {
    return await showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: Text('Select Image'),
          content: Row(
            // crossAxisAlignment: CrossAxisAlignment.s,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton(
                onPressed: () {
                  getImage(ImageSource.camera, context, 1);
                },
                child: Text('Camera'),
              ),
               SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  getImageCmera(ImageSource.gallery,context,1);
                },
                child: Text('Gallery'),
              ),
            ],
          )),
    ) ; //if showDialouge had returned null, then return false
  }

  void requestPermission(BuildContext context,int i) async{
    print("okay");
    Map<Permission, PermissionStatus> statuses = await [
      Permission.photos,
      Permission.mediaLibrary,
      Permission.storage,
    ].request();
    if(statuses[Permission.photos] == PermissionStatus.granted&& statuses[Permission.mediaLibrary] == PermissionStatus.granted){
      getImage(ImageSource.gallery, context, 1);


    }else{
      getImageCmera(ImageSource.camera,context,1);
    }
  }
  Future getImage(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(
      source: source,
      imageQuality: 50
    );
    setState(() {
      imageFile = File(image!.path);
    });

    Navigator.pop(context);
  }
  Future getImageCmera(ImageSource source, BuildContext context, int i) async {
    var image = await ImagePicker().pickImage(
      source: source,
        imageQuality: 50
    );
    setState(() {
      imageFile = File(image!.path);
    });
    Navigator.pop(context);
  }
  void getCropImage(BuildContext context, int i, var image) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
      sourcePath: image.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
    );
    setState(() {
      if (i == 1) {
        imageFile = File(croppedFile!.path.toString());
      }

    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whit,
      appBar: AppBar(
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
          },
            child: Icon(Icons.arrow_back_ios)),
        automaticallyImplyLeading: false,
        shape: const RoundedRectangleBorder(
          borderRadius:  BorderRadius.only(
            bottomLeft: Radius.circular(50.0),bottomRight: Radius.circular(50),
          ),),
        toolbarHeight: 60,
        centerTitle: true,
        title: Text("Update Profile",style: TextStyle(fontSize: 17),),
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20,),
              Stack(
                  children:[
                    imageFile == null
                        ?  SizedBox(
                      height: 110,
                      width: 110,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50)
                        ),
                        elevation: 5,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image.network(image!, fit: BoxFit.cover,)
                          // Image.file(imageFile!,fit: BoxFit.fill,),
                        ),
                      ),
                    ) :

                    Container(
                      height: 100,
                      width: 100,
                      child: ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(100),
                          child: Image.file(imageFile ?? File(''),fit: BoxFit.fill)
                        // Image.file(imageFile!,fit: BoxFit.fill,),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        // top: 30,
                        child: InkWell(
                          onTap: (){
                            showExitPopup1();
                            // showExitPopup(isFromProfile ?? false);
                          },
                          child: Container(
                              height: 30,width: 30,
                              decoration: BoxDecoration(
                                  color: AppColors.primary,
                                  borderRadius: BorderRadius.circular(50)
                              ),
                              child: Icon(Icons.camera_enhance_outlined,color: Colors.white,)),
                        ))
                  ]
              ),
              SizedBox(height: 10,),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: nameController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Name'),

                  ),
                ),
              ),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    keyboardType: TextInputType.name,
                    controller: cityController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        hintText: 'Enter city'),

                  ),
                ),
              ),
              Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    readOnly: true,
                    keyboardType: TextInputType.number,
                    controller: mobileController,
                    decoration: const InputDecoration(
                        contentPadding: EdgeInsets.only(top: 5,left: 10),
                        border: OutlineInputBorder(),
                        hintText: 'Enter mobile'),

                  ),
                ),
              ),
              SizedBox(height: 20,),
              AppButton1(
                   title: isEditProfile == true ? "please wait...":"Edit Profile",
                onTap: (){
                     // if(cityController.text.isEmpty ){
                     //
                     // }
                  updateProfile();
                },
              )

            ],
          ),
        ),
      ) ,
    );
  }

  updateProfile() async {
    setState(() {
      isEditProfile =  true;
    });
    var headers = {
      'Cookie': 'ci_session=df5385d665217dba30014022ebc9598ab69bb28d'
    };
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl1/Apicontroller/apiProfileUpdate'));
    request.fields.addAll({
      'user_name':nameController.text,
      'city':cityController.text,
      'user_id':userId.toString()
    });
    print('____request.fields______${request.fields}_________');
    if(imageFile != null){
      request.files.add(await http.MultipartFile.fromPath('image', imageFile?.path ?? ''));
    }
    request.headers.addAll(headers);
    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
    var result =  await response.stream.bytesToString();
    var finalResult = jsonDecode(result);
    Fluttertoast.showToast(msg:"${finalResult['msg']}" );
    setState(() {
      isEditProfile =  false;
    });
    Navigator.pop(context);
    }
    else {
      setState(() {
        isEditProfile =  false;
      });
    print(response.reasonPhrase);
    }


  }
}
