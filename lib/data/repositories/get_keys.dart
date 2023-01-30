import 'package:hive_flutter/hive_flutter.dart';
import 'package:order_automation/app/common/constants/coupang_api_constants.dart';

class GetCoupangKeys {

  List<String> getCoupangKeys() {

    String vendorId = Hive.box(coupang).get(coupangVendorId) ?? '';
    String accessKey = Hive.box(coupang).get(coupangAccessKey) ?? '';
    String secretKey = Hive.box(coupang).get(coupangSecretKey) ?? '';
    String mallName = Hive.box(coupang).get(coupangMallName) ?? '';
    List<String> keys = [vendorId, accessKey, secretKey, mallName];

    return keys;
  }
}
