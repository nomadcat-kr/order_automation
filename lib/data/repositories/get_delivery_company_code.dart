class GetDeliveryCompanyCode {
  String getDeliveryCompanyCode(String deliveryCompanyCode) {
    String code = '';
    if (deliveryCompanyCode == '롯데택배(구 현대택배)') {
      code = 'HYUNDAI';
      return code;
    }
    if (deliveryCompanyCode == '롯데택배') {
      code = 'HYUNDAI';
      return code;
    }
    if (deliveryCompanyCode == '한진택배') {
      code = 'HANJIN';
      return code;
    }
    if (deliveryCompanyCode == '한진택배(화물)') {
      code = 'HANJIN';
      return code;
    }
    if (deliveryCompanyCode == 'CJ대한통운') {
      code = 'CJGLS';
      return code;
    }
    return code;
  }
}
