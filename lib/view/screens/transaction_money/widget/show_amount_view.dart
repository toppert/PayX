import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payx/helper/price_converter.dart';
import 'package:payx/util/color_resources.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/util/images.dart';
import 'package:payx/util/styles.dart';

class ShowAmountView extends StatelessWidget {
  const ShowAmountView({ Key key, @required this.amountText, @required this.onTap }) : super(key: key);
  final String amountText;
  final Function onTap;



  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_DEFAULT),
            child: Text('amount_in_bdt'.tr, style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE, color: ColorResources.getGreyBaseGray1())),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('${PriceConverter.balanceWithSymbol(balance: amountText)}', style: rubikMedium.copyWith(fontSize: Dimensions.FONT_SIZE_LARGE)),
              InkWell(
                onTap: onTap ,
                child: Image.asset(Images.edit_icon, height: Dimensions.RADIUS_SIZE_EXTRA_LARGE,width: Dimensions.RADIUS_SIZE_EXTRA_LARGE)
                )
            ]
          )
        ],
      ),
    );
  }
}