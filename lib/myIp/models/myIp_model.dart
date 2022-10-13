// To parse this JSON data, do
//
//     final myIp = myIpFromJson(jsonString);

import 'dart:convert';

MyIpModel myIpFromJson(String str) => MyIpModel.fromJson(json.decode(str));

String myIpToJson(MyIpModel data) => json.encode(data.toJson());

class MyIpModel {
  MyIpModel({
    required this.ip,
  });

  String? ip;

  factory MyIpModel.fromJson(Map<String, dynamic> json) => MyIpModel(
        ip: json["ip"] == null ? null : json["ip"],
      );

  Map<String, dynamic> toJson() => {
        "ip": ip == null ? null : ip,
      };
}
