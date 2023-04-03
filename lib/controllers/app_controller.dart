import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_project/classes/my_user.dart';
import 'package:link_project/classes/pages.dart';
import 'package:link_project/screens/appearance_page.dart';
import 'package:link_project/screens/home_page.dart';


import '../screens/settings_page.dart';
class AppController extends GetxController {

  late double width;
  Map<String, List<dynamic>> cardDecorations = <String,List<dynamic>>{};
  List<Pages> pages = [
    Pages("Home", const Icon(Icons.home_outlined), const HomePage()),
    Pages("Appearance", const Icon(Icons.edit_road_outlined), const AppearancePage()),
    Pages("Settings", const Icon(Icons.settings_outlined), const SettingsPage()),
  ];

  AppController(){
    width = (Get.width > 680) ? 680 : Get.width;
  }
  void buildDecorations(MyUser usr){
    cardDecorations =  <String, List<dynamic>>{
      "SoftShadow": [
        BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(usr.borderRadius!),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  color: Color.fromRGBO(0, 0, 0, 0.25))
            ]),
        Colors.black,
        Colors.black54
      ],
      "HardShadow": [
        BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(usr.borderRadius!),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 4,
                  offset: Offset(4, 4),
                  color: Color.fromRGBO(0, 0, 0, 1))
            ]),
        Colors.black,
        Colors.black54
      ],
      "Outline": [
        BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(usr.borderRadius!),
            border: Border.all(color: Colors.black)),
        Colors.black,
        Colors.black54
      ],
      "Fill": [
        BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(usr.borderRadius!),
            boxShadow: const [
              BoxShadow(
                  blurRadius: 4,
                  offset: Offset(0, 2),
                  color: Color.fromRGBO(0, 0, 0, 0.25))
            ]),
        Colors.white,
        Colors.white60
      ]
    };
  }
}