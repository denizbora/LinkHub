import 'package:file_picker/_internal/file_picker_web.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_project/controllers/user_controller.dart';
import 'package:link_project/helpers/authentication_helper.dart';
import 'package:link_project/screens/login_page.dart';

import '../constants/constants.dart';
import '../controllers/app_controller.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final AppController _appController = Get.find<AppController>();
  final UserController _userController = Get.find<UserController>();
  TextEditingController nameController = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController passswordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    nameController.text = _userController.usr.name!;
    bioController.text = _userController.usr.biography!;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: _appController.width,
      height: Get.height -
          kBottomNavigationBarHeight -
          kToolbarHeight,
      color: Constants().backgroundColor,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.only(bottom: 15),
            width: _appController.width,
            decoration: BoxDecoration(
                color: Constants().cardColor,
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              children: [
                SizedBox(
                  height:_appController.width * 0.3,
                  width: _appController.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: _appController.width * 0.25,
                        height: _appController.width * 0.25,
                        decoration: (_userController.usr.profileImg != "") ? BoxDecoration(
                            borderRadius: BorderRadius.circular(_appController.width * 0.33),
                            color: Constants().userProfileBg,
                            image: DecorationImage(image: NetworkImage(_userController.usr.profileImg!))
                        ):BoxDecoration(
                          borderRadius: BorderRadius.circular(_appController.width * 0.33),
                          color: const Color.fromRGBO(96, 105, 108, 1),
                        ),
                        child: Center(
                            child: (_userController.usr.profileImg != "") ? Container() : Text(
                              _userController.usr.userName![0].toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white, fontSize: _appController.width * 0.08),
                            )),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () async {
                              FilePickerResult? result = await FilePickerWeb.platform.pickFiles();
                              if (result != null) {
                                Uint8List? fileBytes = result.files.first.bytes;
                                String fileName = result.files.first.name;
                                String filetype = fileName.split('.').last;
                                var task = await FirebaseStorage.instance.ref('uploads/${AuthenticationHelper().getUid()}.$filetype').putData(fileBytes!);
                                String url = await task.ref.getDownloadURL();
                                setState(() {
                                  _userController.usr.profileImg = url;
                                  _userController.updateUsr();
                                });
                              }
                            },
                            child: Container(
                              width: _appController.width * 0.45,
                              height: _appController.width * 0.12,
                              decoration: BoxDecoration(
                                  color: const Color.fromRGBO(8, 162, 241, 1),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: const Center(child: Text("Upload Image",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
                            ),
                          ),
                          InkWell(
                            onTap: (){
                              setState(() {
                                FirebaseStorage.instance.refFromURL(_userController.usr.profileImg!).delete();
                                _userController.usr.profileImg = "";
                                _userController.updateUsr();
                              });
                            },
                            child: Container(
                              width: _appController.width * 0.45,
                              height: _appController.width * 0.12,
                              decoration: BoxDecoration(
                                  border: Border.all(color:const Color.fromRGBO(8, 162, 241, 1)),
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: const Center(child: Text("Remove",style: TextStyle(color: Color.fromRGBO(8, 162, 241, 1),fontWeight: FontWeight.w600),)),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.only(top: 15,bottom: 15),
                    child: TextFormField(
                      controller: nameController,
                        maxLines: 1,
                        minLines: 1,
                        decoration: InputDecoration(
                          labelText: "Name",
                          alignLabelWithHint: true,
                          fillColor: const Color.fromRGBO(243, 242, 243, 1),
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          border: OutlineInputBorder(
                            borderRadius:
                            BorderRadius.circular(10.0), // Kenar yuvarlatma
                            borderSide: BorderSide.none, // Alt çizgi yok
                          ),
                        )

                    )),
                TextFormField(
                  controller: bioController,
                    maxLines: 4,
                    minLines: 4,
                    decoration: InputDecoration(
                      labelText: "Bio",
                      alignLabelWithHint: true,
                      fillColor: const Color.fromRGBO(243, 242, 243, 1),
                      filled: true,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 15.0),
                      border: OutlineInputBorder(
                        borderRadius:
                        BorderRadius.circular(10.0), // Kenar yuvarlatma
                        borderSide: BorderSide.none, // Alt çizgi yok
                      ),
                    )

                ),
                const SizedBox(height: 15,),
                InkWell(
                  onTap: (){
                    _userController.usr.name = nameController.text;
                    _userController.usr.biography = bioController.text;
                    _userController.updateUsr();
                  },
                  child: Container(
                    width: _appController.width * 0.45,
                    height: 50,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(8, 162, 241, 1),
                        borderRadius: BorderRadius.circular(30)
                    ),
                    child: const Center(child: Text("Save",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(30),
            margin: const EdgeInsets.only(bottom: 15),
            width: _appController.width,
            decoration: BoxDecoration(
                color: Constants().cardColor,
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Change Password",style: TextStyle(fontWeight: FontWeight.w600),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 15,bottom: 15),
                      width: _appController.width * 0.4,
                      child: TextFormField(
                          obscureText: true,
                          controller: passswordController,
                          decoration: InputDecoration(
                            labelText: "New Password",
                            alignLabelWithHint: true,
                            fillColor: const Color.fromRGBO(243, 242, 243, 1),
                            filled: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 15.0),
                            border: OutlineInputBorder(
                              borderRadius:
                              BorderRadius.circular(10.0), // Kenar yuvarlatma
                              borderSide: BorderSide.none, // Alt çizgi yok
                            ),
                          )

                      ),
                    ),
                    InkWell(
                      onTap: (){
                        if(passswordController.text.isNotEmpty){
                          AuthenticationHelper().changePassword(passswordController.text);
                          showDialog(context: context, builder: (context){
                            return AlertDialog(
                              title: Text("Password Changed"),
                              content: Text("Your password has been successfully changed."),
                              actions: [
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    // Close the dialog
                                    Get.back();
                                  },
                                ),
                              ],
                            );
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.only(top: 15,bottom: 15),
                        width: _appController.width * 0.4,
                        decoration: BoxDecoration(
                            color: const Color.fromRGBO(8, 162, 241, 1),
                            borderRadius: BorderRadius.circular(30)
                        ),
                        child: const Center(child: Text("Save",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),))
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        const Text("Logout",style: TextStyle(fontWeight: FontWeight.w600),),
                        const SizedBox(height: 15,),
                        InkWell(
                          onTap: (){
                            AuthenticationHelper().logOut();
                            Get.offAllNamed("/");
                          },
                          child: Container(
                              padding: const EdgeInsets.only(top: 15,bottom: 15),
                              width: _appController.width * 0.4,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: const Center(child: Text("Logout",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),))
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Text("Delete Account",style: TextStyle(fontWeight: FontWeight.w600),),
                        const SizedBox(height: 15,),
                        InkWell(
                          onTap: (){
                            showDialog(context: context, builder: (context){
                              return AlertDialog(
                                title: const Text("Are You Sure?"),
                                actions: [
                                  TextButton(onPressed: (){
                                    Get.back();
                                  }, child: const Text("No")),
                                  TextButton(onPressed: (){
                                    AuthenticationHelper().deleteUser();
                                    Get.offAllNamed("/");
                                  }, child: const Text("Yes"))
                                ],
                              );
                            });
                          },
                          child: Container(
                              padding: const EdgeInsets.only(top: 15,bottom: 15),
                              width: _appController.width * 0.4,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(30)
                              ),
                              child: const Center(child: Text("Delete",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),))
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
