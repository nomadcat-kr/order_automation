class OrderListPrintRepository {
  OrderListPrintRepository._internal();

  static final OrderListPrintRepository _instance = OrderListPrintRepository._internal();

  factory OrderListPrintRepository() => _instance;

  List dataList = [];
}