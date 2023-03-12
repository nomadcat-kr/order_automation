import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AdReportOrder {

  void adReportOrder() async {

  //   Uint8List? file = pickedFile.files.single.bytes;
  //   var excel = Excel.decodeBytes(file!);
  //   Sheet sheet = excel[excel.getDefaultSheet() ?? 'Sheet1'];
  //   int lastRow = sheet.maxRows;
  //   int cellRowNumber = 0;
  //   String keyWord = '';
  //   String impression = '';
  //   String clicks = '';
  //   String ctr = '';
  //   String adExpenses = '';
  //   String totalOrders = '';
  //   String totalRevenue = '';
  //   String cpc = '';
  //   String roas = '';
  //   String cpa = '';
  //
  //   List<Map<String, dynamic>> adReportExcel = [];
  //
  //   for (int i = 0; i < lastRow - 1; i++) {
  //     cellRowNumber = i + 2;
  //     clicks = sheet
  //         .cell(CellIndex.indexByString('N$cellRowNumber'))
  //         .value
  //         .toString();
  //     if (clicks != '0') {
  //       keyWord = sheet
  //           .cell(CellIndex.indexByString('L$cellRowNumber'))
  //           .value
  //           .toString();
  //       if (keyWord == '') {
  //         keyWord = '비검색 영역';
  //       }
  //
  //       impression = sheet
  //           .cell(CellIndex.indexByString('M$cellRowNumber'))
  //           .value
  //           .toString();
  //
  //       ctr = (num.parse(sheet
  //           .cell(CellIndex.indexByString('P$cellRowNumber'))
  //           .value
  //           .toString()) *
  //           100)
  //           .toStringAsFixed(2);
  //
  //       adExpenses = sheet
  //           .cell(CellIndex.indexByString('O$cellRowNumber'))
  //           .value
  //           .toString();
  //
  //       totalOrders = sheet
  //           .cell(CellIndex.indexByString('T$cellRowNumber'))
  //           .value
  //           .toString();
  //
  //       totalRevenue = sheet
  //           .cell(CellIndex.indexByString('W$cellRowNumber'))
  //           .value
  //           .toString();
  //
  //       cpc = (int.parse(adExpenses) / int.parse(clicks)).round().toString();
  //
  //       roas = (int.parse(totalRevenue) / int.parse(adExpenses) * 100)
  //           .round()
  //           .toString();
  //
  //       if (totalOrders == '0') {
  //         cpa = '0';
  //         // totalOrders = '';
  //       } else {
  //         cpa = (int.parse(adExpenses) / int.parse(totalOrders))
  //             .round()
  //             .toString();
  //       }
  //
  //       // if (totalRevenue == '0') {
  //       //   totalRevenue = '';
  //       // }
  //
  //       adReportExcel.add({
  //         'keyWord': keyWord,
  //         'impression': impression,
  //         'clicks': clicks,
  //         'adExpenses': adExpenses,
  //         'totalOrders': totalOrders,
  //         'totalRevenue': totalRevenue,
  //         'ctr': ctr,
  //         'cpc': cpc,
  //         'cpa': cpa,
  //         'roas': roas,
  //       });
  //     }
  //   }
  }
}
