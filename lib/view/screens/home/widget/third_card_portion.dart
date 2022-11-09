
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payx/util/color_resources.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/util/images.dart';
import 'package:payx/view/screens/home/widget/banner_view.dart';
import 'package:payx/view/screens/home/widget/custom_card3.dart';
import 'package:payx/view/screens/transaction_money/transaction_money_screen.dart';
import 'package:payx/view/screens/transaction_money/widget/transaction_money_balance_input.dart';

class ThirdCardPortion extends StatelessWidget {
  const ThirdCardPortion({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Stack(
        children: [
          Container(height: Dimensions.MAIN_BACKGROUND_CARD_WEIGHT, color: ColorResources.getPrimaryColor(),),
          Positioned(
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_LARGE,bottom: Dimensions.PADDING_SIZE_DEFAULT),
                  child: Row(
                    children: [
                     Expanded(child: CustomCard3(image: Images.sendMoneyLogo3, text: 'send_money'.tr, height: 38, width: 38,
                            onTap: () {
                              Get.to(()=> TransactionMoneyScreen(fromEdit: false,transactionType: 'send_money'));
                            },
                          ),
                        ),

                        Expanded(child: CustomCard3(image: Images.cashOutLogo3, text: 'cash_out'.tr, height: 37, width: 37,
                            onTap: () {
                              Get.to(()=> TransactionMoneyScreen(fromEdit: false,transactionType: 'cash_out'));
                            },
                          ),
                        ),

                         Expanded(child: CustomCard3(image: Images.addMoneyLogo3, text: 'Add Money'.tr, height: 35, width: 30,
                           onTap: () => Get.to(TransactionMoneyBalanceInput(transactionType: 'add_money')),
                          ),
                        ),

                      Expanded(child: CustomCard3(image: Images.requestMoney_logo, text: 'request_money'.tr, height: 32, width: 48,
                        onTap: () {
                          Get.to(()=> TransactionMoneyScreen(fromEdit: false,transactionType: 'request_money'));
                        },
                      ),
                      ),
                    ],
                  ),
                ),
                /// Banner..
                BannerView(),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
