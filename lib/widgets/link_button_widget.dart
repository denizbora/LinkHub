import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_project/screens/LinkPage/link_page_app_controller.dart';
import 'package:link_project/screens/LinkPage/link_page_cotroller.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants.dart';

class LinkButtonWidget extends StatelessWidget {
  LinkButtonWidget({Key? key, required this.link, required this.title, required this.index}) : super(key: key);
  final int index;
  final String link;
  final String title;
  final LinkPageAppController _controller = Get.find<LinkPageAppController>();
  final LinkPageController _userController = Get.find<LinkPageController>();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15,
          right: 15, left: 15),
      child: InkWell(
        borderRadius: _controller.cardDecorations[_userController.user.buttonStyle]![0].borderRadius,
        onTap: () async {
          var field = _userController.fields[index];
          field.click = field.click! + 1;
          _userController.updateField(field);
          await launchUrl(Uri.parse(link));
        },
        child: Ink(
          padding: const EdgeInsets.only(top: 6,bottom: 6,left: 15,right: 15),
          width: _controller.width - 30,
          height: 58,
          decoration: _controller.cardDecorations[_userController.user.buttonStyle]![0],
          child: Row(
            children: [
              Container(
                  width: 40,
                  height: 40,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Constants().userProfileBg
                  ),
                  child: Image(width: 30,
                    image: NetworkImage(
                        "http://${Uri.parse(link).host}/favicon.ico"),fit: BoxFit.cover,
                  )),
              const SizedBox(width: 15,),
              SizedBox(
                width: _controller.width -125,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: _controller.cardDecorations[_userController.user.buttonStyle]![1]),),
                    Text(link,style: TextStyle(fontSize: 12,color: _controller.cardDecorations[_userController.user.buttonStyle]![2],overflow: TextOverflow.fade),maxLines: 1,softWrap: false,),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}