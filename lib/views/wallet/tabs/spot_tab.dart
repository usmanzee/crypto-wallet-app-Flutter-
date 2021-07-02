import 'package:b4u_wallet/controllers/market_controller.dart';
import 'package:b4u_wallet/controllers/wallet_controller.dart';
import 'package:b4u_wallet/utils/Helpers/estimate_value.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../wallet_tab_widget.dart';

class SpotTab extends StatelessWidget {
  final walletController = Get.find<WalletController>();
  final marketController = Get.find<MarketController>();

  @override
  Widget build(BuildContext context) {
    var estimatedValue = EstimatedValue.estimateValue(
      'USD',
      walletController.currenciesList,
      walletController.walletsList,
      marketController.marketList,
      marketController.marketTickerList,
    );
    var estimatedValueSecondary = EstimatedValue.estimateUnitValue(
        'BTC',
        'USD',
        estimatedValue,
        walletController.currenciesList,
        marketController.marketList,
        marketController.marketTickerList,
    );
    return Scaffold(
      body: Obx((){
        return WalletTabWidget(estimatedValue: estimatedValue.toString(),estimatedValueSecondary: estimatedValueSecondary,walletsList: walletController.walletsList);
      }),
    );
  }
}
