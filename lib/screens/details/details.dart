import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lennar/core/utils/colors.dart';

import '../../core/widgets/appbar.dart';

class DetailsScreen extends StatelessWidget {
  final String imageUrl;

  DetailsScreen(this.imageUrl);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppAppBar(
    titleText: "details".tr(),
    titleStyle: TextStyle(color: AppColors.darkPrimary, fontSize: 18.sp),
    ),
      body: Center(
        child: Container(
            //TODO: use cacheImage
            //child: CachedNetworkImage(
            //   imageUrl: "https://fastly.picsum.photos/id/102/4320/3240.jpg",
            //   placeholder: (context, url) => CircularProgressIndicator(),
            //   errorWidget: (context, url, error) => Icon(Icons.error),
            // )
            decoration: BoxDecoration(
                color: AppColors.sonaBlack,
                borderRadius: BorderRadius.circular(8.0),
                image: DecorationImage(
                  fit: BoxFit.contain,
                  image: NetworkImage(imageUrl),
                ))),
      ),
    );
  }
}
