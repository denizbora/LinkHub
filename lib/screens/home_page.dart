import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:link_project/controllers/user_controller.dart';
import 'package:link_project/widgets/add_field_widget.dart';
import 'package:link_project/widgets/reorderable_header_widget.dart';
import 'package:link_project/widgets/reorderable_link_button_widget.dart';
import 'package:link_project/widgets/stat_widget.dart';

import '../classes/field.dart';
import '../constants/constants.dart';
import '../controllers/app_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final AppController _appController = Get.find<AppController>();
  final UserController _userController = Get.find<UserController>();

  void _showDialog() async {
    final result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AddFieldWidget();
      },
    );

    if (result != null) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        onPressed: () {
          _showDialog();
        },
      ),
      body: Container(
        width: _appController.width,
        color: Constants().backgroundColor,
        child: Column(
          children: [
            Container(
              height: 200,
              decoration: BoxDecoration(
                  color: Constants().cardColor,
                  borderRadius: BorderRadius.circular(25)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      StatWidget(
                          bg: const Color.fromRGBO(222, 245, 255, 1),
                          icon: const Icon(
                            Icons.remove_red_eye_outlined,
                            size: 20,
                            color: Color.fromRGBO(78, 197, 247, 1),
                          ),
                          stat: _userController.usr.totalViews.toString(),
                          title: "Total Views"),
                      StatWidget(
                          bg: const Color.fromRGBO(226, 226, 255, 1),
                          icon: const Icon(
                            Icons.ads_click_outlined,
                            size: 20,
                            color: Color.fromRGBO(134, 131, 212, 1),
                          ),
                          stat: _userController.usr.clicks.toString(),
                          title: "Clicks"),
                    ],
                  ),
                  SizedBox(
                    width: _appController.width * 0.56,
                    child: TextFormField(
                      readOnly: true,
                      decoration: InputDecoration(
                        fillColor: const Color.fromRGBO(237, 249, 254, 1),
                        filled: true,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 15.0),
                        hintText:
                            "linkhub.denizbora.net/pages?username=${_userController.usr.userName}",
                        hintStyle: TextStyle(
                            color: const Color.fromRGBO(57, 190, 246, 1),
                            fontSize: _appController.width * 0.03,
                            fontWeight: FontWeight.w600),
                        border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.circular(10.0),
                          borderSide: BorderSide.none,
                        ),
                        suffixIcon: IconButton(
                          icon: const Icon(
                            Icons.content_copy,
                            color: Color.fromRGBO(57, 190, 246, 1),
                          ),
                          onPressed: () {
                            Clipboard.setData(ClipboardData(
                                text:
                                    "linkhub.denizbora.net/pages?username=${_userController.usr.userName}"));
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text("Link copied")),
                            );
                          },
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Container(
                  decoration: BoxDecoration(
                      color: Constants().cardColor,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      )),
                  child: ReorderableListView.builder(
                    footer: Container(
                      height: 150,
                    ),
                      buildDefaultDragHandles: false,
                      itemBuilder: (BuildContext context, int index) {
                      _appController.buildDecorations(_userController.usr);
                        Field field = _userController.fields[index];
                        if (field.type == "button") {
                          return Column(
                            key: ValueKey(_userController.fields[index]),
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  ReorderableDragStartListener(
                                    index: index,
                                    child: SizedBox(
                                      width: kMinInteractiveDimension,
                                      child: Icon(
                                        Icons.menu,
                                        color:
                                            Constants().bottomNavSelectedColor,
                                      ),
                                    ),
                                  ),
                                  ReorderableLinkButtonWidget(
                                    link: field.link!,
                                    title: field.title!,
                                  ),
                                  Switch(
                                      value: _userController
                                          .fields[index].visible!,
                                      onChanged: (value) {
                                        setState(() {
                                          _userController
                                              .fields[index].visible = value;
                                          _userController.updateField(
                                              _userController.fields[index]);
                                        });
                                      }),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    width: 95,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.ads_click_outlined,
                                          color: Colors.black54,
                                        ),
                                        Text(_userController.fields[index].click
                                            .toString())
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      TextEditingController titleController =
                                          TextEditingController(
                                              text: _userController
                                                  .fields[index].title);
                                      TextEditingController linkController =
                                          TextEditingController(
                                              text: _userController
                                                  .fields[index].link);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            shape: const RoundedRectangleBorder(
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(32.0))),
                                            title: const Text('Edit'),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: titleController,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText: 'Title'),
                                                  ),
                                                  TextFormField(
                                                    controller: linkController,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText: 'Link'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text('Save'),
                                                onPressed: () {
                                                  setState(() {
                                                    _userController
                                                            .fields[index]
                                                            .title =
                                                        titleController.text;
                                                    _userController
                                                            .fields[index]
                                                            .link =
                                                    (Uri.parse(linkController.text).hasScheme) ? linkController.text : "http://${linkController.text}";
                                                  });
                                                  _userController.updateField(
                                                      _userController
                                                          .fields[index]);
                                                  Get.back();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Ink(
                                      padding: const EdgeInsets.all(10),
                                      width: 95,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.edit_outlined,
                                            color: Color.fromRGBO(
                                                133, 169, 139, 1),
                                          ),
                                          Text(
                                            "Edit",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    133, 169, 139, 1)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _userController.deleteField(
                                          _userController.fields[index]);
                                      setState(() {
                                        _userController.fields.removeAt(index);
                                      });
                                    },
                                    child: Ink(
                                      padding: const EdgeInsets.all(10),
                                      width: 95,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.delete_outline,
                                            color: Color.fromRGBO(
                                                220, 154, 153, 1),
                                          ),
                                          Text(
                                            "Delete",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    220, 154, 153, 1)),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ],
                          );
                        } else if (field.type == "header") {
                          return Column(
                            key: ValueKey(_userController.fields[index]),
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ReorderableDragStartListener(
                                    index: index,
                                    child: SizedBox(
                                      width: kMinInteractiveDimension,
                                      child: Icon(
                                        Icons.menu,
                                        color:
                                        Constants().bottomNavSelectedColor,
                                      ),
                                    ),
                                  ),
                                  ReorderableHeaderWidget(
                                    title: field.title!,
                                  ),
                                  Switch(
                                      value: _userController
                                          .fields[index].visible!,
                                      onChanged: (value) {
                                        setState(() {
                                          _userController
                                              .fields[index].visible = value;
                                          _userController.updateField(
                                              _userController.fields[index]);
                                        });
                                      }),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      TextEditingController titleController =
                                          TextEditingController(
                                              text: _userController
                                                  .fields[index].title);
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: const Text('Edit'),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                children: [
                                                  TextFormField(
                                                    controller: titleController,
                                                    decoration:
                                                        const InputDecoration(
                                                            labelText: 'Title'),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text('Save'),
                                                onPressed: () {
                                                  setState(() {
                                                    _userController
                                                            .fields[index]
                                                            .title =
                                                        titleController.text;
                                                  });
                                                  _userController.updateField(
                                                      _userController
                                                          .fields[index]);
                                                  Get.back();
                                                },
                                              ),
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Ink(
                                      padding: const EdgeInsets.all(10),
                                      width: 95,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.edit_outlined,
                                            color: Color.fromRGBO(
                                                133, 169, 139, 1),
                                          ),
                                          Text(
                                            "Edit",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    133, 169, 139, 1)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      _userController.deleteField(
                                          _userController.fields[index]);
                                      setState(() {
                                        _userController.fields.removeAt(index);
                                      });
                                    },
                                    child: Ink(
                                      padding: const EdgeInsets.all(10),
                                      width: 95,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.delete_outline,
                                            color: Color.fromRGBO(
                                                220, 154, 153, 1),
                                          ),
                                          Text(
                                            "Delete",
                                            style: TextStyle(
                                                color: Color.fromRGBO(
                                                    220, 154, 153, 1)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          );
                        }
                        return Container();
                      },
                      itemCount: _userController.fields.length,
                      onReorder: (oldIndex, newIndex) {
                        setState(() {
                          if (newIndex > oldIndex) {
                            newIndex = newIndex - 1;
                          }
                        });
                        final task = _userController.fields.removeAt(oldIndex);
                        _userController.fields.insert(newIndex, task);
                        for (int i = 0;
                            i < _userController.fields.length;
                            i++) {
                          _userController.fields[i].order = i;
                          _userController
                              .updateField(_userController.fields[i]);
                        }
                      })),
            )
          ],
        ),
      ),
    );
  }
}
