import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:html' as html;
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:order_automation/app/common/constants/coupang_api_constants.dart';
import 'package:order_automation/data/repositories/get_keys.dart';

class GetJson {
  Future<String> get() async {
    GetCoupangKeys getCoupangKeys = GetCoupangKeys();
    List<String> keys = getCoupangKeys.getCoupangKeys();
    String vendorId = keys[0];
    String accessKey = keys[1];
    String secretKey = keys[2];
    // String mallName = keys[3];
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
      'content-type': 'application/json',
      // 'X-EXTENDED-TIMEOUT': '90000',
      // 'Access-Control-Allow-Origin': '*',
      // 'Access-Control-Allow-Credentials': 'true',
      // 'Access-Control-Allow-Methods': 'GET, POST',
      // 'Access-Control-Allow-Headers': 'Authorization, X-Requested-By, Access-Control-Allow-Origin, Access-Control-Allow-Credentials, Access-Control-Allow-Methods',
    };

    List data = [];
    String ee = '출발';
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
      // html.window.open('https://naver.com', 'new tab');
      ee = e.toString();
    }
    return ee;
  }
}
