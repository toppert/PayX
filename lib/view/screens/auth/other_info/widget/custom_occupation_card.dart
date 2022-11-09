import 'package:payx/util/color_resources.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/util/styles.dart';
import 'package:flutter/material.dart';

class CustomOccupationrCard extends StatelessWidget {
  final String icon, text;
  final bool check;
  CustomOccupationrCard({this.icon, this.text, this.check});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(
            right: Dimensions.PADDING_SIZE_DEFAULT,
            top: Dimensions.PADDING_SIZE_DEFAULT,
            bottom: Dimensions.PADDING_SIZE_LARGE,
          ),
          height: 75,
          width: 84,
          decoration: BoxDecoration(
            color: ColorResources.getOccupationCardColor(),
            borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_SMALL),
            boxShadow: [
              BoxShadow(
                color: ColorResources.getShadowColor().withOpacity(0.1),
                blurRadius: 20,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 26.81,
                width: 26.81,
                child: Image.asset(icon),
              ),
              const SizedBox(
                height: Dimensions.PADDING_SIZE_EXTRA_SMALL,
              ),
              Text(
                text,
                textAlign: TextAlign.center,
                style: rubikRegular.copyWith(
                  color: ColorResources.getBlackColor(),
                  fontSize: Dimensions.FONT_SIZE_DEFAULT,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: 20,
          right: 20,
          child: Visibility(
            visible: check,
            child: Container(
              height: 16,width: 16,
              decoration: BoxDecoration(
                color: ColorResources.getPrimaryColor(),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.check,color: Colors.white,size: 12,),
            ),
          ),
        ),
      ],
    );
  }
}
