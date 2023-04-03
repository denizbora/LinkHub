import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:flutter_web_frame/flutter_web_frame.dart';
import 'package:get/get.dart';
import 'package:link_project/helpers/authentication_helper.dart';

import '../constants/constants.dart';
import '../controllers/app_controller.dart';
import '../controllers/user_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final UserController _controller = Get.find<UserController>();
  final AppController _appController = Get.find<AppController>();

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      return AuthenticationHelper()
          .signIn(email: data.name, password: data.password)
          .then((result) {
        if (result != null) {
          return result.toString();
        }
        _controller.changeUsr();
        _controller.getFields();
        return null;
      });
    });
  }

  Future<String?> _signupUser(SignupData data) {
    return Future.delayed(loginTime).then((_) {
      return AuthenticationHelper()
          .signUp(data)
          .then((result) {
        if (result == null) {
          _controller.changeUsr();
          _controller.getFields();
          return null;
        } else {
          return result.toString();
        }
      });
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return AuthenticationHelper().recoverPassword(email: name).then((result) {
        if (result == null) {
          return null;
        } else {
          return result.toString();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterWebFrame(
      backgroundColor: Constants().backgroundColor,
      builder: (BuildContext context) {
        return Container(
          width: _appController.width,
          height: Get.height,
          color: Constants().backgroundColor,
          child: FlutterLogin(
            logo: const AssetImage("assets/logo.png"),
            theme: LoginTheme(
                inputTheme: const InputDecorationTheme(
                  labelStyle:
                  TextStyle(color: Color.fromRGBO(57, 190, 246, 1)),
                  filled: true,
                  fillColor: Color.fromRGBO(237, 249, 254, 1),
                ),
                textFieldStyle:
                const TextStyle(color: Color.fromRGBO(57, 190, 246, 1)),
                switchAuthTextColor: const Color.fromRGBO(185, 169, 169, 1),
                primaryColor: Colors.transparent,
                bodyStyle: const TextStyle(color: Color.fromRGBO(185, 169, 169, 1)),
                buttonTheme: const LoginButtonTheme(
                    backgroundColor: Color.fromRGBO(237, 249, 254, 1)),
                accentColor: Colors.transparent,
                buttonStyle: const TextStyle(color: Color.fromRGBO(57, 190, 246, 1)),
                cardTheme: const CardTheme(
                  elevation: 0,
                  color: Colors.white,
                )),
            additionalSignupFields: const [
              UserFormField(keyName: "userName",displayName: "Kullanıcı Adı"),
              UserFormField(keyName: "name",displayName: "İsim"),
            ],
            onLogin: _authUser,
            onSignup: _signupUser,
            onSubmitAnimationCompleted: () {
              Get.offAllNamed("/UserPage");
            },
            onRecoverPassword: _recoverPassword,
            messages: LoginMessages(
              additionalSignUpFormDescription:
              "Kaydı tamamlamak için formu doldurunuz.",
              additionalSignUpSubmitButton: "Gönder",
              providersTitleFirst: 'Yada bununla devam et',
              userHint: 'E-Mail',
              passwordHint: 'Şifre',
              confirmPasswordHint: 'Şifre Tekrar',
              loginButton: 'Giriş',
              signupButton: 'Kayıt Ol',
              forgotPasswordButton: 'Şifremi Unuttum',
              recoverPasswordButton: 'Sıfırla',
              goBackButton: 'Geri',
              recoverPasswordIntro: 'Şifreni Sıfırla',
              confirmPasswordError: 'Şifreler eşleşmedi.',
              recoverPasswordDescription:
              'E-Mail adresinize şifre sıfırlama bağlantısı gönderilecek.',
              recoverPasswordSuccess: 'Sıfırlama bağlantısı gönderildi.',
            ),
          ),
        );
      },
      maximumSize: const Size(680, 720),
    );
  }
}
