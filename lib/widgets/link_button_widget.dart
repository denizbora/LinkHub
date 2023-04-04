import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_project/helpers/api_helper.dart';
import 'package:link_project/screens/LinkPage/link_page_app_controller.dart';
import 'package:link_project/screens/LinkPage/link_page_cotroller.dart';
import 'package:url_launcher/link.dart';
import 'package:url_launcher/url_launcher.dart';

import '../constants/constants.dart';

class LinkButtonWidget extends StatefulWidget {
  LinkButtonWidget({Key? key, required this.link, required this.title, required this.index}) : super(key: key);
  final int index;
  final String link;
  final String title;

  @override
  State<LinkButtonWidget> createState() => _LinkButtonWidgetState();
}

class _LinkButtonWidgetState extends State<LinkButtonWidget> {
  final LinkPageAppController _controller = Get.find<LinkPageAppController>();

  final LinkPageController _userController = Get.find<LinkPageController>();
  String favicon="";

  @override
  void initState() {
    super.initState();
    getFavicon();
  }
  Future<void> getFavicon() async {
    favicon = await ApiHelper().getFavicon(Uri.parse(widget.link).host);
    setState(() {

    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 15,
          right: 15, left: 15),
      child: Link(
        target: LinkTarget.blank,
        uri: Uri.parse(widget.link),
        builder: (BuildContext context, Future<void> Function()? followLink) {
          return InkWell(
          borderRadius: _controller.cardDecorations[_userController.user.buttonStyle]![0].borderRadius,
          onTap: followLink,
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
                          favicon),fit: BoxFit.cover,
                    )),
                const SizedBox(width: 15,),
                SizedBox(
                  width: _controller.width -125,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.title,style: TextStyle(fontSize: 20,fontWeight: FontWeight.w600,color: _controller.cardDecorations[_userController.user.buttonStyle]![1]),),
                      Text(widget.link,style: TextStyle(fontSize: 12,color: _controller.cardDecorations[_userController.user.buttonStyle]![2],overflow: TextOverflow.fade),maxLines: 1,),
                    ],
                  ),
                )
              ],
            ),
          ),
        ); },
      ),
    );
  }
}
