import 'package:flutter/material.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:get/get.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:bright_kid/helpers/widgets/global_widgets.dart';
import 'package:bright_kid/utils/colors.dart';

class WebViewPage extends StatefulWidget {
  final String url;

  WebViewPage({@required this.url});

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: scaffold,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(
            Icons.arrow_back_rounded,
            color: Color(0xff314A72),
          ),
        ),
        centerTitle: true,
      ),

      // appBar: AppBar(
      //   backgroundColor: scaffold,

      //   title: Text(
      //     "Bright Beep",
      //     style: TextStyle(
      //       color: themeColor, // Text color
      //     ),
      //   ),
      //   centerTitle: true, // Center the title
      //   actions: [
      //     IconButton(
      //       icon: Icon(
      //         Icons.refresh,
      //         color: themeColor,
      //       ),
      //       onPressed: () {
      //         // Refresh the web page
      //         setState(() {
      //           isLoading = true;
      //         });
      //         _loadWebPage();
      //       },
      //     ),
      //   ],
      // ),

      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(url: Uri.parse(widget.url)),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                useOnLoadResource: true,
              ),
            ),
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
              });
            },
            onLoadStop: (controller, url) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          if (isLoading)
            Center(
              child: CircularProgressIndicator(
                color: themeColor,
              ),
            ),
        ],
      ),
    );
  }

  // Load the web page
  Future<void> _loadWebPage() async {
    setState(() {
      isLoading = true;
    });

    final urlRequest = URLRequest(url: Uri.parse(widget.url));

    await Future.delayed(Duration(seconds: 1));
    setState(() {
      isLoading = false;
    });
  }
}
