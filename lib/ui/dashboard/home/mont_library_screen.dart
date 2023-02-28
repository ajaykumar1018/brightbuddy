import 'package:bright_kid/helpers/provider/dashboard_provider.dart';
import 'package:bright_kid/helpers/services/api_request.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/helpers/widgets/logout_bottomsheet.dart';
import 'package:bright_kid/models/mont_lib_model.dart';
// import 'package:bright_kid/models/post_model.dart';
import 'package:bright_kid/ui/dashboard/home/mont_library_item.dart';
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

class MontLibraryScreen extends StatefulWidget {
  const MontLibraryScreen({Key key}) : super(key: key);

  @override
  State<MontLibraryScreen> createState() => _MontLibraryScreenState();
}

class _MontLibraryScreenState extends State<MontLibraryScreen> {
  List<MontLib> montLib;
  var isLoaded = false;
  @override
  void initState() {
    // Provider.of<DashboardProvider>(context, listen: false).weeklyCalendarFunc(
    //   '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
    //   getEnrollmentModel?.getEnrollmenItems?.first?.courseId ?? 0,
    // );
    //
    // Provider.of<DashboardProvider>(context, listen: false).weeklyCalendarFunc2(
    //   '${getEnrollmentModel?.getEnrollmenItems?.first?.userEmail ?? ''}',
    //   getEnrollmentModel?.getEnrollmenItems?.first?.courseId ?? 0,
    // );

    getData();
    super.initState();
  }

  getData() async {
    var data = loginData?.loginUser;
    montLib = await ApiRequest()
        .getMontLib(data?.email, data?.level, data?.schoolCode);
    if (montLib != null) {
      setState(() {
        isLoaded = true;
      });
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
                          bookCheckIcon,
                          scale: 0.8,
                        ),
                        Text(
                          'Mont. Library',
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
                            image: (loginData?.loginUser?.profilePic == '' ||
                                    loginData?.loginUser?.profilePic == null)
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
                  itemCount: montLib?.length,
                  itemBuilder: (context, index) {
                    return MontLibraryItem(
                      title: montLib[index].kitName,
                      issueDate: montLib[index].issueDate,
                      dueDate: montLib[index].dueDate,
                      returnDate: montLib[index].returnDate,
                    );
                  },
                ),
                replacement: Center(child: Text('Loading...')),
              )),
            ],
          ),
        ),
      );
    });
    ;
  }
}
