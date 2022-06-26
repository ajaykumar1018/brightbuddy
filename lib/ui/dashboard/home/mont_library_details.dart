import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class MontLibraryDetails extends StatelessWidget {
  const MontLibraryDetails({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: double.infinity,
            child: Text(
              '14/22 12:43',
              textAlign: TextAlign.end,
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Row(
            children: [
              Container(
                child: Image.network(
                  'https://static.wikia.nocookie.net/batman/images/f/f9/Heath_Ledger_as_the_Joker.JPG/revision/latest?cb=20211006123111',
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Product name',
                    style: MyTextStyle.mulishBlack().copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: Get.width * .04,
                      color: themeColor,

                      //decoration: TextDecoration.underline,
                    ),
                  ),
                  Text('body text...')
                ],
              )
            ],
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            child: ElevatedButton(
              onPressed: () {},
              child: Text('Due for Return : 22/11/22'),
            ),
          )
        ],
      ),
    );
  }
}
