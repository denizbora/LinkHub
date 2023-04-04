import 'package:flutter/material.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:get/get.dart';
import 'package:link_project/constants/constants.dart';
import 'package:link_project/helpers/api_helper.dart';
import 'package:link_project/helpers/authentication_helper.dart';
import 'package:link_project/screens/LinkPage/link_page_app_controller.dart';
import 'package:link_project/screens/LinkPage/link_page_cotroller.dart';
import 'package:link_project/widgets/header_widget.dart';
import 'package:link_project/widgets/link_button_widget.dart';
import 'package:link_project/widgets/profile_image_widget.dart';

import '../../classes/field.dart';

class LinkPage extends StatefulWidget {
  const LinkPage({Key? key, this.username}) : super(key: key);
  final String? username;

  @override
  State<LinkPage> createState() => _LinkPageState();
}

class _LinkPageState extends State<LinkPage> {
  final LinkPageAppController _appController = Get.find<LinkPageAppController>();
  final LinkPageController _pageController = Get.find<LinkPageController>();
  bool first = true;

  @override
  void initState() {
    super.initState();
    checkLink();
  }

  Future checkLink() async {
    if(await AuthenticationHelper().checkUser(widget.username!)){
      Get.offAllNamed("/");
    }
  }


  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
      if(_pageController.fields.isNotEmpty){
        if(first) {
          _pageController.user.totalViews = _pageController.user.totalViews! + 1;
          _pageController.updateUsr();
          _appController.buildDecorations(_pageController.user);
          first = false;
        }
      }
    }));
    return Title(
      color: Constants().backgroundColor,
      title: "LinkHub | ${widget.username}",
      child: FlutterWebFrame(
        backgroundColor: Color(int.parse(_pageController.user.backgroundColor!)),
        builder: (BuildContext context) {
          return Scaffold(
            body: (_pageController.user.userName.isNullOrBlank!)
                ? const Center(child: CircularProgressIndicator())
                : Container(
                    padding: const EdgeInsets.only(top: kToolbarHeight),
                    width: _appController.width,
                    height: Get.height,
                    color: Color(int.parse(_pageController.user.backgroundColor!)),
                    child: Column(
                      children: [
                        ProfileImageWidget(
                          profileImg: _pageController.user.profileImg ?? "",
                          userName: _pageController.user.name ?? "",
                          biography: _pageController.user.biography ?? "",
                        ),
                        Expanded(
                          child: Card(
                            shadowColor: Colors.transparent,
                            color: Colors.transparent,
                            surfaceTintColor: Colors.transparent,
                            child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemBuilder: (BuildContext context, int index) {
                                Field field = _pageController.fields[index];
                                if (field.visible!) {
                                  if (field.type == "button") {
                                    return LinkButtonWidget(
                                      index: index,
                                        link: field.link!,
                                        title: field.title!);
                                  } else if (field.type == "header") {
                                    return HeaderWidget(title: field.title!);
                                  }
                                }
                                return Container();
                              },
                              itemCount: _pageController.fields.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          );
        },
        maximumSize: const Size(680, 720),
      ),
    );
  }
}
