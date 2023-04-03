import 'package:flutter/material.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:get/get.dart';

import '../constants/constants.dart';
import '../controllers/app_controller.dart';
import '../controllers/user_controller.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final AppController _appController = Get.find<AppController>();
  final UserController _userController = Get.find<UserController>();
  int selected = 0;
  @override
  void initState() {
    super.initState();
    _userController.changeUsr();
    _appController.buildDecorations(_userController.usr);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {
      if(_userController.fields.isEmpty){
        _userController.getFields();
      }
    }));
    return Title(
        title: "LinkHub | ${_userController.usr.userName ?? ""}",
        color: Colors.black,
        child: FlutterWebFrame(
          backgroundColor: Constants().backgroundColor,
          maximumSize: const Size(680, 720),
          builder: (BuildContext context) {
            return (_userController.usr.userName.isNullOrBlank!)
                ? const Center(child: CircularProgressIndicator())
                : Scaffold(
                    appBar: AppBar(
                      automaticallyImplyLeading: false,
                      backgroundColor: Constants().backgroundColor,
                      shadowColor: Colors.transparent,
                      title: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Hello There 👋",
                                style: TextStyle(
                                    color: Colors.black45, fontSize: 12),
                              ),
                              Text(
                                _userController.usr.name!,
                                style: const TextStyle(
                                    color: Colors.black87, fontSize: 16),
                              ),
                            ],
                          ),
                          Container(
                              width: kToolbarHeight-10,
                              height: kToolbarHeight-10,
                              decoration: (_userController.usr.profileImg != "")
                                  ? BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          _appController.width * 0.33),
                                      color:
                                          Constants().userProfileBg,
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              _userController.usr.profileImg!)))
                                  : BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          _appController.width * 0.33),
                                      color:
                                          const Color.fromRGBO(96, 105, 108, 1),
                                    ),child: Center(
                              child: (_userController.usr.profileImg != "") ? Container() : Text(
                                _userController.usr.userName![0].toUpperCase(),
                                style: TextStyle(
                                    color: Colors.white, fontSize: _appController.width * 0.03),
                              )),)
                        ],
                      ),
                    ),
                    bottomNavigationBar: Container(
                        width: Get.width,
                        height: kBottomNavigationBarHeight,
                        color: Constants().bottomNavBarColor,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: 3,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                                height: kBottomNavigationBarHeight,
                                width: _appController.width / 3,
                                child: Center(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            selected = index;
                                          });
                                        },
                                        icon: _appController.pages[index].icon!,
                                            color: (selected == index)
                                                ? Constants()
                                                    .bottomNavSelectedColor
                                                : Constants()
                                                    .bottomNavUnselectedColor)));
                          },
                        )),
                    body: _appController.pages[selected].page
                  );
          },
        ));
  }
}
