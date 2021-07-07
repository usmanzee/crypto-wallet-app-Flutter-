import 'package:b4u_wallet/controllers/p2p_controller.dart';
import 'package:b4u_wallet/views/p2p_buy_sell_page/components/drawer_widget.dart';
import 'package:b4u_wallet/views/p2p_buy_sell_page/container_trade_widget.dart';
import 'package:b4u_wallet/views/p2p_buy_sell_page/p2p_history_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class P2pBuySellPage extends StatelessWidget {
  final List<String> _tabs = <String>[
    'USDT',
    'BTC',
    'BUSD',
    'BNB',
    'ETH',
    'UAH',
    'DAI',
  ];
  final p2pController = Get.find<P2pController>();

  TabBar get _tabBar => TabBar(
        indicatorColor: Get.theme.primaryColor,
        labelColor: Get.theme.primaryColor,
        unselectedLabelColor: Get.theme.textSelectionTheme.selectionColor,
        indicatorSize: TabBarIndicatorSize.label,
        tabs: _tabs
            .map((String name) => Tab(
                  text: name,
                ))
            .toList(),
        isScrollable: true,
      );

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        endDrawer: drawerWidget(),
        body: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return [
              SliverOverlapAbsorber(
                handle:
                    NestedScrollView.sliverOverlapAbsorberHandleFor(context),
                sliver: SliverAppBar(
                  brightness:
                      Get.isDarkMode ? Brightness.dark : Brightness.light,
                  actions: [
                    Container(),
                  ],
                  titleSpacing: 0,
                  toolbarHeight: 80,
                  automaticallyImplyLeading: false,
                  title: Obx(() {
                    return Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => Get.back(),
                                      child: Icon(
                                        Icons.arrow_back_ios,
                                        size: 20,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    Text(
                                      'P2P  ',
                                      style: TextStyle(
                                        fontFamily: "Popins",
                                        color:
                                            Get.theme.scaffoldBackgroundColor,
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: 20,
                                      color: Get.theme.scaffoldBackgroundColor,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Align(
                                      child: Text(
                                        'UAH',
                                        style: TextStyle(
                                          fontFamily: "Popins",
                                          color:
                                              Get.theme.scaffoldBackgroundColor,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      alignment: Alignment.center,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 5, right: 10),
                                      child: Icon(
                                        Icons.swap_horiz,
                                        size: 20,
                                        color:
                                            Get.theme.scaffoldBackgroundColor,
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: Icon(
                                        Icons.keyboard_control,
                                        size: 25,
                                        color:
                                            Get.theme.scaffoldBackgroundColor,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8.0,
                              vertical: 4.0,
                            ),
                            decoration: BoxDecoration(
                              color: Get.theme.scaffoldBackgroundColor,
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: p2pController.buyOrSell.value
                                          ? null
                                          : () {
                                              p2pController.buyOrSell.value =
                                                  !p2pController
                                                      .buyOrSell.value;
                                            },
                                      child: Text(
                                        'Buy',
                                        style: TextStyle(
                                          fontFamily: "Popins",
                                          color: p2pController.buyOrSell.value
                                              ? Get.theme.textSelectionTheme
                                                  .selectionColor
                                              : Get.theme.textSelectionTheme
                                                  .selectionColor
                                                  .withOpacity(0.5),
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    GestureDetector(
                                      onTap: p2pController.buyOrSell.value
                                          ? () {
                                              p2pController.buyOrSell.value =
                                                  !p2pController
                                                      .buyOrSell.value;
                                            }
                                          : null,
                                      child: Text(
                                        'Sell',
                                        style: TextStyle(
                                          fontFamily: "Popins",
                                          color: p2pController.buyOrSell.value
                                              ? Get.theme.textSelectionTheme
                                                  .selectionColor
                                                  .withOpacity(0.5)
                                              : Get.theme.textSelectionTheme
                                                  .selectionColor,
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: (){
                                        Get.to<void>(() => P2pHistoryPage());
                                      },
                                      child: Icon(
                                        Icons.insert_drive_file_outlined,
                                        size: 25,
                                        color: Get.theme.textSelectionTheme
                                            .selectionColor
                                            .withOpacity(0.7),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 8.0,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Scaffold.of(context).openEndDrawer();
                                      },
                                      child: Icon(
                                        Icons.filter_alt_outlined,
                                        color: Get.theme.textSelectionTheme
                                            .selectionColor
                                            .withOpacity(0.7),
                                        size: 25,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  pinned: true,
                  floating: true,
                  forceElevated: innerBoxIsScrolled,
                  bottom: PreferredSize(
                    preferredSize: _tabBar.preferredSize,
                    child: ColoredBox(
                      color: Get.theme.scaffoldBackgroundColor,
                      child: _tabBar,
                    ),
                  ),
                ),
              ),
            ];
          },
          body: TabBarView(
            // These are the contents of the tab views, below the tabs.
            children: _tabs.map((String name) {
              return SafeArea(
                top: false,
                bottom: false,
                child: Builder(
                  builder: (BuildContext context) {
                    return CustomScrollView(
                      key: PageStorageKey<String>(name),
                      slivers: [
                        SliverOverlapInjector(
                          handle:
                              NestedScrollView.sliverOverlapAbsorberHandleFor(
                                  context),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(8.0),
                          sliver: SliverFixedExtentList(
                            itemExtent: 210,
                            delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                                return containerTrade(
                                  name: 'John Doe',
                                  price: 27.38,
                                  currency: 'uah',
                                  bankName: 'MonoBank',
                                  cryptoAmount: '815.98',
                                  functionCallback: () =>
                                      print('function Callback'),
                                  functionText: 'Buy',
                                  lowerLimit: '500.00',
                                  upperLimit: '22,635.39',
                                  nameCallback: () =>
                                      print('from name callback'),
                                  reviewPercentage: '98.09',
                                  tabCurrencyName: 'usdt',
                                  trades: '216',
                                  currencySymbol: '\$',
                                );
                              },
                              childCount: 30,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
