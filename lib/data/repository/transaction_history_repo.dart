
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:payx/data/api/api_client.dart';
import 'package:payx/util/app_constants.dart';

class TransactionHistoryRepo{
  final ApiClient apiClient;

  TransactionHistoryRepo({@required this.apiClient});

  Future<Response> getTransactionHistory(int offset) async {
    return await apiClient.getData('${AppConstants.CUSTOMER_TRANSACTION_HISTORY}?limit=1000&offset=$offset');
  }
}