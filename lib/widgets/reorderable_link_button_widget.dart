import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_project/constants/constants.dart';

import '../controllers/app_controller.dart';
import '../helpers/api_helper.dart';

class ReorderableLinkButtonWidget extends StatefulWidget {
  ReorderableLinkButtonWidget({Key? key, required this.link, required this.title}) : super(key: key);
  final String link;
  final String title;

  @override
  State<ReorderableLinkButtonWidget> createState() => _ReorderableLinkButtonWidgetState();
}

class _ReorderableLinkButtonWidgetState extends State<ReorderableLinkButtonWidget> {
  final AppController _controller = Get.find<AppController>();

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
      padding: const EdgeInsets.only(top: 6,bottom: 6,left: 15,right: 15),
      height: 55,
      color: Colors.white,
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
            width: _controller.width -200,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                Text(widget.link,style: const TextStyle(fontSize: 12,color: Colors.black45,overflow: TextOverflow.ellipsis),maxLines: 1,softWrap: false,),
              ],
            ),
          )
        ],
      ),
    );
  }
}
