
import 'package:payx/controller/profile_screen_controller.dart';
import 'package:payx/controller/splash_controller.dart';
import 'package:payx/util/color_resources.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/util/images.dart';
import 'package:payx/util/styles.dart';
import 'package:payx/view/screens/profile/widget/bootom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class UserInfo extends StatelessWidget {
  final ProfileController profileController;
  const UserInfo({Key key,@required this.profileController,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).cardColor,
      padding: EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_LARGE, vertical: Dimensions.PADDING_SIZE_LARGE),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          profileController.userInfo != null?
          Row(
            children: [
              Container(
                width: Dimensions.SIZE_PROFILE_AVATAR,
                height: Dimensions.SIZE_PROFILE_AVATAR,
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_PROFILE_AVATAR)), border: Border.all(width: 1, color: Theme.of(context).highlightColor)),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(Dimensions.RADIUS_PROFILE_AVATAR)),
                  child: FadeInImage.assetNetwork(
                    fit: BoxFit.cover,
                    image: "${Get.find<SplashController>().configModel.baseUrls.customerImageUrl}/${profileController.userInfo.image}",
                    placeholder: Images.avatar,
                    imageErrorBuilder: (context, url, error) => Image.asset(Images.avatar, fit: BoxFit.cover,),
                  ),
                ),
              ),
              SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
              Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(width: MediaQuery.of(context).size.width * 0.5,
                    child: Text('${profileController.userInfo.fName} ${profileController.userInfo.lName}',
                        style: rubikMedium.copyWith(color: ColorResources.getBlackColor(), fontSize: Dimensions.FONT_SIZE_LARGE),
                        textAlign: TextAlign.start, maxLines: 1, overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(width: MediaQuery.of(context).size.width * 0.5,
                    child: Text('${profileController.userInfo.phone}',
                      style: rubikMedium.copyWith(color: ColorResources.getGreyBaseGray1(), fontSize: Dimensions.FONT_SIZE_LARGE),
                      textAlign: TextAlign.start, maxLines: 1, overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ],
          ):SizedBox(),
          InkWell(
            onTap: () => showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                isDismissible: false,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(Dimensions.RADIUS_SIZE_LARGE))),
                builder: (context) =>  ProfileQRCodeBottomSheet()),
            child: GetBuilder<ProfileController>(builder: (controller) {
              return Container(
                decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).secondaryHeaderColor),
                padding: EdgeInsets.all(10.0),
                child: SvgPicture.string(controller.userInfo.qrCode, height: 24, width: 24,),
              );
            }),
          )
        ],
      ),
    );
  }
}
