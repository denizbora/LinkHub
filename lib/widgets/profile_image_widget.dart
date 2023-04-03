import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_project/screens/LinkPage/link_page_app_controller.dart';
import 'package:link_project/screens/LinkPage/link_page_cotroller.dart';

import '../constants/constants.dart';

class ProfileImageWidget extends StatelessWidget {
  ProfileImageWidget({Key? key, required this.profileImg, required this.userName, required this.biography}) : super(key: key);
  final LinkPageAppController _controller = Get.find<LinkPageAppController>();
  final LinkPageController _userController = Get.find<LinkPageController>();
  final String profileImg;
  final String userName;
  final String biography;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: _controller.width * 0.2,
          height: _controller.width * 0.2,
          decoration: (profileImg != "") ? BoxDecoration(
              borderRadius: BorderRadius.circular(_controller.width * 0.33),
              color: Constants().userProfileBg,
              image: DecorationImage(image: NetworkImage(profileImg))
          ):BoxDecoration(
            borderRadius: BorderRadius.circular(_controller.width * 0.33),
            color: const Color.fromRGBO(96, 105, 108, 1),
          ),
          child: Center(
              child: (profileImg != "") ? Container() : SelectableText(
                userName[0].toUpperCase(),
                style: TextStyle(
                    color: Colors.white, fontSize: _controller.width * 0.08),
              )),
        ),
        Container(
            margin: const EdgeInsets.all(20),
            child: Column(
              children: [
                SelectableText(
                  userName,
                  style: TextStyle(
                      color: Color(int.parse(_userController.user.userNameColor!)),
                      fontSize: _controller.width * 0.04,
                      fontWeight: FontWeight.w700),
                ),
                (biography!="") ? SelectableText(
                  biography,
                  style: TextStyle(
                      color: Color(int.parse(_userController.user.biographyColor!)),
                      fontSize: _controller.width * 0.028,
                      fontWeight: FontWeight.w500),
                ):const SizedBox(),
              ],
            )),
      ],

    );
  }
}
