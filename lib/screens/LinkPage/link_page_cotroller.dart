import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:link_project/classes/my_user.dart';

import '../../classes/field.dart';
import '../../helpers/authentication_helper.dart';

class LinkPageController extends GetxController{
  MyUser user = MyUser();
  List<Field> fields = [];

  void updateUsr() {
    AuthenticationHelper().updateUser(user);
  }


  void getSelectedUser(String username) {
    FirebaseFirestore.instance
        .collection('Users')
        .where('userName', isEqualTo: username)
        .get()
        .then((value) {
      var usr = MyUser.fromJson(value.docs.first.data());
      usr.id = value.docs.first.id;
      user = usr;
      getSelectedFields(usr);
    });
  }

  Future<List<Field>> getSelectedFields(MyUser usr) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(usr.id)
        .collection("Fields")
        .orderBy("order")
        .get()
        .then((value) {
      for (var field in value.docs) {
        var f = Field.fromJson(field.data());
        f.id = field.id;
        fields.add(f);
      }
      return fields;
    });
    return [];
  }

  void updateField(Field field) {
    final docField = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.id)
        .collection("Fields")
        .doc(field.id);
    docField.update(field.toJson());
  }

  LinkPageController(String userName){
    getSelectedUser(userName);
  }
}