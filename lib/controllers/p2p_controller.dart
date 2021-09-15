import 'dart:async';

import 'package:b4u_wallet/controllers/error_controller.dart';
import 'package:b4u_wallet/models/p2p_offer/p2p_offer.dart';
import 'package:b4u_wallet/repository/p2p_repository.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pController extends GetxController {
  ErrorController errorController = ErrorController();
  P2pRepository _p2pRepository = P2pRepository();
  RxBool isLoading = true.obs;
  RxString selectedCurrency = 'UAH'.obs;

  //p2p bottomNav Index
  RxInt initialIndex = 0.obs;

  //buy sell page or express page
  RxBool buySellOrExpress = true.obs;

  // true means buy and false means sell
  RxBool buyOrSellP2p = true.obs;
  RxBool buyOrSellExpress = true.obs;

  // history filters
  RxString typeSelected = 'All'.obs;
  RxString statusSelected = 'All'.obs;

  //profile page
  RxInt user30DaysTrades = 0.obs;
  RxInt averageReleaseTime = 0.obs;
  RxInt averagePayTime = 0.obs;
  RxDouble user30DaysCompletionRate = 0.00.obs;

  /* RxList<P2POffer> p2pOffersBuy = <P2POffer>[].obs;
  RxList<P2POffer> p2pOffersSell = <P2POffer>[].obs;*/
  //usdt list
  RxList<P2POffer> usdBuy = <P2POffer>[].obs;
  RxList<P2POffer> usdSell = <P2POffer>[].obs;

  //btc list
  RxList<P2POffer> btcBuy = <P2POffer>[].obs;
  RxList<P2POffer> btcSell = <P2POffer>[].obs;

  //trst list
  RxList<P2POffer> trstBuy = <P2POffer>[].obs;
  RxList<P2POffer> trstSell = <P2POffer>[].obs;

  //usdt list
  RxList<P2POffer> ethBuy = <P2POffer>[].obs;
  RxList<P2POffer> ethSell = <P2POffer>[].obs;

  //express transaction by crypto or cash, true means by crypto and false means by cash
  RxBool cryptoOrCash = true.obs;

  //for the feedback reviews changing
  RxString reviewChosen = 'All'.obs;

  // notifications page
  RxBool ordersEmailEnable = true.obs;
  RxBool ordersSmsEnable = true.obs;
  RxBool ordersAppNotificationsEnable = true.obs;
  RxBool appealsEmailEnable = true.obs;
  RxBool appealsSmsEnable = true.obs;
  RxBool appealsAppNotificationsEnable = true.obs;
  RxBool securityEmailEnable = true.obs;
  RxBool securitySmsEnable = true.obs;
  RxBool securityAppNotificationsEnable = true.obs;

  //select currency page listview scrollController
  ScrollController scrollController;
  RxBool showTopButton = false.obs;

  //selected current offer variables

  //change the limit and other variables on tab swipe
  RxBool fiatOrCrypto = true.obs;

  //pending transaction page
  RxBool clientContainer = true.obs;
  RxBool paymentContainer = true.obs;

  // payment method page
  RxBool termsContainer = true.obs;
  RxBool dialogConfirm = false.obs;

  //p2p payment release page
  RxBool pContainer = true.obs;

  //extra for just view will be deleted
  RxList<Widget> a = <Widget>[].obs;
  RxInt radioValue = 0.obs;
  RxString selectedReason = 'Tap here to select a reason...'.obs;
  RxBool buyerOrSeller = true.obs;

  //post normal ad page variables
  RxList<P2POffer> userAddedP2pOffers = <P2POffer>[].obs;
  RxBool secondPage = false.obs;
  RxBool thirdPage = false.obs;

  //post normal add first page
  RxString firstBuySell = 'Buy'.obs;
  RxString firstFixedFloating = 'Fixed'.obs;
  RxString firstSelectedAsset = 'btc'.obs;
  RxString firstSelectedFiat = 'btc'.obs;
  RxString firstYourPrice = ''.obs;
  RxString firstHighestOrderPrice = ''.obs;

  //post normal add second page
  RxString secondSelectedAsset = ''.obs;
  RxString secondAddedAmountInFiat = ''.obs;
  RxString secondAddedAmountInAsset = ''.obs;
  RxString secondSelectedFiat = ''.obs;
  RxInt secondTimeLimitInt = 15.obs;
  RxString secondTimeLimitString = ''.obs;
  RxDouble secondReservedFee = 0.07.obs;
  RxBool secondShowReservedFee = false.obs;

  //post normal add third page
  RxBool thirdKyc = true.obs;
  RxBool thirdRegisteredDays = false.obs;
  RxBool thirdBtc = false.obs;
  RxInt thirdOnlineOffline = 1.obs;

  @override
  void onClose() {
    scrollController.dispose();
    super.onClose();
  }

  @override
  void onReady() {
    fetchAllLists(true);
    fetchUserP2pAddedOffers();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.offset >= 300) {
        // print(scrollController.offset);
        showTopButton.value = true;
      } else {
        // print(scrollController.offset);
        showTopButton.value = false;
      }
    });
    // ever(isLoading, fetchAllLists);
    super.onReady();
  }

  @override
  void onInit() {
    // fetchP2pOffers();
    super.onInit();
  }

  void fetchAllLists(bool val) async {
    isLoading(val);
    await fetchP2pOffers(category: 'usd', buyList: usdBuy, sellList: usdSell);
    await fetchP2pOffers(category: 'eth', buyList: ethBuy, sellList: ethSell);
    await fetchP2pOffers(
        category: 'trst', buyList: trstBuy, sellList: trstSell);
    await fetchP2pOffers(category: 'btc', buyList: btcBuy, sellList: btcSell);
    isLoading(false);
  }

  Future<bool> fetchP2pOffers({
    String category,
    RxList<P2POffer> buyList,
    RxList<P2POffer> sellList,
  }) async {
    // isLoading(true);
    try {
      final response = await _p2pRepository.fetchP2pOffers(category: category);
      if (response.length > 0) {
        response.forEach((e) {
          e.side == 'buy' ? buyList.add(e) : sellList.add(e);
        });
        // isLoading(false);
        return true;
      }
    } catch (error) {
      errorController.handleError(error);
      // isLoading(false);

      return false;
    }
    return false;
  }

  void fetchUserP2pAddedOffers() async {
    try {
      final response = await _p2pRepository.fetchUserP2pAddedOffers();
      if (response.length > 0) {
        response.forEach((e) {
          userAddedP2pOffers.add(e);
        });
        // isLoading(false);
      }
    } catch (error) {
      errorController.handleError(error);
      // isLoading(false);
    }
  }

  Future<bool> addP2pOffer() async {
    //todo: pass the required variables
    Map<String, dynamic> body = {};
    try {
      final response = await _p2pRepository.addP2pOffer(body);
      if (response.id != null) {
        return true;
      }
    } catch (error) {
      errorController.handleError(error);
      // isLoading(false);

      return false;
    }
    return false;
  }
}
