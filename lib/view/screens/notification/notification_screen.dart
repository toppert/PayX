
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:payx/controller/notification_controller.dart';
import 'package:payx/controller/splash_controller.dart';
import 'package:payx/util/color_resources.dart';
import 'package:payx/util/dimensions.dart';
import 'package:payx/util/images.dart';
import 'package:payx/util/styles.dart';
import 'package:payx/view/base/appbar_home_element.dart';
import 'package:payx/view/base/custom_ink_well.dart';
import 'package:payx/view/base/no_data_screen.dart';
import 'package:payx/view/screens/notification/widget/notification_dialog.dart';
import 'package:payx/view/screens/notification/widget/notification_shimmer.dart';
class NotificationScreen extends StatefulWidget {
  const NotificationScreen({ Key key }) : super(key: key);

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}


class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppbarHomeElement(title: 'notification'.tr),
      body: RefreshIndicator(
        onRefresh: () async{
          await Get.find<NotificationController>().getNotificationList();
        },
        child: GetBuilder<NotificationController>(
          builder: (notification) {
            return notification.notificationList == null ? NotificationShimmer() :  notification.notificationList.length > 0 ?  ListView.builder(
              itemCount: notification.notificationList.length,
              padding: EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL),
              itemBuilder: (context, index) {
                return Container(
                  color: Theme.of(context).cardColor,
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: CustomInkWell(
                    onTap: (){
                      showDialog(context: context, builder: (context) => NotificationDialog(notificationModel: notification.notificationList[index]));
                    },
                    highlightColor: ColorResources.getPrimaryColor().withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: Dimensions.PADDING_SIZE_SMALL,horizontal:  Dimensions.PADDING_SIZE_EXTRA_LARGE),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(notification.notificationList[index].title, style: rubikSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.getTextColor())),
                              SizedBox(height: Dimensions.PADDING_SIZE_SMALL,),
                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: Text(notification.notificationList[index].description, maxLines: 2, overflow: TextOverflow.ellipsis, style: rubikRegular.copyWith(fontSize: Dimensions.FONT_SIZE_DEFAULT, color: ColorResources.getTextColor())),
                              ),

                            ],
                          ),

                          const Spacer(),
                          SizedBox(
                            height: Dimensions.NOTIFICATION_IMAGE_SIZE,
                            width: Dimensions.NOTIFICATION_IMAGE_SIZE,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(Dimensions.RADIUS_SIZE_EXTRA_SMALL),
                              child: FadeInImage.assetNetwork(
                                placeholder: Images.placeholder, height: 50, width: 50, fit: BoxFit.cover,
                                image: '${Get.find<SplashController>().configModel.baseUrls.notificationImageUrl}/${notification.notificationList[index].image}',
                                imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder, height: 50, width: 50, fit: BoxFit.cover),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );

              },
            ) : NoDataFoundScreen();
          },
        ),
      ),
    );
  }
}
