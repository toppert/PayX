import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payx/controller/splash_controller.dart';
import 'package:payx/controller/websitelink_controller.dart';
import 'package:payx/helper/custom_launch_url.dart';
import 'package:payx/util/color_resources.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/util/images.dart';
import 'package:payx/util/styles.dart';
import 'package:payx/view/base/CustomImage.dart';
import 'package:payx/view/base/custom_ink_well.dart';

class LinkedWebsite extends StatelessWidget {
  final WebsiteLinkController websiteLinkController;
  LinkedWebsite({@required this.websiteLinkController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.PADDING_SIZE_LARGE),
          child: Text(
            'linked_website'.tr,
            style: rubikRegular.copyWith(
              fontSize: Dimensions.FONT_SIZE_LARGE,
              color: ColorResources.getPrimaryTextColor(),
            ),
          ),
        ),
        Container(
          height: 86,
          width: double.infinity,
          margin: const EdgeInsets.only(top: Dimensions.PADDING_SIZE_SMALL),
          decoration:
              BoxDecoration(color: Theme.of(context).cardColor, boxShadow: [
            BoxShadow(
              color: ColorResources.containerShadow.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, 3),
            )
          ]),
          child: ListView.builder(
            itemCount: websiteLinkController.websiteList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding:
                    const EdgeInsets.only(right: Dimensions.PADDING_SIZE_SMALL),
                child: CustomInkWell(
                  onTap: () => CustomLaunchUrl.launchURL(
                      url: websiteLinkController.websiteList[index].url),
                  radius: Dimensions.RADIUS_SIZE_EXTRA_SMALL,
                  highlightColor:
                      ColorResources.getPrimaryColor().withOpacity(0.1),
                  child: Container(
                    width: 100,
                    padding: const EdgeInsets.symmetric(
                        vertical: Dimensions.PADDING_SIZE_DEFAULT),
                    child: Column(
                      children: [
                        CustomImage(
                            image:
                                "${Get.find<SplashController>().configModel.baseUrls.linkedWebsiteImageUrl}/${websiteLinkController.websiteList[index].image}",
                            placeholder: Images.placeholder,
                            fit: BoxFit.fitWidth,
                            width: 50,
                            height: 30),
                        const Spacer(),
                        Text(
                          websiteLinkController.websiteList[index].name,
                          textAlign: TextAlign.center,
                          style: rubikRegular.copyWith(
                            fontSize: Dimensions.FONT_SIZE_DEFAULT,
                            color: ColorResources.getWebsiteTextColor(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(
          height: Dimensions.PADDING_SIZE_SMALL,
        ),
      ],
    );
  }
}
