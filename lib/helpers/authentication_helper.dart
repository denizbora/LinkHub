import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_login/flutter_login.dart';

import '../classes/my_user.dart';

class AuthenticationHelper {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  get user => _auth.currentUser;

  String getUid() {
    return _auth.currentUser!.uid;
  }

  bool checkLogin() {
    if (_auth.currentUser != null) {
      return true;
    }
    return false;
  }

  void logOut() {
    _auth.signOut();
  }

  Future<MyUser?> getUser() async {
    final docUser =
        FirebaseFirestore.instance.collection('Users').doc(getUid());
    final snapshot = await docUser.get();
    if (snapshot.exists) {
      MyUser usr = MyUser.fromJson(snapshot.data()!);
      usr.id = snapshot.id;
      return usr;
    }
    return null;
  }

  Future<bool> checkUser(String userName) async {
    final docUser = FirebaseFirestore.instance
        .collection('Users')
        .where("userName", isEqualTo: userName);
    final snapshot = await docUser.get();
    return snapshot.docs.isEmpty;
  }

  Future updateUser(MyUser usr) async {
    final docUser =
    FirebaseFirestore.instance.collection('Users').doc(usr.id);
    docUser.update(usr.toJson());
  }

  void changePassword(String password){
    _auth.currentUser!.updatePassword(password);
  }

  Future deleteUser() async{
    final docUser =
    FirebaseFirestore.instance.collection('Users').doc(getUid());
    var snapshot = await docUser.get();
    var usr = MyUser.fromJson(snapshot.data()!);
    await FirebaseStorage.instance.refFromURL(usr.profileImg!).delete();
    await docUser.delete();
    await _auth.currentUser!.delete();
  }

  Future registerUser(MyUser usr) async {
    final docUser =
        FirebaseFirestore.instance.collection('Users').doc(getUid());
    final json = usr.toJson();
    await docUser.set(json);
  }

  //SIGN UP METHOD
  Future signUp(SignupData data) async {

      return checkUser(data.additionalSignupData!["userName"]!).then((value) async {
        if(value){
          try {
            await _auth.createUserWithEmailAndPassword(
              email: data.name!,
              password: data.password!,
            );
            registerUser(MyUser(name: data.additionalSignupData!["name"]!,userName: data.additionalSignupData!["userName"]!));
            return null;
          } on FirebaseAuthException catch (e) {
            return e.message;
          }
        }
      });

  }

  //SIGN IN METHOD
  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }

  //SIGN OUT METHOD
  Future signOut() async {
    await _auth.signOut();
  }

  //Recover Password
  Future recoverPassword({required String email}) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.message;
    }
  }
}
