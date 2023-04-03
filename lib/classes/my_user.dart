import 'package:flutter/material.dart';
import 'package:link_project/constants/constants.dart';

class MyUser {
  String? id;
  String? name;
  String? profileImg="";
  String? biography="";
  String? biographyColor="0${Colors.black45.toString().split('Color(0')[1].toString().split(')')[0].toString()}";
  String? userName;
  String? userNameColor="0${Colors.black.toString().split('Color(0')[1].toString().split(')')[0].toString()}";
  String? backgroundColor="0${Constants().backgroundColor.toString().split('Color(0')[1].toString().split(')')[0].toString()}";
  int? totalViews=0;
  int? clicks = 0;
  double? borderRadius=6;
  String? buttonStyle="SoftShadow";

  MyUser({this.name, this.userName});

  MyUser.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    profileImg = json['profileImg'];
    biography = json['biography'];
    userName = json['userName'];
    totalViews = json['totalViews'];
    borderRadius = json['borderRadius'];
    userNameColor = json['userNameColor'];
    biographyColor = json['biographyColor'];
    backgroundColor = json['backgroundColor'];
    buttonStyle = json['buttonStyle'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['profileImg'] = profileImg;
    data['biography'] = biography;
    data['userName'] = userName;
    data['totalViews'] = totalViews;
    data['borderRadius'] = borderRadius;
    data['userNameColor'] = userNameColor;
    data['biographyColor'] = biographyColor;
    data['backgroundColor'] = backgroundColor;
    data['buttonStyle'] = buttonStyle;
    return data;
  }
}