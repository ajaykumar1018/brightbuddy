import 'package:bright_kid/helpers/provider/dashboard_provider.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/localization/app_localization.dart';
import 'package:bright_kid/models/get_chapters_model.dart';
import 'package:bright_kid/models/get_courses_model.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class OverViewScreen extends StatefulWidget {
  int courseId;
  OverViewScreen({this.courseId});

  @override
  _OverViewScreenState createState() => _OverViewScreenState();
}

class _OverViewScreenState extends State<OverViewScreen> {
  int _currentTopicOpened;

  @override
  void initState() {
    Provider.of<DashboardProvider>(context, listen: false)
        .getCoursesFunc(widget.courseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, provider, _) {
      return ModalProgressHUD(
        inAsyncCall: provider.isLoading,
        progressIndicator: MyLoader(),
        child: Scaffold(
          backgroundColor: scaffold,
          appBar: globalAppBar('See Overview'),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * .2,
                  margin: EdgeInsets.symmetric(horizontal: Get.width * .05),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(overViewImage),
                      fit: BoxFit.fitWidth,
                    ),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Color(0xff000000).withOpacity(.25),
                    //     spreadRadius: 1,
                    //     blurRadius: 4,
                    //   ),
                    // ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: Get.height * .04,
                      left: Get.width * .04,
                    ),
                    child: Text(
                      'Course \nCurriculum',
                      textAlign: TextAlign.start,
                      style: MyTextStyle.mulish().copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontSize: Get.width * .045),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.only(left: Get.width * .05),
                  child: strokedText(
                      text: getTranslated(context, "topics"),
                      fontSize: Get.width * .04,
                      color: themeColor,
                      isProgressIndicator: false),
                ),
                SizedBox(height: 10),
                getCoursesModel == null ||
                        getCoursesModel.getCoursesItems == null ||
                        getCoursesModel.getCoursesItems.isEmpty
                    ? SizedBox()
                    : Expanded(
                        child: ListView(
                          children: List.generate(
                            getCoursesModel.getCoursesItems.length,
                            (index) {
                              return topicsCard(
                                getCoursesModel.getCoursesItems[index],
                                index,
                                provider,
                              );
                            },
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget topicsCard(
      GetCoursesItems model, int index, DashboardProvider provider) {
    return Column(
      children: [
        Container(
          width: Get.width,
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
          margin: EdgeInsets.only(
            bottom: 15,
            left: Get.width * .05,
            right: Get.width * .05,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: Get.height * .02, horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    model.name,
                    style: MyTextStyle.mulish().copyWith(
                        fontWeight: FontWeight.bold,
                        color: themeColor,
                        fontSize: Get.width * .035),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      setState(() {
                        _currentTopicOpened == index
                            ? _currentTopicOpened = null
                            : _currentTopicOpened = index;
                      });
                      if (_currentTopicOpened == index) {
                        provider.getChaptersFunc(model.id);
                      }
                    },
                    child: Image.asset(
                      _currentTopicOpened == index ? minusIcon : plusIcon,
                      scale: 4,
                    )),
              ],
            ),
          ),
        ),
        _currentTopicOpened == index
            ? Column(
                children: List.generate(
                    getChaptersModel?.getChaptersItems?.length ?? 0, (index) {
                return subTopicCard(getChaptersModel?.getChaptersItems[index]);
              }))
            : SizedBox(),
      ],
    );
  }
}

Widget subTopicCard(GetChaptersItems model) {
  return Container(
    width: Get.width,
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
    margin: EdgeInsets.only(
      bottom: 15,
      left: Get.width * .1,
      right: Get.width * .1,
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * .02, horizontal: 10),
      child: Row(
        children: [
          // Image.asset(
          //   model.contentableType == 'Quiz' ? quiz : video,
          //   scale: 3,
          // ),
          SizedBox(width: 10),
          Text(
            model?.name ?? '',
            style: MyTextStyle.mulish().copyWith(
                fontWeight: FontWeight.bold,
                color: themeColor,
                fontSize: Get.width * .035),
          ),
        ],
      ),
    ),
  );
}
