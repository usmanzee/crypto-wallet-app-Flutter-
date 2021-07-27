import 'package:b4u_wallet/views/widgets/icon_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:b4u_wallet/models/wallet.dart' as WalletClass;

class SearchHeader extends StatelessWidget {
  final String screenType;
  final WalletClass.Wallet wallet;
  SearchHeader({this.screenType, this.wallet});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.offNamed('/wallets-search', arguments: {'searchFrom': screenType});
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          color: Theme.of(context).canvasColor,
          padding: EdgeInsets.all(12),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 4.0),
                    child:  IconWidget(name: wallet.name,url: wallet.iconUrl),
                  ),
                  Text(
                    wallet.currency.toUpperCase(),
                    style: TextStyle(
                      fontFamily: "Popins",
                      fontWeight: FontWeight.w800,
                      fontSize: 20.0,
                      letterSpacing: 1.5,
                    ),
                  )
                ],
              ),
              Icon(
                Icons.keyboard_arrow_right,
                size: 20.0,
              ),
            ],
          ),
        )
      ]),
    );
  }
}
