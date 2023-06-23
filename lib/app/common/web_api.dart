import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<String?> EXEC(
    String MODE,
    String CODE,
    Map? PARAMS, {
      String? url = null,
      String? service_name = null,
      String? auth = null,
      String ContentType = 'application/json',
    }) async {
  Map<String, dynamic> data = {};
  String result = "";
  Object? exception = null;
  try {
    if (url == null) url = '121.133.99.66:3000';
    //if (url == null) url = '10.0.2.2:3000';
    if (service_name == null) service_name = '/';

    var RequestUri = Uri.http(url, service_name);
    var params;
    if (PARAMS != null) params = json.encode(PARAMS);
    Map<String, dynamic> data = {
      //'SERVICE':'LEEKU_MES',
      'MODE': MODE,
      'CODE': CODE,
      'PARAMS': params,
      'AUTH' : auth,
    };
    var response = await http.post(
        RequestUri,
        headers: {'Content-Type': ContentType},
        body: json.encode(data)
    ).timeout(const Duration(seconds: 10));
    result = utf8.decode(response.bodyBytes);
    return result;
  }catch(ex){
    exception = ex;
  }finally{
    log({'url':url,'service_name':service_name,'MODE':MODE,'CODE':CODE,'PARAMS':PARAMS}.toString());
    log({'DATA':data, 'RESULT':result, 'EXCEPTION':exception}.toString());
  }
}

Future<Map> PROC(String procName, Map? PARAMS) async {
  String res = await EXEC("PROC", procName, PARAMS) ?? "";
  Map data = json.decode(res);
  return data;
}
