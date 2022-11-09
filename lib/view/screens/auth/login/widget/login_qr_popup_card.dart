import 'package:payx/controller/auth_controller.dart';
import 'package:payx/util/color_resources.dart';
import 'package:payx/view/screens/home/widget/animated_card/custom_rect_tween.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class LoginQrPopupCard extends StatelessWidget {
  const LoginQrPopupCard({Key key}) : super(key: key);
  final String _heroQrTag = 'hero-qr-tag';


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Hero(
          tag: _heroQrTag,
          createRectTween: (begin, end) {
            return CustomRectTween(begin: begin, end: end);
          },
          child: Material(
            color: ColorResources.whiteColor,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: GetBuilder<AuthController>(builder: (controller){
                  return SizedBox(
                    height: MediaQuery.of(context).size.height*0.4,
                    width: MediaQuery.of(context).size.width*0.8,
                    child: SvgPicture.string(controller.getCustomerQrCode(),fit: BoxFit.contain,),
                  );
                },)
            ),
          ),
        ),
      ),
    );
  }
}
