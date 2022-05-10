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

class OverViewScreen2 extends StatefulWidget {
  int courseId;
  var data;

  OverViewScreen2({this.courseId, this.data});

  @override
  _OverViewScreen2State createState() => _OverViewScreen2State();
}

class _OverViewScreen2State extends State<OverViewScreen2> {
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
                widget.data == null
                    ? SizedBox()
                    : Expanded(
                        child: ListView(
                          children: List.generate(
                            widget.data.length,
                            (index) {
                              return widget.data == null
                                  ? SizedBox()
                                  : topicsCard(
                                      // getCoursesModel.getCoursesItems[0],
                                      index,
                                      provider,
                                      widget.data,
                                      widget.data[index]['chapter_name']);
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
      int index, DashboardProvider provider, var data, String name) {
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
                    name,
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
                        provider.getChaptersFunc(data[index]["chapter_id"]);
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
                children: List.generate(data[index]['contents'].length ?? 0,
                    (indexM) {
                return data == null
                    ? SizedBox()
                    : subTopicCard(getChaptersModel?.getChaptersItems[0],
                        data[index]['contents'][indexM]['content_name']);
              }))
            : SizedBox(),
      ],
    );
  }
}

Widget subTopicCard(GetChaptersItems model, String name) {
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
            name ?? '',
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
