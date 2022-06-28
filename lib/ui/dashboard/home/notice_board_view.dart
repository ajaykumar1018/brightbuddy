import 'package:bright_kid/helpers/provider/dashboard_provider.dart';
import 'package:bright_kid/helpers/services/api_request.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/helpers/widgets/logout_bottomsheet.dart';
import 'package:bright_kid/models/notice_model.dart';
import 'package:bright_kid/models/post_model.dart';
import 'package:bright_kid/ui/dashboard/home/notice_board_item.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/common.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:bright_kid/utils/loader_class.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class NoticeBoardView extends StatefulWidget {
  const NoticeBoardView({Key key}) : super(key: key);

  @override
  State<NoticeBoardView> createState() => _NoticeBoardViewState();
}

class _NoticeBoardViewState extends State<NoticeBoardView> {
  List<Post> posts;
  List<Notice> notices;
  var isLoaded = false;
  @override
  void initState() {
    Provider.of<DashboardProvider>(context, listen: false).weeklyCalendarFunc(
      '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
      getEnrollmentModel?.getEnrollmenItems?.first?.courseId ?? 0,
    );

    Provider.of<DashboardProvider>(context, listen: false).weeklyCalendarFunc2(
      '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
      getEnrollmentModel?.getEnrollmenItems?.first?.courseId ?? 0,
    );

    getData();
    getNotices();
    super.initState();
  }

  getData() async {
    posts = await ApiRequest().getPost();
    if (posts != null) {
      setState(() {
        isLoaded = true;
      });
    } else {
      posts = [];
    }
  }

  getNotices() async {
    notices = await ApiRequest().getNotices(
        loginData?.loginUser?.schoolCode,
        loginData?.loginUser?.email,
        loginData?.loginUser?.role,
        loginData?.loginUser?.level);
    if (notices != null) {
      setState(() {
        isLoaded = true;
      });
    } else {
      notices = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DashboardProvider>(builder: (context, dashProvider, child) {
      return ModalProgressHUD(
        inAsyncCall: dashProvider.isLoading,
        progressIndicator: MyLoader(),
        child: Scaffold(
          backgroundColor: scaffold,
          appBar: globalAppBar('Notice Board'),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .05,
                  vertical: Get.height * 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: [
                        Image.asset(
                          noticeBoardIcon,
                          scale: 0.8,
                        ),
                        Text(
                          'Notice Board',
                          style: MyTextStyle.mulishBlack().copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: Get.width * .05,
                            color: themeColor,

                            //decoration: TextDecoration.underline,
                          ),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(LogoutBottomSheet());
                      },
                      child: Container(
                        width: 43,
                        height: 43,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: (loginData?.loginUser?.profilePic == '')
                                ? AssetImage(dp)
                                : NetworkImage(
                                    loginData.loginUser.profilePic,
                                  ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Expanded(
                  child: Visibility(
                visible: isLoaded,
                child: ListView.builder(
                  itemCount: notices?.length,
                  itemBuilder: (context, index) {
                    return NoticeBoardItem(
                      title: notices[index].title,
                      body: notices[index].body,
                      id: notices[index].id,
                      dateTime: notices[index].createdAt,
                      imageUrl: notices[index].attachment,
                      acknowledgment: notices[index].acknowledgment,
                    );
                  },
                ),
                replacement: Center(
                  child: CircularProgressIndicator(
                    color: themeColor,
                  ),
                ),
              )),
            ],
          ),
        ),
      );
    });
    ;
  }
}
