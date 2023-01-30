import 'package:flutter/cupertino.dart';
import 'package:order_automation/app/common/common.dart';

class Results extends StatelessWidget {
  const Results({
    Key? key, required this.result,
  }) : super(key: key);

  final List<dynamic> result;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: result.length,
      shrinkWrap: true,
      itemBuilder: (BuildContext context, int i) {
        return Container(
          margin: const EdgeInsets.only(top: defaultPadding),
          padding: const EdgeInsets.all(defaultPadding),
          decoration: BoxDecoration(
            border:
            Border.all(width: 2, color: primaryColor.withOpacity(0.15)),
            borderRadius: const BorderRadius.all(
              Radius.circular(defaultPadding),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '상품번호 : ' +
                        result[i]['orderItems'][0]['sellerProductName'],
                  ),
                  Text(
                    '옵션코드 : ' +
                        result[i]['orderItems'][0]
                        ['externalVendorSkuCode'] +
                        ' 수량 : ' +
                        result[i]['orderItems'][0]['shippingCount']
                            .toString(),
                  ),
                ],
              ),
              const SizedBox(width: 30,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '수령자명 : ' + result[i]['receiver']['name'],
                  ),
                  Text(
                    '우편번호 : ' + result[i]['receiver']['postCode'],
                  ),
                ],
              ),
              const SizedBox(width: 30,),

              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '배송주소 : ' + result[i]['receiver']['addr1'],
                    ),
                    Text(
                      result[i]['receiver']['addr2'],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 30,),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '휴대전화 : ' +
                        result[i]['receiver']['safeNumber'],
                  ),
                  Text(
                    '배송요청사항 : ' + result[i]['parcelPrintMessage'],
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}