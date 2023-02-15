import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:crypto/crypto.dart';
import 'package:intl/intl.dart';
import 'package:order_automation/app/common/constants/coupang_api_constants.dart';
import 'package:order_automation/data/repositories/get_keys.dart';

class CoupangApi {
  GetCoupangKeys getCoupangKeys = GetCoupangKeys();
  List<String> keys = [];
  DateTime now = DateTime.now();
  String format = 'yyyy-MM-dd';
  String signedDate =
      '${DateFormat('yyMMdd').format(DateTime.now().add(const Duration(hours: -9)))}T${DateFormat('HHmmss').format(DateTime.now().add(const Duration(hours: -9)))}Z';

  Future<List> coupangGetOrderSheet(String status, String path) async {
    keys = getCoupangKeys.getCoupangKeys();
    String vendorId = keys[0];
    String accessKey = keys[1];
    String secretKey = keys[2];
    Duration duration = const Duration(days: -14);

    String coupangPath =
        '/v2/providers/openapi/apis/api/v4/vendors/$vendorId/$path';

    String createdAtFrom = DateFormat(format).format(now.add(duration));
    String createdAtTo = DateFormat(format).format(now);

    final Map<String, dynamic> queryParameters = {
      'createdAtFrom': createdAtFrom,
      'createdAtTo': createdAtTo,
      'status': status,
    };

    String coupangQuery = json
        .encode(queryParameters)
        .replaceAll('{', '')
        .replaceAll('}', '')
        .replaceAll('"', '')
        .replaceAll(',', '&')
        .replaceAll(':', '=');

    String message = signedDate + coupangMethodGet + coupangPath + coupangQuery;

    var hmac = Hmac(sha256, utf8.encode(secretKey));
    var signature = hmac.convert(utf8.encode(message));

    String authorization =
        'CEA algorithm=HmacSHA256, access-key=$accessKey, signed-date=$signedDate, signature=$signature';

    var headers = {
      'Authorization': authorization,
      'X-Requested-By': vendorId,
      'Content-type': 'application/json',
    };

    List data = [];

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
      debugPrint(e.toString());
    }
    return data;
  }

  Future<void> coupangPutOrderSheet(
      List<String> shipmentBoxIds, String path) async {
    keys = getCoupangKeys.getCoupangKeys();
    String vendorId = keys[0];
    String accessKey = keys[1];
    String secretKey = keys[2];

    String coupangPath =
        '/v2/providers/openapi/apis/api/v4/vendors/$vendorId/$path';

    String message = signedDate + coupangMethodPut + coupangPath;

    var hmac = Hmac(sha256, utf8.encode(secretKey));
    var signature = hmac.convert(utf8.encode(message));

    String authorization =
        'CEA algorithm=HmacSHA256, access-key=$accessKey, signed-date=$signedDate, signature=$signature';

    var headers = {
      'Authorization': authorization,
      'X-Requested-By': vendorId,
      'Content-type': 'application/json',
    };

    Map requestMap = {
      'vendorId': vendorId,
      'shipmentBoxIds': shipmentBoxIds,
    };

    String request = jsonEncode(requestMap);

    try {
      http.Response uriResponse = await http.put(
          Uri.https(coupangHost, coupangPath),
          body: request,
          headers: headers);
      Map<String, dynamic> json = jsonDecode(uriResponse.body);
      if (json['code'] != 200) {
        debugPrint(json['code'].toString());
        debugPrint(json['message'].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> coupangPostOrderShipping(
      Map<String, dynamic> completeOrder, String path) async {
    keys = getCoupangKeys.getCoupangKeys();
    String vendorId = keys[0];
    String accessKey = keys[1];
    String secretKey = keys[2];

    String coupangPath =
        '/v2/providers/openapi/apis/api/v4/vendors/$vendorId/$path';

    String message = signedDate + coupangMethodPost + coupangPath;

    var hmac = Hmac(sha256, utf8.encode(secretKey));
    var signature = hmac.convert(utf8.encode(message));

    String authorization =
        'CEA algorithm=HmacSHA256, access-key=$accessKey, signed-date=$signedDate, signature=$signature';

    var headers = {
      'Authorization': authorization,
      'X-Requested-By': vendorId,
      'Content-type': 'application/json',
    };

    Map requestMap = {
      'vendorId': vendorId,
      'orderSheetInvoiceApplyDtos': [completeOrder],
    };

    String request = jsonEncode(requestMap);

    try {
      http.Response uriResponse = await http.post(
          Uri.https(coupangHost, coupangPath),
          body: request,
          headers: headers);
      Map<String, dynamic> json = jsonDecode(uriResponse.body);
      if (json['code'] != 200) {
        debugPrint(json['code'].toString());
        debugPrint(json['message'].toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<List> coupangGetConsumerService() async {
    keys = getCoupangKeys.getCoupangKeys();
    String vendorId = keys[0];
    String accessKey = keys[1];
    String secretKey = keys[2];
    Duration duration = const Duration(days: -6);

    String coupangPath =
        '/v2/providers/openapi/apis/api/v4/vendors/$vendorId/onlineInquiries';

    String inquiryStartAt = DateFormat(format).format(now.add(duration));
    String inquiryEndAt = DateFormat(format).format(now);

    String answeredType = 'NOANSWER';

    final Map<String, dynamic> queryParameters = {
      'vendorId': vendorId,
      'answeredType': answeredType,
      'inquiryStartAt': inquiryStartAt,
      'inquiryEndAt': inquiryEndAt,
    };

    String coupangQuery = json
        .encode(queryParameters)
        .replaceAll('{', '')
        .replaceAll('}', '')
        .replaceAll('"', '')
        .replaceAll(',', '&')
        .replaceAll(':', '=');

    String message = signedDate + coupangMethodGet + coupangPath + coupangQuery;

    var hmac = Hmac(sha256, utf8.encode(secretKey));
    var signature = hmac.convert(utf8.encode(message));

    String authorization =
        'CEA algorithm=HmacSHA256, access-key=$accessKey, signed-date=$signedDate, signature=$signature';

    var headers = {
      'Authorization': authorization,
      'X-Requested-By': vendorId,
      'Content-type': 'application/json',
    };

    List data = [];

    try {
      http.Response uriResponse = await http.get(
          Uri.https(coupangHost, coupangPath, queryParameters),
          headers: headers);
      Map<String, dynamic> json = jsonDecode(uriResponse.body);
      if (json['code'] != 200) {
        debugPrint(json['code'].toString());
        debugPrint(json['message'].toString());
      } else {
        data = json['data']['content'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<List> coupangGetCallCenterInquiries() async {
    keys = getCoupangKeys.getCoupangKeys();
    String vendorId = keys[0];
    String accessKey = keys[1];
    String secretKey = keys[2];
    Duration duration = const Duration(days: -6);

    String coupangPath =
        '/v2/providers/openapi/apis/api/v4/vendors/$vendorId/callCenterInquiries';

    String inquiryStartAt = DateFormat(format).format(now.add(duration));
    String inquiryEndAt = DateFormat(format).format(now);

    String partnerCounselingStatus = 'NO_ANSWER';

    final Map<String, dynamic> queryParameters = {
      'vendorId': vendorId,
      'partnerCounselingStatus': partnerCounselingStatus,
      'inquiryStartAt': inquiryStartAt,
      'inquiryEndAt': inquiryEndAt,
    };

    String coupangQuery = json
        .encode(queryParameters)
        .replaceAll('{', '')
        .replaceAll('}', '')
        .replaceAll('"', '')
        .replaceAll(',', '&')
        .replaceAll(':', '=');

    String message = signedDate + coupangMethodGet + coupangPath + coupangQuery;

    var hmac = Hmac(sha256, utf8.encode(secretKey));
    var signature = hmac.convert(utf8.encode(message));

    String authorization =
        'CEA algorithm=HmacSHA256, access-key=$accessKey, signed-date=$signedDate, signature=$signature';

    var headers = {
      'Authorization': authorization,
      'X-Requested-By': vendorId,
      'Content-type': 'application/json',
    };

    List data = [];

    try {
      http.Response uriResponse = await http.get(
          Uri.https(coupangHost, coupangPath, queryParameters),
          headers: headers);
      Map<String, dynamic> json = jsonDecode(uriResponse.body);
      if (json['code'] != 200) {
        debugPrint(json['code'].toString());
        debugPrint(json['message'].toString());
      } else {
        data = json['data']['content'];
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<Map> coupangGetRevenueHistoryFromOrderSheet() async {
    keys = getCoupangKeys.getCoupangKeys();
    String vendorId = keys[0];
    String accessKey = keys[1];
    String secretKey = keys[2];
    Duration duration = const Duration(days: -30);

    String coupangPath =
        '/v2/providers/openapi/apis/api/v4/vendors/$vendorId/ordersheets';

    String createdAtFrom = DateFormat(format).format(now.add(duration));
    String createdAtTo = DateFormat(format).format(now);

    final Map<String, dynamic> queryParameters = {
      'createdAtFrom': createdAtFrom,
      'createdAtTo': createdAtTo,
      'status': coupangStatusFinalDelivery,
    };

    String coupangQuery = json
        .encode(queryParameters)
        .replaceAll('{', '')
        .replaceAll('}', '')
        .replaceAll('"', '')
        .replaceAll(',', '&')
        .replaceAll(':', '=');

    String message = signedDate + coupangMethodGet + coupangPath + coupangQuery;

    var hmac = Hmac(sha256, utf8.encode(secretKey));
    var signature = hmac.convert(utf8.encode(message));

    String authorization =
        'CEA algorithm=HmacSHA256, access-key=$accessKey, signed-date=$signedDate, signature=$signature';

    var headers = {
      'Authorization': authorization,
      'X-Requested-By': vendorId,
      'Content-type': 'application/json',
    };

    Map data = {};
    num total = 0;
    num totalSells = 0;

    try {
      http.Response uriResponse = await http.get(
          Uri.https(coupangHost, coupangPath, queryParameters),
          headers: headers);
      Map<String, dynamic> json = jsonDecode(uriResponse.body);
      if (json['code'] != 200) {
        debugPrint(json['code'].toString());
        debugPrint(json['message'].toString());
      } else {
        for (int i = 0; i < json['data'].length; i++) {
          total = total + json['data'][i]['orderItems'][0]['orderPrice'];
          totalSells =
              totalSells + json['data'][i]['orderItems'][0]['shippingCount'];
        }
        data['total'] = total;
        data['totalSells'] = totalSells;
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<List> coupangGetRevenueHistory() async {
    keys = getCoupangKeys.getCoupangKeys();
    String vendorId = keys[0];
    String accessKey = keys[1];
    String secretKey = keys[2];
    Duration duration = const Duration(days: -30);

    String coupangPath = '/v2/providers/openapi/apis/api/v1/revenue-history';

    String recognitionDateFrom = DateFormat(format).format(now.add(duration));
    String recognitionDateTo = DateFormat(format).format(now);

    final Map<String, dynamic> queryParameters = {
      'vendorId': vendorId,
      'recognitionDateFrom': recognitionDateFrom,
      'recognitionDateTo': recognitionDateTo,
      'token': '',
    };

    String coupangQuery = json
        .encode(queryParameters)
        .replaceAll('{', '')
        .replaceAll('}', '')
        .replaceAll('"', '')
        .replaceAll(',', '&')
        .replaceAll(':', '=');

    String message = signedDate + coupangMethodGet + coupangPath + coupangQuery;

    var hmac = Hmac(sha256, utf8.encode(secretKey));
    var signature = hmac.convert(utf8.encode(message));

    String authorization =
        'CEA algorithm=HmacSHA256, access-key=$accessKey, signed-date=$signedDate, signature=$signature';

    var headers = {
      'Authorization': authorization,
      'X-Requested-By': vendorId,
      'Content-type': 'application/json',
    };

    List data = [];

    try {
      http.Response uriResponse = await http.get(
          Uri.https(coupangHost, coupangPath, queryParameters),
          headers: headers);
      var json = jsonDecode(uriResponse.body);
      if (json['code'] != 200) {
        debugPrint(json['code'].toString());
        debugPrint(json['message'].toString());
      } else {
        data = json['data'];
        debugPrint(data.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }

  Future<List> coupangGetSettlementHistory() async {
    keys = getCoupangKeys.getCoupangKeys();
    String vendorId = keys[0];
    String accessKey = keys[1];
    String secretKey = keys[2];

    String coupangPath =
        '/v2/providers/marketplace_openapi/apis/api/v1/settlement-histories';

    String revenueRecognitionYearMonth = '2023-06';

    final Map<String, dynamic> queryParameters = {
      'revenueRecognitionYearMonth': revenueRecognitionYearMonth,
    };

    String coupangQuery = json
        .encode(queryParameters)
        .replaceAll('{', '')
        .replaceAll('}', '')
        .replaceAll('"', '')
        .replaceAll(',', '&')
        .replaceAll(':', '=');

    String message = signedDate + coupangMethodGet + coupangPath + coupangQuery;

    var hmac = Hmac(sha256, utf8.encode(secretKey));
    var signature = hmac.convert(utf8.encode(message));

    String authorization =
        'CEA algorithm=HmacSHA256, access-key=$accessKey, signed-date=$signedDate, signature=$signature';

    var headers = {
      'Authorization': authorization,
      'X-Requested-By': vendorId,
      'Content-type': 'application/json',
    };

    List data = [];

    try {
      http.Response uriResponse = await http.get(
          Uri.https(coupangHost, coupangPath, queryParameters),
          headers: headers);
      var json = jsonDecode(uriResponse.body);
      if (json['code'] != 200) {
        debugPrint(json['code'].toString());
        debugPrint(json['message'].toString());
      } else {
        // data = json['data']['content'];
        debugPrint(json.toString());
      }
    } catch (e) {
      debugPrint(e.toString());
    }
    return data;
  }
}
