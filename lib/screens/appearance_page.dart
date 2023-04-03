import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:link_project/controllers/user_controller.dart';

import '../constants/constants.dart';
import '../controllers/app_controller.dart';

class AppearancePage extends StatefulWidget {
  const AppearancePage({Key? key}) : super(key: key);

  @override
  State<AppearancePage> createState() => _AppearancePageState();
}

class _AppearancePageState extends State<AppearancePage> {
  final AppController _appController = Get.find<AppController>();
  final UserController _userCcontroller = Get.find<UserController>();
  int _selectedCardDecorationIndex = 0;

  @override
  void initState() {
    super.initState();
    _selectedCardDecorationIndex = _appController.cardDecorations.keys.toList().indexOf(_userCcontroller.usr.buttonStyle!);
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
            margin: const EdgeInsets.only(bottom: 15),
            padding: const EdgeInsets.all(30),
            width: _appController.width,
            decoration: BoxDecoration(
                color: Constants().cardColor,
                borderRadius: BorderRadius.circular(25)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: _appController.width * 0.2,
                  child: Column(
                    children: [
                      const Text("Background Color",style: TextStyle(fontWeight: FontWeight.w600),),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15,top: 15),
                        child: InkWell(

                          onTap: (){
                            showDialog(context: context, builder: (context){
                              Color pickerColor = Color(int.parse(_userCcontroller.usr.backgroundColor!));
                              return AlertDialog(
                                title: const Text('Pick a color!'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: pickerColor,
                                    onColorChanged: (value){setState(() {
                                      pickerColor=value;
                                    });},
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Save'),
                                    onPressed: () {
                                      setState(() => _userCcontroller.usr.backgroundColor = "0${pickerColor.toString().split('Color(0')[1].toString().split(')')[0].toString()}");
                                      _userCcontroller.updateUsr();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 80,
                            decoration: BoxDecoration(
                              color: Color(int.parse(_userCcontroller.usr.backgroundColor!)),
                              border: Border.all(color:Colors.black),
                              borderRadius: BorderRadius.circular(8)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: _appController.width * 0.2,
                  child: Column(
                    children: [
                      const Text("Profile Title Color",style: TextStyle(fontWeight: FontWeight.w600),),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15,top: 15),
                        child: InkWell(
                          onTap: (){
                            showDialog(context: context, builder: (context){
                              Color pickerColor = Color(int.parse(_userCcontroller.usr.userNameColor!));
                              return AlertDialog(
                                title: const Text('Pick a color!'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: pickerColor,
                                    onColorChanged: (value){setState(() {
                                      pickerColor=value;
                                    });},
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Save'),
                                    onPressed: () {
                                      setState(() => _userCcontroller.usr.userNameColor = "0${pickerColor.toString().split('Color(0')[1].toString().split(')')[0].toString()}");
                                      _userCcontroller.updateUsr();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Color(int.parse(_userCcontroller.usr.userNameColor!)),
                                border: Border.all(color:Colors.black),
                                borderRadius: BorderRadius.circular(8)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: _appController.width * 0.2,
                  child: Column(
                    children: [
                      const Text("Bio Color",style: TextStyle(fontWeight: FontWeight.w600),),
                      Container(
                        margin: const EdgeInsets.only(bottom: 15,top: 15),
                        child: InkWell(
                          onTap: (){
                            showDialog(context: context, builder: (context){
                              Color pickerColor = Color(int.parse(_userCcontroller.usr.biographyColor!));
                              return AlertDialog(
                                title: const Text('Pick a color!'),
                                content: SingleChildScrollView(
                                  child: ColorPicker(
                                    pickerColor: pickerColor,
                                    onColorChanged: (value){setState(() {
                                      pickerColor=value;
                                    });},
                                  ),
                                ),
                                actions: <Widget>[
                                  ElevatedButton(
                                    child: const Text('Save'),
                                    onPressed: () {
                                      setState(() => _userCcontroller.usr.biographyColor = "0${pickerColor.toString().split('Color(0')[1].toString().split(')')[0].toString()}");
                                      _userCcontroller.updateUsr();
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            });
                          },
                          child: Container(
                            width: 60,
                            height: 80,
                            decoration: BoxDecoration(
                                color: Color(int.parse(_userCcontroller.usr.biographyColor!)),
                                border: Border.all(color:Colors.black),
                                borderRadius: BorderRadius.circular(8)
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(30),
            width: _appController.width,
            decoration: BoxDecoration(
                color: Constants().cardColor,
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Button Styles",style: TextStyle(fontWeight: FontWeight.w600),),
                Row(
                  children: [
                    Radio(
                      value: 0,
                      groupValue: _selectedCardDecorationIndex,
                      onChanged: (value) {
                        setState(() {
                          _selectedCardDecorationIndex = value!;
                          _userCcontroller.usr.buttonStyle = _appController.cardDecorations.keys.toList()[value];
                          _userCcontroller.updateUsr();
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15,bottom: 15),
                      width: _appController.width * 0.5,
                      height: 50,
                      decoration:_appController.cardDecorations["SoftShadow"]![0],
                      child: const Center(child: Text("Soft Shadow",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 1,
                      groupValue: _selectedCardDecorationIndex,
                      onChanged: (value) {
                        setState(() {
                          _selectedCardDecorationIndex = value!;
                          _userCcontroller.usr.buttonStyle = _appController.cardDecorations.keys.toList()[value];
                          _userCcontroller.updateUsr();
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15,bottom: 15),
                      width: _appController.width * 0.5,
                      height: 50,
                      decoration:_appController.cardDecorations["HardShadow"]![0],
                      child: const Center(child: Text("Hard Shadow",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 2,
                      groupValue: _selectedCardDecorationIndex,
                      onChanged: (value) {
                        setState(() {
                          _selectedCardDecorationIndex = value!;
                          _userCcontroller.usr.buttonStyle = _appController.cardDecorations.keys.toList()[value];
                          _userCcontroller.updateUsr();
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15,bottom: 15),
                      width: _appController.width * 0.5,
                      height: 50,
                      decoration:_appController.cardDecorations["Outline"]![0],
                      child: const Center(child: Text("Outline",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),)),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Radio(
                      value: 3,
                      groupValue: _selectedCardDecorationIndex,
                      onChanged: (value) {
                        setState(() {
                          _selectedCardDecorationIndex = value!;
                          _userCcontroller.usr.buttonStyle = _appController.cardDecorations.keys.toList()[value];
                          _userCcontroller.updateUsr();
                        });
                      },
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 15,bottom: 15),
                      width: _appController.width * 0.5,
                      height: 50,
                      decoration:_appController.cardDecorations["Fill"]![0],
                      child: const Center(child: Text("Filled",style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),)),
                    ),
                  ],
                )
              ],
            )
          ),
          Container(
            margin: const EdgeInsets.only(top: 15),
            padding: const EdgeInsets.all(30),
            width: _appController.width,
            decoration: BoxDecoration(
                color: Constants().cardColor,
                borderRadius: BorderRadius.circular(25)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Border Radius",style: TextStyle(fontWeight: FontWeight.w600),),
                const SizedBox(height: 15,),
                Slider(
                  value: _userCcontroller.usr.borderRadius!,
                  max: 30,
                  min: 0,
                  label: _userCcontroller.usr.borderRadius!.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _userCcontroller.usr.borderRadius = value;
                      _appController.buildDecorations(_userCcontroller.usr);
                    });
                  },
                  onChangeEnd: (value){
                    _userCcontroller.updateUsr();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
