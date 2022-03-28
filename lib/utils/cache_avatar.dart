import 'package:bright_kid/helpers/services/api_url.dart';
import 'package:bright_kid/utils/colors.dart';
import 'package:bright_kid/utils/images.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CachedAvatar extends StatelessWidget {
  final String imageUrl;
  final double radius;
  CachedAvatar({@required this.imageUrl, @required this.radius});
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      repeat: ImageRepeat.repeat,
      useOldImageOnUrlChange: true,
      placeholder: (context, url) => Shimmer.fromColors(
        direction: ShimmerDirection.ltr,
        baseColor: themeColor,
        highlightColor: Color(0xffD2D3D5),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
          ),
        ),
      ),
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) => CircleAvatar(
        radius: radius ?? 20,
        backgroundImage: imageProvider,
      ),
      errorWidget: (context, url, error) => CircleAvatar(
        backgroundImage: AssetImage(dp),
        radius: radius,
      ),
    );
  }
}
