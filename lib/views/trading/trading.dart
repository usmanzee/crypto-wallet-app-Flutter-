import 'package:crypto_template/controllers/HomeController.dart';
import 'package:crypto_template/controllers/trading_controller.dart';
import 'package:crypto_template/models/formated_market.dart';
import 'package:crypto_template/views/DetailCryptoValue/order_book.dart';
import 'package:crypto_template/views/market/market_drawer.dart';
import 'package:crypto_template/views/trading/limit_order_form.dart';
import 'package:crypto_template/views/trading/market_order_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:crypto_template/views/DetailCryptoValue/openOrders.dart';

// class Trading extends StatefulWidget {
//   final FormatedMarket formatedMarket;

//   Trading({this.formatedMarket});
//   @override
//   _TradingState createState() => _TradingState(formatedMarket);
// }

class Trading extends StatelessWidget {
  final TradingController tradingController = Get.put(TradingController());
  final HomeController homeController = Get.find();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    print(tradingController.market.value);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        // leading: new Container(),
        backgroundColor: Theme.of(context).canvasColor,
        title: GestureDetector(
          onTap: () {
            if (_scaffoldKey.currentState.isDrawerOpen) {
              _scaffoldKey.currentState.openEndDrawer();
            } else {
              _scaffoldKey.currentState.openDrawer();
            }
          },
          child: Row(children: [
            Text(
              'BTC/USD',
              style: TextStyle(
                  color: Theme.of(context).textSelectionColor,
                  fontFamily: "Gotik",
                  fontWeight: FontWeight.w600,
                  fontSize: 18.5),
            ),
            Icon(Icons.keyboard_arrow_right),
          ]),
        ),
        iconTheme: IconThemeData(color: Theme.of(context).textSelectionColor),
        elevation: 1,
      ),
      drawer: Drawer(
        child: MarketDrawer(),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: EdgeInsets.fromLTRB(8, 8, 8, 8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            OrderBook(),
            DefaultTabController(
              length: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    child: TabBar(
                      indicator: UnderlineTabIndicator(
                          borderSide: BorderSide(
                            width: 2,
                            color: Theme.of(context).primaryColor,
                          ),
                          insets:
                              EdgeInsets.only(left: -8, right: 8, bottom: 8)),
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(left: 0, right: 16),
                      // indicatorColor:
                      //     Theme.of(context).primaryColor,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor:
                          Theme.of(context).textSelectionColor,
                      indicatorSize: TabBarIndicatorSize.label,
                      tabs: [
                        new Tab(
                          child: Text(
                            "Limit",
                            style: TextStyle(fontFamily: "Sans", fontSize: 14),
                          ),
                        ),
                        new Tab(
                          child: Text(
                            "Market",
                            style: TextStyle(fontFamily: "Sans", fontSize: 14),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                    height: 250,
                    child: TabBarView(children: [
                      LimitOrderForm(),
                      MarketOrderForm(),
                    ]),
                  ),
                ],
              ),
            ),
            // Padding(
            //   padding: EdgeInsets.fromLTRB(0, 0, 0, 8),
            //   child: Text(
            //     'Open Orders',
            //     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //   ),
            // ),
            // OpenOrders(formatedMarket: tradingController.market.value),
          ],
        ),
      )),
    );
  }
}
