import 'package:flutter/cupertino.dart';

class NetworkResponse{
  String errorText;
  String errorCode;
  dynamic data;
  NetworkResponse({
    this.data,
    this.errorCode = "",
    this.errorText = "",
});
}