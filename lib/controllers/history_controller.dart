import 'package:crypto_template/controllers/SnackbarController.dart';
import 'package:crypto_template/controllers/error_controller.dart';
import 'package:crypto_template/models/deposit_histroy_response.dart';
import 'package:crypto_template/models/trade_histroy_response.dart';
import 'package:crypto_template/models/withdraw_history_response.dart';
import 'package:crypto_template/repository/wallet_repository.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class HistoryController extends GetxController {
  var isLoading = true.obs;
  var isDepositHistoryLoading = true.obs;
  var isWithdrawHistoryLoading = true.obs;
  var isTradeHistoryLoading = true.obs;
  var depositHistory = List<DepositHistoryResponse>().obs;
  var withdrawHistory = List<WithdrawHistoryResponse>().obs;
  var tradeHistory = List<TradeHistoryResponse>().obs;
  SnackbarController snackbarController;
  ErrorController errorController = new ErrorController();

  @override
  void onInit() {
    fetchDepositHistory();
    fetchWithdrawHistory();
    fetchTradeHistory();
    super.onInit();
  }

  void fetchDepositHistory() async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      isDepositHistoryLoading(true);
      var depositHistoryResponse =
          await _walletRepository.fetchDepositHistory('');

      depositHistoryResponse.sort((a, b) {
        String adate = DateFormat('yyyy-MM-dd hh:mm:ss').format(a.createdAt);
        String bdate = DateFormat('yyyy-MM-dd hh:mm:ss').format(b.createdAt);
        return -adate.compareTo(bdate);
      });

      depositHistory.assignAll(depositHistoryResponse);
      isDepositHistoryLoading(false);
    } catch (error) {
      isDepositHistoryLoading(false);
      errorController.handleError(error);
    }
  }

  void fetchWithdrawHistory() async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      isWithdrawHistoryLoading(true);
      var withdrawlHistoryResponse =
          await _walletRepository.fetchWithdrawHistory('');

      withdrawlHistoryResponse.sort((a, b) {
        String adate = DateFormat('yyyy-MM-dd hh:mm:ss').format(a.createdAt);
        String bdate = DateFormat('yyyy-MM-dd hh:mm:ss').format(b.createdAt);
        return -adate.compareTo(bdate);
      });

      withdrawHistory.assignAll(withdrawlHistoryResponse);
      isWithdrawHistoryLoading(false);
    } catch (error) {
      isWithdrawHistoryLoading(false);
      errorController.handleError(error);
    }
  }

  void fetchTradeHistory() async {
    WalletRepository _walletRepository = new WalletRepository();
    try {
      isTradeHistoryLoading(true);
      var tradeHistoryResponse = await _walletRepository.fetchTradeHistory('');

      tradeHistoryResponse.sort((a, b) {
        String adate = DateFormat('yyyy-MM-dd hh:mm:ss').format(a.createdAt);
        String bdate = DateFormat('yyyy-MM-dd hh:mm:ss').format(b.createdAt);
        return -adate.compareTo(bdate);
      });
      tradeHistory.assignAll(tradeHistoryResponse);

      isTradeHistoryLoading(false);
    } catch (error) {
      isTradeHistoryLoading(false);
      errorController.handleError(error);
    }
  }

  @override
  void onClose() {
    super.onClose();
  }
}
