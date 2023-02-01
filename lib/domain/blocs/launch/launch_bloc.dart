import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import 'package:order_automation/data/repositories/get_json.dart';
import 'package:order_automation/data/repositories/get_keys.dart';
import 'package:excel/excel.dart';

part 'launch_event.dart';

part 'launch_state.dart';

part 'launch_event_type.dart';

class LaunchBloc extends Bloc<LaunchEvent, LaunchState> {
  LaunchBloc() : super(LaunchInitial()) {
    on<LaunchEventStarted>(_onStarted);
    on<LaunchEventClicked>(_onClicked);
    on<LaunchEventTextEditing>(_onTextEditing);
    on<LaunchEventRefreshed>(_onRefreshed);
    on<LaunchEventOrderListPrintClicked>(_onOrderListPrintClicked);
    on<LaunchEventTextFieldClicked>(_onTextFieldClicked);
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

    List data = [];
    GetJson getJson = GetJson();
    data = await getJson.get();

    emit(state.copyWith(
      eventType: LaunchEventType.started,
      status: FormzStatus.submissionSuccess,
      keys: keys,
      keyTextFieldClicked: false,
      getData: data,

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

  void _onOrderListPrintClicked(
    LaunchEventOrderListPrintClicked event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.copyWith(
      eventType: LaunchEventType.orderListPrintClicked,
      status: FormzStatus.submissionInProgress,
    ));

    List data = [];
    GetJson getJson = GetJson();
    data = await getJson.get();

    // dataList = dataMap['data'];
    //
    // GetCoupangKeys getCoupangKeys = GetCoupangKeys();
    // List<String> keys = getCoupangKeys.getCoupangKeys();
    //
    // var excel = Excel.createExcel();
    // Sheet sheet = excel[excel.getDefaultSheet() ?? 'Sheet1'];
    //
    // List<String> columnText = [
    //   'A',
    //   'B',
    //   'C',
    //   'D',
    //   'E',
    //   'F',
    //   'G',
    //   'H',
    //   'I',
    //   'J',
    //   'K',
    //   'L',
    //   'M',
    //   'N',
    //   'O',
    // ];
    //
    // sheet.cell(CellIndex.indexByString('${columnText[0]}1')).value = '마켓';
    // sheet.cell(CellIndex.indexByString('${columnText[1]}1')).value = '상품번호';
    // sheet.cell(CellIndex.indexByString('${columnText[2]}1')).value = '옵션코드';
    // sheet.cell(CellIndex.indexByString('${columnText[3]}1')).value = '옵션명';
    // sheet.cell(CellIndex.indexByString('${columnText[4]}1')).value = '수량';
    // sheet.cell(CellIndex.indexByString('${columnText[5]}1')).value = '수령자명';
    // sheet.cell(CellIndex.indexByString('${columnText[6]}1')).value = '우편번호';
    // sheet.cell(CellIndex.indexByString('${columnText[7]}1')).value = '배송주소';
    // sheet.cell(CellIndex.indexByString('${columnText[8]}1')).value =
    //     '배송 상세주소(선택입력)';
    // sheet.cell(CellIndex.indexByString('${columnText[9]}1')).value = '휴대전화';
    // sheet.cell(CellIndex.indexByString('${columnText[10]}1')).value =
    //     '추가연락처(선택입력)';
    // sheet.cell(CellIndex.indexByString('${columnText[11]}1')).value =
    //     '쇼핑몰명(도매매 전용)';
    // sheet.cell(CellIndex.indexByString('${columnText[12]}1')).value = '전달사항';
    // sheet.cell(CellIndex.indexByString('${columnText[13]}1')).value =
    //     '배송요청사항(도매매 전용)';
    // sheet.cell(CellIndex.indexByString('${columnText[14]}1')).value =
    //     '통관고유번호(해외직배송 전용)';
    //
    // for (int i = 0; i < dataList.length; i++) {
    //   int cellRowNumber = i + 2;
    //   sheet.cell(CellIndex.indexByString('A$cellRowNumber')).value = '도매매';
    //   String bValue = dataList[i]['orderItems'][0]['sellerProductName'];
    //   if (bValue.contains('a')) {
    //     sheet.cell(CellIndex.indexByString('B$cellRowNumber')).value =
    //         bValue.substring(0, bValue.indexOf('a'));
    //   } else {
    //     sheet.cell(CellIndex.indexByString('B$cellRowNumber')).value = bValue;
    //   }
    //   sheet.cell(CellIndex.indexByString('C$cellRowNumber')).value =
    //       dataList[i]['orderItems'][0]['externalVendorSkuCode'];
    //   sheet.cell(CellIndex.indexByString('D$cellRowNumber')).value = '';
    //   sheet.cell(CellIndex.indexByString('E$cellRowNumber')).value =
    //       dataList[i]['orderItems'][0]['shippingCount'].toString();
    //   sheet.cell(CellIndex.indexByString('F$cellRowNumber')).value =
    //       dataList[i]['receiver']['name'];
    //   sheet.cell(CellIndex.indexByString('G$cellRowNumber')).value =
    //       dataList[i]['receiver']['postCode'];
    //   sheet.cell(CellIndex.indexByString('H$cellRowNumber')).value = dataList[i]
    //           ['receiver']['addr1'] +
    //       ' ' +
    //       dataList[i]['receiver']['addr2'];
    //   sheet.cell(CellIndex.indexByString('I$cellRowNumber')).value = '';
    //   sheet.cell(CellIndex.indexByString('J$cellRowNumber')).value =
    //       dataList[i]['receiver']['safeNumber'];
    //   sheet.cell(CellIndex.indexByString('K$cellRowNumber')).value = '';
    //   sheet.cell(CellIndex.indexByString('L$cellRowNumber')).value = keys[3];
    //   sheet.cell(CellIndex.indexByString('M$cellRowNumber')).value = '';
    //   sheet.cell(CellIndex.indexByString('N$cellRowNumber')).value =
    //       dataList[i]['parcelPrintMessage'];
    //   sheet.cell(CellIndex.indexByString('O$cellRowNumber')).value = '';
    // }
    //
    // int newDataListLength = dataList.length;
    // List<String> cValueList = [];
    //
    // for (int j = 2; j < dataList.length; j++) {
    //   String cValue =
    //       sheet.cell(CellIndex.indexByString('C$j')).value.toString();
    //   if (cValue.contains('a')) {
    //     cValue = cValue.replaceAll('a', '');
    //     double cValueNumber = cValue.length / 2;
    //
    //     for (int k = 0; k < cValueNumber - 1; k++) {
    //       cValueList[k] = cValue.substring((k * 2) + 1, (k * 2) + 3);
    //     }
    //
    //     for (int l = 0; l < cValueNumber - 1; l++) {
    //       if (l == 0) {
    //         sheet.cell(CellIndex.indexByString('C$l')).value = cValueList[l];
    //       } else {
    //         newDataListLength++;
    //
    //         for (int m = 0; m < columnText.length; m++) {
    //           if (columnText[m] == 'C') {
    //             sheet
    //                 .cell(CellIndex.indexByString(
    //                     '${columnText[m]}$newDataListLength'))
    //                 .value = cValueList[l];
    //           } else {
    //             sheet
    //                     .cell(CellIndex.indexByString(
    //                         '${columnText[m]}$newDataListLength'))
    //                     .value =
    //                 sheet
    //                     .cell(CellIndex.indexByString('${columnText[m]}$l'))
    //                     .value;
    //           }
    //         }
    //       }
    //     }
    //   }
    // }
    //
    // String fileName =
    //     DateFormat('MM월dd일hh시mm분 쿠팡 도매매 발주').format(DateTime.now());
    // excel.save(
    //   fileName: '$fileName.xlsx',
    // );
    // html.window.open(
    //     'https://domeggook.com/main/myBuy/order/my_orderExcelForm.php',
    //     'new tab');

    emit(state.copyWith(
      eventType: LaunchEventType.orderListPrintClicked,
      status: FormzStatus.submissionSuccess,
      getData: data,
    ));
  }

  void _onTextFieldClicked(
    LaunchEventTextFieldClicked event,
    Emitter<LaunchState> emit,
  ) async {
    emit(state.copyWith(
      eventType: LaunchEventType.textFieldClicked,
      status: FormzStatus.submissionInProgress,
    ));

    emit(state.copyWith(
      eventType: LaunchEventType.textFieldClicked,
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

    bool isKeyTextFieldClicked = !state.keyTextFieldClicked!;

    emit(state.copyWith(
      eventType: LaunchEventType.keyTextFieldClicked,
      status: FormzStatus.submissionSuccess,
      keyTextFieldClicked: isKeyTextFieldClicked,
    ));
  }
}
