import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:link_project/helpers/authentication_helper.dart';

import '../classes/field.dart';
import '../classes/my_user.dart';

class UserController extends GetxController {
  MyUser usr = MyUser();
  List<Field> fields = [];

  void changeUsr() {
    AuthenticationHelper().getUser().then((value) => usr = value!);
  }

  void updateUsr() {
    AuthenticationHelper().updateUser(usr);
  }


  void updateField(Field field) {
    final docField = FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthenticationHelper().getUid())
        .collection("Fields")
        .doc(field.id);
    docField.update(field.toJson());
  }

  void getFields() {
    fields.clear();
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthenticationHelper().getUid())
        .collection("Fields")
        .orderBy("order");
    docUser.get().then((value) {
      fields.clear();
      usr.clicks = 0;
      for (var field in value.docs) {
        var f = Field.fromJson(field.data());
        usr.clicks = usr.clicks! + f.click!;
        f.id = field.id;
        fields.add(f);
      }
    });
  }

  Future<void> addField(Field field) async {
    final docField = FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthenticationHelper().getUid())
        .collection('Fields')
        .doc();
    final json = field.toJson();
    await docField.set(json);
  }

  void deleteField(Field field) {
    final docField = FirebaseFirestore.instance
        .collection('Users')
        .doc(AuthenticationHelper().getUid())
        .collection("Fields")
        .doc(field.id);
    docField.delete();
  }
}
