import 'package:excel/excel.dart';
import 'package:order_automation/app/common/common.dart';

class ExportRocketGrowthExcel {
  var excel = Excel.createExcel();

  void exportRocketGrowthExcel(
      String rocketGrowthCenter, String rocketGrowthBox) {
    Map center = {};
    for (int i = 0; i < coupangRocketGrowthCenterList.length; i++) {
      if (rocketGrowthCenter == coupangRocketGrowthCenterList[i]['name']) {
        center = coupangRocketGrowthCenterList[i];
      }
    }

    Sheet sheet = excel[excel.getDefaultSheet() ?? 'Sheet1'];

    sheet.cell(CellIndex.indexByString('A1')).value = '받는분성명';
    sheet.cell(CellIndex.indexByString('A2')).value = center['name'].toString();

    sheet.cell(CellIndex.indexByString('B1')).value = '받는분주소(전체, 분할)';
    sheet.cell(CellIndex.indexByString('B2')).value =
        center['address'].toString();

    sheet.cell(CellIndex.indexByString('C1')).value = '받는분우편번호';
    sheet.cell(CellIndex.indexByString('C2')).value =
        center['addressNumber'].toString();

    sheet.cell(CellIndex.indexByString('D1')).value = '받는분전화번호';
    sheet.cell(CellIndex.indexByString('D2')).value =
        center['invoicePhoneNumber'].toString();

    sheet.cell(CellIndex.indexByString('E1')).value = '박스수량';
    sheet.cell(CellIndex.indexByString('E2')).value =
        rocketGrowthBox.toString();

    excel.save(fileName: '$rocketGrowthCenter 박스 $rocketGrowthBox개.xlsx');
  }
}
