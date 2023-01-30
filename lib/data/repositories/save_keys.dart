import 'package:hive_flutter/hive_flutter.dart';
import 'package:order_automation/app/common/constants/coupang_api_constants.dart';

class SaveCoupangKeys {

  void saveCoupangKeys(String keyType, String keyValue) {

    if (keyType == coupangVendorId) {
      Hive.box(coupang).put(keyType, keyValue);
      return;
    }
    if (keyType == coupangAccessKey) {
      Hive.box(coupang).put(keyType, keyValue);
      return;
    }
    if (keyType == coupangSecretKey) {
      Hive.box(coupang).put(keyType, keyValue);
      return;
    }
    if (keyType == coupangMallName) {
      Hive.box(coupang).put(keyType, keyValue);
      return;
    }
  }
}
