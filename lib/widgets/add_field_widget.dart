import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:link_project/classes/field.dart';

import '../controllers/user_controller.dart';

class AddFieldWidget extends StatefulWidget {
  const AddFieldWidget({super.key});

  @override
  State<AddFieldWidget> createState() => _AddFieldWidgetState();
}

class _AddFieldWidgetState extends State<AddFieldWidget> {
  bool _isLinkSelected = false;

  final UserController _userController = Get.find<UserController>();
  final _titleController = TextEditingController();
  final _linkController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    _linkController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0))),
      title: const Text('Add Field'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Radio(
                value: false,
                groupValue: _isLinkSelected,
                onChanged: (value) {
                  setState(() {
                    _isLinkSelected = value!;
                  });
                },
              ),
              const Text('Header'),
            ],
          ),
          Row(
            children: [
              Radio(
                value: true,
                groupValue: _isLinkSelected,
                onChanged: (value) {
                  setState(() {
                    _isLinkSelected = value!;
                  });
                },
              ),
              const Text('Link'),
            ],
          ),
          if (_isLinkSelected)
            Column(
              children: [
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                ),
                TextFormField(
                  controller: _linkController,
                  decoration: const InputDecoration(labelText: 'Link'),
                ),
              ],
            ),
          if (!_isLinkSelected)
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
        ],
      ),
      actions: [
        TextButton(
          child: const Text('Save'),
          onPressed: () {
            var field = Field(
                title: _titleController.text,
                type: (_isLinkSelected) ? "button" : "header",
                click: 0,
                link: (Uri.parse(_linkController.text).hasScheme) ? _linkController.text : "http://${_linkController.text}",
                order: _userController.fields.length,
                visible: true);
            _userController.addField(field);
            _userController.fields.add(field);
            final result = _isLinkSelected
                ? '${_titleController.text} - ${_linkController.text}'
                : _titleController.text;
            Navigator.pop(context, result);
          },
        ),
      ],
    );
  }
}
