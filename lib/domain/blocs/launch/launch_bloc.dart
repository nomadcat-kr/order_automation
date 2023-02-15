import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:order_automation/data/repositories/coupang_api.dart';
import 'package:order_automation/data/repositories/get_delivery_company_code.dart';
import 'package:order_automation/data/repositories/get_keys.dart';
import 'package:excel/excel.dart';
import 'package:universal_platform/universal_platform.dart';
// import 'dart:html' as html;

import '../../../app/common/common.dart';

part 'launch_event.dart';

part 'launch_state.dart';

part 'launch_event_type.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  LaunchBloc() : super(LaunchInitial()) {
    on<LaunchEventStarted>(_onStarted);
    on<LaunchEventClicked>(_onClicked);
    on<LaunchEventTextEditing>(_onTextEditing);
    on<LaunchEventRefreshed>(_onRefreshed);
    on<LaunchEventOrderListUploadClicked>(_onOrderListUploadClicked);
    on<LaunchEventOrderListDownloadClicked>(_onOrderListDownloadClicked);
    on<LaunchEventInvoiceListUploadClicked>(_onInvoiceListUploadClicked);
    on<LaunchEventInvoiceListPutRequestClicked>(
        _onInvoiceListPutRequestClicked);
    on<LaunchEventSettlementHistoryGetClicked>(_onSettlementHistoryGetClicked);
    on<LaunchEventKeyTextFieldClicked>(_onKeyTextFieldClicked);
  }

  void _onStarted(
    LaunchEventStarted event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.copyWith(
      eventType: LaunchEventType.started,
      status: FormzStatus.submissionInProgress,
    ));

    GetCoupangKeys getCoupangKeys = GetCoupangKeys();
    List<String> keys = getCoupangKeys.getCoupangKeys();

    if (UniversalPlatform.isWeb) {
      emit(state.copyWith(
        eventType: LaunchEventType.started,
        status: FormzStatus.submissionSuccess,
        keys: keys,
      ));
      return;
    }

    List statusAcceptList = [];
    List statusInstructList = [];
    List statusDepartureList = [];
    List statusDeliveringList = [];
    List statusFinalDeliveryList = [];
    List consumerService = [];
    List callCenterInquiries = [];
    Map revenueHistory = {};

    if (!keys.contains('')) {
      CoupangApi coupangApi = CoupangApi();
      statusAcceptList = await coupangApi.coupangGetOrderSheet(
          coupangStatusAccept, 'ordersheets');
      emit(state.copyWith(
        eventType: LaunchEventType.started,
        status: FormzStatus.submissionInProgress,
        onStartedProgress: 1 / 8,
      ));
      statusInstructList = await coupangApi.coupangGetOrderSheet(
          coupangStatusInstruct, 'ordersheets');
      emit(state.copyWith(
        eventType: LaunchEventType.started,
        status: FormzStatus.submissionInProgress,
        onStartedProgress: 2 / 8,
      ));
      statusDepartureList = await coupangApi.coupangGetOrderSheet(
          coupangStatusDeparture, 'ordersheets');
      emit(state.copyWith(
        eventType: LaunchEventType.started,
        status: FormzStatus.submissionInProgress,
        onStartedProgress: 3 / 8,
      ));
      statusDeliveringList = await coupangApi.coupangGetOrderSheet(
          coupangStatusDelivering, 'ordersheets');
      emit(state.copyWith(
        eventType: LaunchEventType.started,
        status: FormzStatus.submissionInProgress,
        onStartedProgress: 4 / 8,
      ));
      statusFinalDeliveryList = await coupangApi.coupangGetOrderSheet(
          coupangStatusFinalDelivery, 'ordersheets');
      emit(state.copyWith(
        eventType: LaunchEventType.started,
        status: FormzStatus.submissionInProgress,
        onStartedProgress: 5 / 8,
      ));
      consumerService = await coupangApi.coupangGetConsumerService();
      emit(state.copyWith(
        eventType: LaunchEventType.started,
        status: FormzStatus.submissionInProgress,
        onStartedProgress: 6 / 8,
      ));
      callCenterInquiries = await coupangApi.coupangGetCallCenterInquiries();
      emit(state.copyWith(
        eventType: LaunchEventType.started,
        status: FormzStatus.submissionInProgress,
        onStartedProgress: 7 / 8,
      ));
      revenueHistory =
          await coupangApi.coupangGetRevenueHistoryFromOrderSheet();
      emit(state.copyWith(
        eventType: LaunchEventType.started,
        status: FormzStatus.submissionInProgress,
        onStartedProgress: 8 / 8,
      ));
      // await coupangApi.coupangGetRevenueHistory();
    }

    emit(state.copyWith(
      eventType: LaunchEventType.started,
      status: FormzStatus.submissionSuccess,
      keys: keys,
      statusAccept: statusAcceptList,
      statusInstruct: statusInstructList,
      statusDeparture: statusDepartureList,
      statusDelivering: statusDeliveringList,
      statusFinalDelivery: statusFinalDeliveryList,
      consumerService: consumerService,
      callCenterInquiries: callCenterInquiries,
      revenueHistory: revenueHistory,
      keyTextFieldClicked: false,
      onStartedProgress: 0,
    ));
  }

  void _onClicked(
    LaunchEventClicked event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.copyWith(
      eventType: LaunchEventType.clicked,
      status: FormzStatus.submissionInProgress,
    ));

    emit(state.copyWith(
      eventType: LaunchEventType.clicked,
      status: FormzStatus.submissionSuccess,
    ));
  }

  void _onTextEditing(
    LaunchEventTextEditing event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.copyWith(
      eventType: LaunchEventType.textEditing,
      status: FormzStatus.submissionInProgress,
    ));

    // String text = event.inputText;

    emit(state.copyWith(
      eventType: LaunchEventType.textEditing,
      status: FormzStatus.submissionSuccess,
    ));
  }

  void _onRefreshed(
    LaunchEventRefreshed event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.copyWith(
      eventType: LaunchEventType.refreshed,
      status: FormzStatus.submissionInProgress,
    ));

    emit(state.copyWith(
      eventType: LaunchEventType.refreshed,
      status: FormzStatus.submissionSuccess,
    ));
  }

  void _onOrderListUploadClicked(
    LaunchEventOrderListUploadClicked event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.copyWith(
      eventType: LaunchEventType.orderListUploadClicked,
      status: FormzStatus.submissionInProgress,
    ));

    List dataList = [];
    CoupangApi coupangApiRequest = CoupangApi();
    dataList = await coupangApiRequest.coupangGetOrderSheet(
        coupangStatusAccept, 'ordersheets');

    GetCoupangKeys getCoupangKeys = GetCoupangKeys();
    List<String> keys = getCoupangKeys.getCoupangKeys();

    var excel = Excel.createExcel();
    Sheet sheet = excel[excel.getDefaultSheet() ?? 'Sheet1'];

    List<String> columnText = [
      'A',
      'B',
      'C',
      'D',
      'E',
      'F',
      'G',
      'H',
      'I',
      'J',
      'K',
      'L',
      'M',
      'N',
      'O',
    ];

    sheet.cell(CellIndex.indexByString('${columnText[0]}1')).value = '마켓';
    sheet.cell(CellIndex.indexByString('${columnText[1]}1')).value = '상품번호';
    sheet.cell(CellIndex.indexByString('${columnText[2]}1')).value = '옵션코드';
    sheet.cell(CellIndex.indexByString('${columnText[3]}1')).value = '옵션명';
    sheet.cell(CellIndex.indexByString('${columnText[4]}1')).value = '수량';
    sheet.cell(CellIndex.indexByString('${columnText[5]}1')).value = '수령자명';
    sheet.cell(CellIndex.indexByString('${columnText[6]}1')).value = '우편번호';
    sheet.cell(CellIndex.indexByString('${columnText[7]}1')).value = '배송주소';
    sheet.cell(CellIndex.indexByString('${columnText[8]}1')).value =
        '배송 상세주소(선택입력)';
    sheet.cell(CellIndex.indexByString('${columnText[9]}1')).value = '휴대전화';
    sheet.cell(CellIndex.indexByString('${columnText[10]}1')).value =
        '추가연락처(선택입력)';
    sheet.cell(CellIndex.indexByString('${columnText[11]}1')).value =
        '쇼핑몰명(도매매 전용)';
    sheet.cell(CellIndex.indexByString('${columnText[12]}1')).value = '전달사항';
    sheet.cell(CellIndex.indexByString('${columnText[13]}1')).value =
        '배송요청사항(도매매 전용)';
    sheet.cell(CellIndex.indexByString('${columnText[14]}1')).value =
        '통관고유번호(해외직배송 전용)';

    for (int i = 0; i < dataList.length; i++) {
      int cellRowNumber = i + 2;
      sheet.cell(CellIndex.indexByString('A$cellRowNumber')).value = '도매매';
      String bValue = dataList[i]['orderItems'][0]['sellerProductName'];
      if (bValue.contains('a')) {
        sheet.cell(CellIndex.indexByString('B$cellRowNumber')).value =
            bValue.substring(0, bValue.indexOf('a'));
      } else {
        sheet.cell(CellIndex.indexByString('B$cellRowNumber')).value = bValue;
      }
      sheet.cell(CellIndex.indexByString('C$cellRowNumber')).value =
          dataList[i]['orderItems'][0]['externalVendorSkuCode'];
      sheet.cell(CellIndex.indexByString('D$cellRowNumber')).value = '';
      sheet.cell(CellIndex.indexByString('E$cellRowNumber')).value =
          dataList[i]['orderItems'][0]['shippingCount'].toString();
      sheet.cell(CellIndex.indexByString('F$cellRowNumber')).value =
          dataList[i]['receiver']['name'];
      sheet.cell(CellIndex.indexByString('G$cellRowNumber')).value =
          dataList[i]['receiver']['postCode'];
      sheet.cell(CellIndex.indexByString('H$cellRowNumber')).value = dataList[i]
              ['receiver']['addr1'] +
          ' ' +
          dataList[i]['receiver']['addr2'];
      sheet.cell(CellIndex.indexByString('I$cellRowNumber')).value = '';
      sheet.cell(CellIndex.indexByString('J$cellRowNumber')).value =
          dataList[i]['receiver']['safeNumber'];
      sheet.cell(CellIndex.indexByString('K$cellRowNumber')).value = '';
      sheet.cell(CellIndex.indexByString('L$cellRowNumber')).value = keys[3];
      sheet.cell(CellIndex.indexByString('M$cellRowNumber')).value = '';
      sheet.cell(CellIndex.indexByString('N$cellRowNumber')).value =
          dataList[i]['parcelPrintMessage'];
      sheet.cell(CellIndex.indexByString('O$cellRowNumber')).value = '';
    }

    int newDataListLength = dataList.length;
    List<String> cValueList = [];

    for (int j = 2; j < dataList.length; j++) {
      String cValue =
          sheet.cell(CellIndex.indexByString('C$j')).value.toString();
      if (cValue.contains('a')) {
        cValue = cValue.replaceAll('a', '');
        double cValueNumber = cValue.length / 2;

        for (int k = 0; k < cValueNumber - 1; k++) {
          cValueList[k] = cValue.substring((k * 2) + 1, (k * 2) + 3);
        }

        for (int l = 0; l < cValueNumber - 1; l++) {
          if (l == 0) {
            sheet.cell(CellIndex.indexByString('C$l')).value = cValueList[l];
          } else {
            newDataListLength++;

            for (int m = 0; m < columnText.length; m++) {
              if (columnText[m] == 'C') {
                sheet
                    .cell(CellIndex.indexByString(
                        '${columnText[m]}$newDataListLength'))
                    .value = cValueList[l];
              } else {
                sheet
                        .cell(CellIndex.indexByString(
                            '${columnText[m]}$newDataListLength'))
                        .value =
                    sheet
                        .cell(CellIndex.indexByString('${columnText[m]}$l'))
                        .value;
              }
            }
          }
        }
      }
    }

    // String fileName =
    //     DateFormat('MM월dd일hh시mm분 쿠팡 도매매 발주').format(DateTime.now());
    // excel.save(
    //   fileName: '$fileName.xlsx',
    // );

    var fileBytes = excel.save();

    List<String> shipmentBoxIds = [];
    List<Map<String, dynamic>> onGoingOrders = [];

    for (int n = 0; n < dataList.length; n++) {
      shipmentBoxIds.add(dataList[n]['shipmentBoxId'].toString());
      onGoingOrders.add({
        'vendorId': keys[0],
        'orderSheetInvoiceApplyDtos': {
          'shipmentBoxId': dataList[n]['shipmentBoxId'].toString(),
          'orderId': dataList[n]['orderId'].toString(),
          'deliveryCompanyCode': '',
          'invoiceNumber': '',
          'vendorItemId':
              dataList[n]['orderItems'][0]['vendorItemId'].toString(),
          'splitShipping': 'false',
          'preSplitShipped': 'false',
          'estimatedShippingDate': '',
        },
        'name': dataList[n]['receiver']['name'],
        'safeNumber': dataList[n]['receiver']['safeNumber'],
      });
    }

    FirebaseFirestore.instance.collection(coupang).doc(keys[0]).update({
      'excel': fileBytes,
      'onGoingOrders': onGoingOrders,
    });

    await coupangApiRequest.coupangPutOrderSheet(
        shipmentBoxIds, 'ordersheets/acknowledgement');

    emit(state.copyWith(
      eventType: LaunchEventType.orderListUploadClicked,
      status: FormzStatus.submissionSuccess,
    ));
  }

  void _onOrderListDownloadClicked(
    LaunchEventOrderListDownloadClicked event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.copyWith(
      eventType: LaunchEventType.orderListDownloadClicked,
      status: FormzStatus.submissionInProgress,
    ));

    GetCoupangKeys getCoupangKeys = GetCoupangKeys();
    List<String> keys = getCoupangKeys.getCoupangKeys();

    var excelDoc = FirebaseFirestore.instance.collection(coupang).doc(keys[0]);

    List<dynamic> excel = [];
    List<int> excelInt = [];

    await excelDoc.get().then((snapshot) {
      excel = snapshot.data()?['excel'];
    });

    for (int i = 0; i < excel.length; i++) {
      excelInt.add(excel[i]);
    }

    FirebaseFirestore.instance.collection(coupang).doc(keys[0]).update({
      'excel': [],
    });

    String dateFormat =
        DateFormat('yy년MM월dd일hh시mm분 쿠팡 도매매').format(DateTime.now());

    var excelFile = Excel.decodeBytes(excelInt);
    excelFile.save(fileName: '$dateFormat.xlsx');

    // html.window.open(
    //     'https://domeggook.com/main/myBuy/order/my_orderExcelForm.php',
    //     'new tab');

    emit(state.copyWith(
      eventType: LaunchEventType.orderListDownloadClicked,
      status: FormzStatus.submissionSuccess,
    ));
  }

  void _onInvoiceListUploadClicked(
    LaunchEventInvoiceListUploadClicked event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.copyWith(
      eventType: LaunchEventType.invoiceListUploadClicked,
      status: FormzStatus.submissionInProgress,
    ));

    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx'],
      allowMultiple: false,
    );

    if (pickedFile == null) {
      emit(state.copyWith(
        eventType: LaunchEventType.invoiceListUploadClicked,
        status: FormzStatus.submissionSuccess,
      ));
      return;
    }

    Uint8List? file = pickedFile.files.single.bytes;
    debugPrint(file.toString());
    var excel = Excel.decodeBytes(file!);
    Sheet sheet = excel[excel.getDefaultSheet() ?? 'Sheet1'];
    int lastRow = sheet.maxRows;

    List<Map<String, dynamic>> excelDataList = [];

    for (int i = 0; i < lastRow; i++) {
      int cellRowNumber = i + 2;
      excelDataList.add({
        'name': sheet
                .cell(CellIndex.indexByString('W$cellRowNumber'))
                .value
                .toString() ??
            '',
        'safeNumber': sheet
                .cell(CellIndex.indexByString('Z$cellRowNumber'))
                .value
                .toString() ??
            '',
        'deliveryCompanyCode': sheet
                .cell(CellIndex.indexByString('T$cellRowNumber'))
                .value
                .toString() ??
            '',
        'invoiceNumber': sheet
                .cell(CellIndex.indexByString('U$cellRowNumber'))
                .value
                .toString() ??
            '',
      });
    }

    GetCoupangKeys getCoupangKeys = GetCoupangKeys();
    List<String> keys = getCoupangKeys.getCoupangKeys();

    var onGoingOrdersDoc =
        FirebaseFirestore.instance.collection(coupang).doc(keys[0]);

    List<dynamic> onGoingOrders = [];
    List<dynamic> onGoingDeleteOrders = [];
    Map<String, dynamic> completeOrder = {};
    List<Map<String, dynamic>> completeOrders = [];

    await onGoingOrdersDoc.get().then((snapshot) {
      onGoingOrders = snapshot.data()?['onGoingOrders'];
    });

    GetDeliveryCompanyCode getDeliveryCompanyCode = GetDeliveryCompanyCode();
    String deliveryCompanyCode = '';

    for (int j = 0; j < onGoingOrders.length; j++) {
      for (int k = 0; k < excelDataList.length; k++) {
        if (onGoingOrders[j]['name'] == excelDataList[k]['name'] &&
            onGoingOrders[j]['safeNumber'] == excelDataList[k]['safeNumber']) {
          completeOrder = onGoingOrders[j];
          deliveryCompanyCode = getDeliveryCompanyCode
              .getDeliveryCompanyCode(excelDataList[k]['deliveryCompanyCode']);
          completeOrder['orderSheetInvoiceApplyDtos']['deliveryCompanyCode'] =
              deliveryCompanyCode;
          completeOrder['orderSheetInvoiceApplyDtos']['invoiceNumber'] =
              excelDataList[k]['invoiceNumber'];
          completeOrder.remove('name');
          completeOrder.remove('safeNumber');
          completeOrders.add(completeOrder);
        } else {
          onGoingDeleteOrders.add(onGoingOrders);
        }
      }
    }

    onGoingDeleteOrders.toSet().toList();

    await onGoingOrdersDoc.update({
      'onGoingOrders': onGoingDeleteOrders,
      'completeOrders': completeOrders,
    });

    emit(state.copyWith(
      eventType: LaunchEventType.invoiceListUploadClicked,
      status: FormzStatus.submissionSuccess,
    ));
  }

  void _onInvoiceListPutRequestClicked(
    LaunchEventInvoiceListPutRequestClicked event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.copyWith(
      eventType: LaunchEventType.invoiceListPutRequestClicked,
      status: FormzStatus.submissionInProgress,
    ));

    GetCoupangKeys getCoupangKeys = GetCoupangKeys();
    List<String> keys = getCoupangKeys.getCoupangKeys();

    var onGoingOrdersDoc =
        FirebaseFirestore.instance.collection(coupang).doc(keys[0]);

    List<dynamic> completeOrders = [];

    await onGoingOrdersDoc.get().then((snapshot) {
      completeOrders = snapshot.data()?['completeOrders'];
    });

    CoupangApi coupangApiRequest = CoupangApi();

    for (int i = 0; i < completeOrders.length; i++) {
      await coupangApiRequest.coupangPostOrderShipping(
          completeOrders[i]['orderSheetInvoiceApplyDtos'], 'orders/invoices');
    }

    FirebaseFirestore.instance.collection(coupang).doc(keys[0]).update({
      'completeOrders': [],
    });

    emit(state.copyWith(
      eventType: LaunchEventType.invoiceListPutRequestClicked,
      status: FormzStatus.submissionSuccess,
    ));
  }

  void _onSettlementHistoryGetClicked(
    LaunchEventSettlementHistoryGetClicked event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.copyWith(
      eventType: LaunchEventType.settlementHistoryGetClicked,
      status: FormzStatus.submissionInProgress,
    ));

    emit(state.copyWith(
      eventType: LaunchEventType.settlementHistoryGetClicked,
      status: FormzStatus.submissionSuccess,
    ));
  }

  void _onKeyTextFieldClicked(
    LaunchEventKeyTextFieldClicked event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.copyWith(
      eventType: LaunchEventType.keyTextFieldClicked,
      status: FormzStatus.submissionInProgress,
    ));

    bool isKeyTextFieldClicked = !state.keyTextFieldClicked;

    emit(state.copyWith(
      eventType: LaunchEventType.keyTextFieldClicked,
      status: FormzStatus.submissionSuccess,
      keyTextFieldClicked: isKeyTextFieldClicked,
    ));
  }
}
