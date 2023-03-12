import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class AdReportAnalysis {
  Future<FilePickerResult?> getExcelFile() async {
    FilePickerResult? pickedExcelFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    return pickedExcelFile;
  }

  String getExcelFileName(FilePickerResult excelFile) {
    String excelFileName = excelFile.files.first.name;
    List<String> excelFileNameSplit =
        excelFileName.replaceAll('.', '_').split('_');

    String fromDate = excelFileNameSplit[4];
    String toDate = excelFileNameSplit[5];

    if (fromDate == toDate) {
      excelFileName =
          '${fromDate.substring(0, 4)}년 ${fromDate.substring(4, 6)}월 ${fromDate.substring(6, 8)}일';
    } else {
      excelFileName =
          '${fromDate.substring(0, 4)}년 ${fromDate.substring(4, 6)}월 ${fromDate.substring(6, 8)}일 ~ ${toDate.substring(0, 4)}년 ${toDate.substring(4, 6)}월 ${toDate.substring(6, 8)}일';
    }

    return excelFileName;
  }

  Future<List<Map<String, dynamic>>> adReportAnalysis(
      FilePickerResult excelFile) async {
    Uint8List? file;
    file = excelFile.files.single.bytes;

    var excel = Excel.decodeBytes(file!);
    Sheet sheet = excel[excel.getDefaultSheet() ?? 'Sheet1'];
    int lastRow = sheet.maxRows;
    int cellRowNumber = 0;
    String keyWord = '';
    String impression = '';
    String clicks = '';
    String ctr = '';
    String adExpenses = '';
    String totalOrders = '';
    String totalRevenue = '';
    String cpc = '';
    String roas = '';
    String cpa = '';

    List<Map<String, dynamic>> adReportExcel = [];

    for (int i = 0; i < lastRow - 1; i++) {
      cellRowNumber = i + 2;
      clicks = sheet
          .cell(CellIndex.indexByString('N$cellRowNumber'))
          .value
          .toString();
      if (clicks != '0') {
        keyWord = sheet
            .cell(CellIndex.indexByString('L$cellRowNumber'))
            .value
            .toString();
        if (keyWord == '') {
          keyWord = '비검색 영역';
        }

        impression = sheet
            .cell(CellIndex.indexByString('M$cellRowNumber'))
            .value
            .toString();

        ctr = (num.parse(sheet
                    .cell(CellIndex.indexByString('P$cellRowNumber'))
                    .value
                    .toString()) *
                100)
            .toStringAsFixed(2);

        adExpenses = sheet
            .cell(CellIndex.indexByString('O$cellRowNumber'))
            .value
            .toString();

        totalOrders = sheet
            .cell(CellIndex.indexByString('T$cellRowNumber'))
            .value
            .toString();

        totalRevenue = sheet
            .cell(CellIndex.indexByString('W$cellRowNumber'))
            .value
            .toString();

        cpc = (int.parse(adExpenses) / int.parse(clicks)).round().toString();

        if (totalOrders == '0') {
          cpa = '0';
          roas = '0';
        } else {
          cpa = (int.parse(adExpenses) / int.parse(totalOrders))
              .round()
              .toString();

          roas = (int.parse(totalRevenue) / int.parse(adExpenses) * 100)
              .round()
              .toString();
        }

        adReportExcel.add({
          'keyWord': keyWord,
          'impression': impression,
          'clicks': clicks,
          'adExpenses': adExpenses,
          'totalOrders': totalOrders,
          'totalRevenue': totalRevenue,
          'ctr': ctr,
          'cpc': cpc,
          'cpa': cpa,
          'roas': roas,
        });
      }
    }

    return adReportExcel;
  }

  Map<String, dynamic> getAdReportAnalysisTotal(adReportExcel) {
    String totalImpression = '';
    String totalClicks = '';
    String totalAdExpenses = '';
    String totalTotalOrders = '';
    String totalTotalRevenue = '';
    String averageCtr = '';
    String averageCpc = '';
    String averageCpa = '';
    String averageRoas = '';

    totalImpression = (adReportExcel
        .map((m) => num.parse(m['impression']))
        .reduce((a, b) => a + b)).toString();
    totalClicks = (adReportExcel
        .map((m) => num.parse(m['clicks']))
        .reduce((a, b) => a + b)).toString();
    totalAdExpenses = (adReportExcel
        .map((m) => num.parse(m['adExpenses']))
        .reduce((a, b) => a + b)).toString();
    totalTotalOrders = (adReportExcel
        .map((m) => num.parse(m['totalOrders']))
        .reduce((a, b) => a + b)).toString();
    totalTotalRevenue = (adReportExcel
        .map((m) => num.parse(m['totalRevenue']))
        .reduce((a, b) => a + b)).toString();
    averageCtr = (num.parse(totalClicks) / num.parse(totalImpression) * 100)
        .toStringAsFixed(2);
    averageCpc = (num.parse(totalAdExpenses) / num.parse(totalClicks))
        .round()
        .toString();

    if (totalTotalOrders == '0') {
      averageCpa = '0';
      averageRoas = '0';
    } else {
      averageCpa = (num.parse(totalAdExpenses) / num.parse(totalTotalOrders))
          .round()
          .toString();
      averageRoas =
          (num.parse(totalTotalRevenue) / num.parse(totalAdExpenses) * 100)
              .round()
              .toString();
    }

    Map<String, dynamic> adReportExcelTotal = {
      'totalKeyword': adReportExcel.length.toString(),
      'totalImpression': totalImpression,
      'totalClicks': totalClicks,
      'totalAdExpenses': totalAdExpenses,
      'totalTotalOrders': totalTotalOrders,
      'totalTotalRevenue': totalTotalRevenue,
      'averageCtr': averageCtr,
      'averageCpc': averageCpc,
      'averageCpa': averageCpa,
      'averageRoas': averageRoas,
    };

    return adReportExcelTotal;
  }
}
