import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Configs {
  static const xcAPIURL = "34.136.80.11:9080";
    static DateFormat dayFormat = DateFormat("dd/MM/yyyy");

}

double widthFromPercentage(BuildContext context, int percent) {
  return MediaQuery.sizeOf(context).width * (percent / 100);
}

double heightFromPercentage(BuildContext context, double percent) {
  return MediaQuery.sizeOf(context).height * (percent / 100);
}

String capitalize(String msg) {
  return (msg.isNotEmpty) ? '${msg[0].toUpperCase()}${msg.substring(1)}' : msg;
}
