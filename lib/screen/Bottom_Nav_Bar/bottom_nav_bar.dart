import 'package:crypto_template/screen/Bottom_Nav_Bar/custom_nav_bar.dart';
import 'package:crypto_template/screen/home/home.dart';
import 'package:crypto_template/screen/intro/login.dart';
import 'package:crypto_template/screen/intro/signup.dart';
import 'package:crypto_template/screen/market/markets.dart';
import 'package:crypto_template/screen/news/news_home.dart';
import 'package:crypto_template/screen/setting/setting.dart';
import 'package:crypto_template/screen/setting/themes.dart';
import 'package:crypto_template/screen/wallet/wallet.dart';
import 'package:flutter/material.dart';
import 'package:crypto_template/component/style.dart';
import 'package:crypto_template/component/shared_pref.dart';
import 'package:crypto_template/models/user.dart';
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';

class BottomNavBar extends StatefulWidget {
  ///
  /// Function themeBloc for get data theme from main.dart for double theme dark and white theme
  ///
  final ThemeBloc themeBloc;
  BottomNavBar({this.themeBloc});

  _BottomNavBarState createState() => _BottomNavBarState(themeBloc);
}

class _BottomNavBarState extends State<BottomNavBar> {
  final ThemeBloc _themeBloc;
  _BottomNavBarState(this._themeBloc);
  int currentIndex = 0;
  bool _color = true;
  bool isLoggedIn = false;
  Widget callPage(int current) {
    print('currenctIndex: $currentIndex');
    // SharedPref sharedPref = new SharedPref();
    // var isLoggedIn = sharedPref.readBool('isLoggedIn');
    // print(isLoggedIn);
    switch (current) {
      case 0:
        return new home();
        break;
      case 1:
        return new market();
        break;
      case 2:
        return new wallet();
        break;
      case 3:
        return new news();
        break;
      case 4:
        return new setting(themeBloc: _themeBloc);
        break;
      default:
        return new wallet();
    }
  }

  Future isUserLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool loggedIn = (prefs.getBool('isLoggedIn') ?? false);
    setState(() {
      isLoggedIn = loggedIn;
    });
  }

  @override
  void initState() {
    super.initState();
    isUserLoggedIn();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: callPage(currentIndex),
      bottomNavigationBar: BottomNavigationDotBar(
          // Usar -> "BottomNavigationDotBar"
          color: Theme.of(context).hintColor,
          items: <BottomNavigationDotBarItem>[
            BottomNavigationDotBarItem(
                icon: Icons.home,
                onTap: () {
                  setState(() {
                    currentIndex = 0;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: Icons.account_balance,
                onTap: () {
                  setState(() {
                    currentIndex = 1;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: Icons.account_balance_wallet,
                onTap: () {
                  if (!isLoggedIn) {
                    Navigator.of(context).push(PageRouteBuilder(
                        pageBuilder: (_, __, ___) => new Login(
                              themeBloc: _themeBloc,
                            )));
                  } else {
                    setState(() {
                      currentIndex = 2;
                    });
                  }
                }),
            BottomNavigationDotBarItem(
                icon: Icons.library_books,
                onTap: () {
                  setState(() {
                    currentIndex = 3;
                  });
                }),
            BottomNavigationDotBarItem(
                icon: Icons.settings,
                onTap: () {
                  setState(() {
                    currentIndex = 4;
                  });
                }),
          ]),
    );
  }
}
