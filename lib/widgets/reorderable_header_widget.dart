import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_project/controllers/app_controller.dart';

class ReorderableHeaderWidget extends StatelessWidget {
  ReorderableHeaderWidget({Key? key, required this.title}) : super(key: key);
  final AppController _controller = Get.find<AppController>();
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Text(title,
          style: TextStyle(
              color: Colors.black,
              fontSize: _controller.width * 0.05,
              fontWeight: FontWeight.w700)),
    );
  }
}
