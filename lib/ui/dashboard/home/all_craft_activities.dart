import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/localization/app_localization.dart';
import 'package:bright_kid/models/get_activities_overview_model.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:custom_full_image_screen/custom_full_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllCraftActivities extends StatefulWidget {
  AllCraftActivities({this.data});

  List data;

  @override
  _AllCraftActivitiesState createState() => _AllCraftActivitiesState();
}

class _AllCraftActivitiesState extends State<AllCraftActivities> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffold,
      appBar: globalAppBar('My Craft Activities'),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            SizedBox(height: 10),
            widget.data == null || widget.data.isEmpty
                ? Expanded(
                    child: Center(
                      child: Text(
                        'There is no Activity',
                        style: MyTextStyle.mulish().copyWith(
                            fontWeight: FontWeight.bold,
                            color: themeColor,
                            fontSize: Get.width * .035),
                      ),
                    ),
                  )
                : Expanded(
                    child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
                    itemBuilder: (_, index) => Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                      child: subTopicsCard(widget.data[index]),
                    ),
                    itemCount: widget.data.length,
                  )
                    //   child: GridView(
                    //     children: List.generate(widget.data.length, (index) {
                    //       return subTopicsCard(widget.data[index]);
                    //     }),
                    //   ),
                    // )
                    )
          ],
        ),
      ),
    );
  }

  Widget subTopicsCard(var data) {
    return Container(
      // margin: EdgeInsets.symmetric(
      //   horizontal: Get.width * .05,
      //   vertical: Get.height * .01,
      // ),
      // padding: EdgeInsets.symmetric(
      //   vertical: Get.height * .01,
      //   horizontal: Get.width * .04,
      // ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Color(0xff000000).withOpacity(.16),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          data['completion_image'] == null || data['completion_image'] == ''
              ? Container(
                  width: 0,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8),
                  ),
                )
              // : Container(
              //     width: 100,
              //     height: 100,
              //     decoration: BoxDecoration(
              //       color: Colors.grey,
              //       borderRadius: BorderRadius.circular(8),
              //       image: DecorationImage(
              //         fit: BoxFit.cover,
              //         image: NetworkImage(data['completion_image']),
              //       ),
              //     ),
              //   ),
              : ImageCachedFullscreen(
                  imageUrl: data['completion_image'],
                  imageBorderRadius: 20,
                  imageWidth: 100,
                  imageHeight: 100,
                  placeholder: Container(
                    child: Icon(Icons.check),
                  ),
                  errorWidget: Container(
                    child: Icon(
                      Icons.error,
                      size: 68,
                      color: Colors.red,
                    ),
                  ),
                  iconBackButtonColor: Colors.red,
                  imageDetailsHeight: 500,
                  imageDetailsWidth: MediaQuery.of(context).size.width,
                  hideBackButtonDetails: true,
                  appBarBackgroundColorDetails: Colors.red,
                  backgroundColorDetails: Colors.transparent,
                  imageDetailsFit: BoxFit.cover,
                  hideAppBarDetails: true,
                  imageFit: BoxFit.fill,
                  withHeroAnimation: true,
                  placeholderDetails:
                      Center(child: CircularProgressIndicator()),
                ),
          Container(
            width: Get.width * .38,
            child: Center(
              child: Text(
                data['activity_name'] ?? '',
                textAlign: TextAlign.center,
                style: MyTextStyle.mulish().copyWith(
                    fontWeight: FontWeight.bold,
                    color: themeColor,
                    fontSize: Get.width * .04),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
