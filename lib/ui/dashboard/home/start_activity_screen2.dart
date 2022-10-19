import 'dart:io';
//Craft Activities

import 'package:bright_kid/helpers/provider/dashboard_provider.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/models/get_activities_overview_model.dart';
import 'package:bright_kid/models/get_activities_overview_model2.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';

class StartActivityScreen2 extends StatefulWidget {
  var data;

  StartActivityScreen2({this.data});

  @override
  _StartActivityScreen2State createState() => _StartActivityScreen2State();
}

class _StartActivityScreen2State extends State<StartActivityScreen2> {
  GetActivitiesOverviewModel2 activityCategorySelected;
  GetActivitiesOverviewActivities2 activitySubCategorySelected;
  List<String> activityCategoryList = [];
  List<GetActivitiesOverviewActivities2> activitySubActivityList = [];
  List<GetActivitiesOverviewActivities2> subActivities = [];

  @override
  void initState() {
    init();
    super.initState();
  }

  init() async {
    await Provider.of<DashboardProvider>(context, listen: false)
        .getCraftActivities(
      '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
      getEnrollmentModel?.getEnrollmenItems?.first?.courseId ?? 0,
    );

    activityCategoryList.clear();
    setState(() {});
    print('before my list length ${activityCategoryList.length}');
    print('before api list length ${getActivitiesOverviewList2.length}');

    getActivitiesOverviewList2.forEach((element) {
      print(element);
      activityCategoryList.add(element.categoryName);

      for (int i = 0; i < element.activities.length; i++) {
        element.activities[i].parent_category_id = element.categoryId;
        subActivities.add(element.activities[i]);
      }
      setState(() {
        print('settings');
      });
    });

    print('after my list length ${activityCategoryList.length}');
    print('after api list length ${getActivitiesOverviewList2.length}');
  }

  //Photos
  File _pickedImage;
  var isPicked = false;

  void _pickImage(ImageSource imageSource) async {
    ImagePicker imagePicker = new ImagePicker();
    final pickedImageFile = await imagePicker.pickImage(
      source: imageSource,
      imageQuality: 75,
    );
    // await _cropImage1(pickedImageFile!.path);
    setState(() {
      _pickedImage = File(pickedImageFile.path);
      isPicked = true;
    });
  }

  Future<dynamic> buildShowModalBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          color: Colors.white,
          height: 200,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Choose an option to send an image',
                style: TextStyle(
                  fontSize: 22,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 20),
              Divider(color: Colors.grey),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: InkWell(
                  onTap: () {
                    _pickImage(ImageSource.camera);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.camera,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Camera',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10),
              Divider(color: Colors.grey),
              Padding(
                padding: const EdgeInsets.only(left: 32.0),
                child: InkWell(
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.pop(context);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.image,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Text(
                        'Gallery',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, dashProvider, child) {
      return ModalProgressHUD(
        inAsyncCall: dashProvider.isLoading,
        progressIndicator: MyLoader(),
        child: Scaffold(
          backgroundColor: scaffold,
          appBar: globalAppBar('Start Activity'),
          bottomNavigationBar: GestureDetector(
            onTap: () {
              // if (activityCategorySelected == null) {
              //   Get.snackbar(
              //       'Activity Category', 'Please select activity category',
              //       backgroundColor: themeColor,
              //       colorText: Colors.white,
              //       progressIndicatorBackgroundColor: Colors.lightBlueAccent,
              //       progressIndicatorValueColor:
              //           AlwaysStoppedAnimation<Color>(Colors.tealAccent),
              //       borderRadius: 6);
              // } else
              if (activitySubCategorySelected == null) {
                Get.snackbar('Sub Category Activity',
                    'Please select sub-category activity',
                    backgroundColor: themeColor,
                    colorText: Colors.white,
                    progressIndicatorBackgroundColor: Colors.lightBlueAccent,
                    progressIndicatorValueColor:
                        AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                    borderRadius: 6);
              } else if (isPicked == false) {
                Get.snackbar('Image', 'Please upload an Image',
                    backgroundColor: themeColor,
                    colorText: Colors.white,
                    progressIndicatorBackgroundColor: Colors.lightBlueAccent,
                    progressIndicatorValueColor:
                        AlwaysStoppedAnimation<Color>(Colors.tealAccent),
                    borderRadius: 6);
              } else {
                setState(() {});
                dashProvider.submitActivity2(
                  getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? '',
                  getEnrollmentModel?.getEnrollmenItems?.first?.courseId ?? 0,
                  activitySubCategorySelected.parent_category_id,
                  activitySubCategorySelected.activityCode,
                  _pickedImage,
                  activitySubCategorySelected.activityName,
                );
              }
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: Get.width * .13,
                vertical: Get.height * .02,
              ),
              child: gradientButton(
                  text: 'Submit', width: Get.width, height: Get.height * .065),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: Get.width,
                  height: Get.height * .23,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Image.asset(
                    startActivityImage,
                    fit: BoxFit.fitWidth,
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                //   child: strokedText(
                //     text: 'Select Activity Category',
                //     fontSize: Get.width * .043,
                //     color: themeColor,
                //     isProgressIndicator: false,
                //   ),
                // ),
                // _dropDown(
                //   hintText: 'Activity Category',
                //   itemsList: getActivitiesOverviewList2,
                // ),
                SizedBox(height: 20),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                  child: strokedText(
                    text: 'Select Activity',
                    fontSize: Get.width * .043,
                    color: themeColor,
                    isProgressIndicator: false,
                  ),
                ),

                Container(
                  margin: EdgeInsets.symmetric(
                    horizontal: Get.width * .05,
                    vertical: Get.height * .01,
                  ),
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1.2, color: white),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff888888).withOpacity(.26),
                        spreadRadius: 1,
                        blurRadius: 4,
                        offset: Offset(4, 4),
                      ),
                    ],
                  ),
                  child: FormField<String>(
                    builder: (FormFieldState<String> state) {
                      return InputDecorator(
                        decoration: InputDecoration(border: InputBorder.none),
                        child: DropdownButtonHideUnderline(
                          child:
                              DropdownButton<GetActivitiesOverviewActivities2>(
                            value: activitySubCategorySelected,
                            icon: Padding(
                              padding: EdgeInsets.only(right: 15),
                              child: Icon(
                                Icons.keyboard_arrow_down,
                                color: limeYellow,
                              ),
                            ),
                            isDense: true,
                            onChanged: (newValue) {
                              setState(() {
                                activitySubCategorySelected = newValue;
                              });
                            },
                            hint: Padding(
                              padding: EdgeInsets.only(left: 28),
                              child: Text(
                                "Select Activities",
                                style: MyTextStyle.mulishBlack()
                                    .copyWith(fontSize: 14, color: themeColor),
                              ),
                            ),
                            items: subActivities
                                .map((GetActivitiesOverviewActivities2 value) {
                              return DropdownMenuItem<
                                  GetActivitiesOverviewActivities2>(
                                value: value,
                                child: Padding(
                                  padding: EdgeInsets.only(left: 28),
                                  child: Text(
                                    value.activityName,
                                    style: MyTextStyle.mulishBlack().copyWith(
                                        fontSize: 14, color: themeColor),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      );
                    },
                  ),
                ),

                //IMAGE INPUT BY YASH
                SizedBox(height: 30),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * .05),
                  child: strokedText(
                    text: 'Upload Image',
                    fontSize: Get.width * .043,
                    color: themeColor,
                    isProgressIndicator: false,
                  ),
                ),
                SizedBox(height: 20),
                Center(
                  child: Container(
                    child: Stack(
                      children: [
                        InkWell(
                          onTap: () {
                            buildShowModalBottomSheet(context);
                          },
                          child: isPicked
                              ? Container(
                                  width: MediaQuery.of(context).size.width * .4,
                                  height:
                                      MediaQuery.of(context).size.width * .4,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: FileImage(_pickedImage)
                                          as ImageProvider,
                                    ),
                                  ),
                                )
                              : Container(
                                  width: MediaQuery.of(context).size.width * .4,
                                  height:
                                      MediaQuery.of(context).size.width * .4,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/Orix-camera-add.png'),
                                      scale: 3.0,
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }

  Widget _dropDown2({
    String hintText,
    List<GetActivitiesOverviewActivities2> itemsList,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Get.width * .05,
        vertical: Get.height * .01,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1.2, color: white),
        boxShadow: [
          BoxShadow(
            color: Color(0xff888888).withOpacity(.26),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(border: InputBorder.none),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<GetActivitiesOverviewActivities2>(
                onTap: () {
                  print(subActivities);
                },
                value: activitySubCategorySelected,
                icon: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: limeYellow,
                  ),
                ),
                isDense: true,
                hint: Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: Text(
                    hintText,
                    style: MyTextStyle.mulishBlack()
                        .copyWith(fontSize: 14, color: themeColor),
                  ),
                ),
                items: itemsList.map((GetActivitiesOverviewActivities2 value) {
                  return DropdownMenuItem<GetActivitiesOverviewActivities2>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.only(left: 28),
                      child: Text(
                        value.activityName,
                        style: MyTextStyle.mulishBlack()
                            .copyWith(fontSize: 14, color: themeColor),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }

  // dropdown field
  Widget _dropDown({
    String hintText,
    List<GetActivitiesOverviewModel2> itemsList,
  }) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Get.width * .05,
        vertical: Get.height * .01,
      ),
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1.2, color: white),
        boxShadow: [
          BoxShadow(
            color: Color(0xff888888).withOpacity(.26),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(4, 4),
          ),
        ],
      ),
      child: FormField<String>(
        builder: (FormFieldState<String> state) {
          return InputDecorator(
            decoration: InputDecoration(border: InputBorder.none),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<GetActivitiesOverviewModel2>(
                value: activityCategorySelected,
                icon: Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: Icon(
                    Icons.keyboard_arrow_down,
                    color: limeYellow,
                  ),
                ),
                isDense: true,
                onChanged: (GetActivitiesOverviewModel2 newValue) {
                  setState(() {
                    // activitySubActivityList.clear();
                    activitySubCategorySelected = null;
                    activityCategorySelected = newValue;
                    if (activityCategorySelected.activities.isNotEmpty) {
                      activitySubActivityList =
                          activityCategorySelected.activities;
                    }
                  });
                },
                hint: Padding(
                  padding: EdgeInsets.only(left: 28),
                  child: Text(
                    hintText ?? '',
                    style: MyTextStyle.mulishBlack()
                        .copyWith(fontSize: 14, color: themeColor),
                  ),
                ),
                items: itemsList.map((GetActivitiesOverviewModel2 value) {
                  return DropdownMenuItem<GetActivitiesOverviewModel2>(
                    value: value,
                    child: Padding(
                      padding: EdgeInsets.only(left: 28),
                      child: Text(
                        value.categoryName ?? '',
                        style: MyTextStyle.mulishBlack()
                            .copyWith(fontSize: 14, color: themeColor),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        },
      ),
    );
  }
}
