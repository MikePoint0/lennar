import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lennar/core/navigation/keys.dart';
import 'package:lennar/core/navigation/navigation_service.dart';
import 'package:lennar/core/startup/app_startup.dart';
import 'package:lennar/screens/home/model/feed_list_model.dart';

class FeedItem extends StatelessWidget {
  const FeedItem({
    super.key,
    required this.item,
  });

  final FeedListModel item;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 136,
        margin: const EdgeInsets.symmetric(
            horizontal: 16, vertical: 8.0),
        decoration: BoxDecoration(
            border: Border.all(color: const Color(0xFFE0E0E0)),
            borderRadius: BorderRadius.circular(8.0)),
        padding: const EdgeInsets.all(8),
        child: InkWell(
          onTap: () {
            serviceLocator.get<NavigationService>().toWithPameter(
              routeName: RouteKeys.routeDetails,
              data: {
                "imageUrl" : item.downloadUrl
              }
            );
          },
          child: Row(
          children: [
            Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.author ?? "",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Text("${item.width.toString()} X ${item.height.toString() ?? ""}",
                        style: Theme.of(context).textTheme.caption),
                    const SizedBox(height: 8),
                    // Row(
                    //   mainAxisSize: MainAxisSize.min,
                    //   children: [
                    //     Icons.bookmark_border_rounded,
                    //     Icons.share,
                    //     Icons.more_vert
                    //   ].map((e) {
                    //     return InkWell(
                    //       onTap: () {},
                    //       child: Padding(
                    //         padding:
                    //         EdgeInsets.only(right: 8.0.w),
                    //         child: Icon(e, size: 16.sp),
                    //       ),
                    //     );
                    //   }).toList(),
                    // )
                  ],
                )),
            //
            Container(
                width: 100.w,
                height: 100.h,
                //TODO: use cacheImage
                //child: CachedNetworkImage(
                  //   imageUrl: "https://fastly.picsum.photos/id/102/4320/3240.jpg",
                  //   placeholder: (context, url) => CircularProgressIndicator(),
                  //   errorWidget: (context, url, error) => Icon(Icons.error),
                  // )
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(8.0),
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(item.downloadUrl ?? ""),
                    ))),
          ],
        ),
      ),
    );
  }
}
