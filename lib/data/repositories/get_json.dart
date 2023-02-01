import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:order_automation/app/common/constants/coupang_api_constants.dart';
import 'package:order_automation/data/repositories/get_keys.dart';

class GetJson {
  Future<List> get() async {
    GetCoupangKeys getCoupangKeys = GetCoupangKeys();
    List<String> keys = getCoupangKeys.getCoupangKeys();
    String vendorId = keys[0];
    String accessKey = keys[1];
    String secretKey = keys[2];
    String mallName = keys[3];
    String status = statusFinalDelivery;

    String createdAtFrom = DateFormat('yyyy-MM-dd')
        .format(DateTime.now().add(const Duration(days: -14)));
    String createdAtTo = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final Map<String, dynamic> queryParameters = {
      'createdAtFrom': createdAtFrom,
      'createdAtTo': createdAtTo,
      'status': status,
    };

    DateTime dateTime = DateTime.now().add(const Duration(hours: -9));
    String dateFormat =
        '${DateFormat('yyMMdd').format(dateTime)}T${DateFormat('HHmmss').format(dateTime)}Z';

    String coupangPath =
        '/v2/providers/openapi/apis/api/v4/vendors/$vendorId/ordersheets';
    String coupangQuery =
        'createdAtFrom=$createdAtFrom&createdAtTo=$createdAtTo&status=$status';

    String message = dateFormat + coupangMethodGet + coupangPath + coupangQuery;

    var hmac = Hmac(sha256, utf8.encode(secretKey));
    var signature = hmac.convert(utf8.encode(message));

    String authorization =
        'CEA algorithm=HmacSHA256, access-key=$accessKey, signed-date=$dateFormat, signature=$signature';

    var headers = {
      'Authorization': authorization,
      'X-Requested-By': vendorId,
      'Content-Type': 'text/plain',
      // 'X-EXTENDED-TIMEOUT': '90000',
      'Access-Control-Allow-Origin': '*',
      "Access-Control-Allow-Methods": "POST, GET, OPTIONS, PUT, DELETE, HEAD",
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Headers': '*',
    };

    List data = [];

    // final response = await http.get(Uri.parse(
    //   'https://us-central1-order-automation-kr.cloudfunctions.net/app'),
    //   // headers: <String, String>{
    //   //   'Content-Type': 'application/json; charset=UTF-8',
    //   // },
    //   // body: jsonEncode(<String, dynamic>{
    //   //   'host': coupangHost,
    //   //   'path': coupangPath,
    //   //   'method': coupangMethodGet,
    //   //   'header': headers,
    //   // },
    //   // ),
    // );

    // if (response.statusCode == 200) {
    //   debugPrint(response.body);
    //   // return json.decode(response.body)['data'];
    // } else {
    //   throw Exception('Failed to send request');
    // }

    // try {
    //   http.Response uriResponse = await http.post(
    //     Uri.parse(
    //         'https://us-central1-order-automation-kr.cloudfunctions.net/getCoupang'),
    //     headers: headers,
    //     body: jsonEncode({
    //       'host': coupangHost,
    //       'path': coupangPath,
    //       'method': coupangMethodGet,
    //       'headers': headers,
    //     }),
    //   );
    //   Map<String, dynamic> json = jsonDecode(uriResponse.body);
    //   if (json['code'] != 200) {
    //     debugPrint(json['code'].toString());
    //     debugPrint(json['message'].toString());
    //   } else {
    //     data = json['data'];
    //     // debugPrint(data.toString());
    //   }
    // } catch (e) {
    //   debugPrint('request error');
    // }

    try {
      http.Response uriResponse = await http.get(
          Uri.https(coupangHost, coupangPath, queryParameters),
          headers: headers);
      Map<String, dynamic> json = jsonDecode(uriResponse.body);
      if (json['code'] != 200) {
        debugPrint(json['code'].toString());
        debugPrint(json['message'].toString());
      } else {
        data = json['data'];
        // debugPrint(data.toString());
      }
    } catch (e) {
      debugPrint('request error');
    }
    return data;
  }
}
