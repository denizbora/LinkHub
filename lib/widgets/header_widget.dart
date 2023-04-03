import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_project/screens/LinkPage/link_page_app_controller.dart';
import 'package:link_project/screens/LinkPage/link_page_cotroller.dart';

class HeaderWidget extends StatelessWidget {
  HeaderWidget({Key? key, required this.title}) : super(key: key);
  final LinkPageAppController _controller = Get.find<LinkPageAppController>();
  final LinkPageController _userController = Get.find<LinkPageController>();
  final String title;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: const EdgeInsets.all(20),
        child: Text(title,
            style: TextStyle(
                color: Color(int.parse(_userController.user.userNameColor!)),
                fontSize: _controller.width * 0.035,
                fontWeight: FontWeight.w700)),
      ),
    );
  }
}
