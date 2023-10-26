import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lennar/core/startup/app_startup.dart';
import 'package:lennar/core/utils/colors.dart';
import 'package:lennar/core/widgets/appbar.dart';
import 'package:lennar/screens/home/cubit/home_cubit.dart';
import 'package:lennar/screens/home/model/feed_list_model.dart';
import 'package:lennar/screens/home/widget/feed_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<FeedListModel> feedListModel = [];
  PagingController<int, FeedListModel> pagingController =
      PagingController(firstPageKey: 1);
  int pageSize = 5;
  int pageKey = 1;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    pagingController.addPageRequestListener((pageKey) {
      _getData();
    });
  }

  _getData() async {
    await serviceLocator<HomeCubit>().getFeeds(pageKey, pageSize);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppAppBar(
          key: Key('appAppBarKey'),
          titleText: "home".tr(),
          titleStyle: TextStyle(color: AppColors.darkPrimary, fontSize: 18.sp),
        ),
        body: BlocConsumer(
          bloc: serviceLocator<HomeCubit>(),
          listener: (_, state) {
            if (state is GetFeedsError) {
              pagingController.error = state.message;
            }
            if (state is GetFeedsSuccess) {
              feedListModel = state.feedListModel;
              final isLastPageCheck = state.feedListModel.length < pageSize;

              if (isLastPageCheck == true) {
                setState(() {
                  pagingController.appendLastPage(state.feedListModel);
                });
              } else {
                setState(() {
                  pageKey++;
                  pagingController.appendPage(state.feedListModel, pageKey);
                  isLastPage = false;
                });
              }

              setState(() {});
            }
          },
          builder: (_, state) {
            return PagedListView<int, FeedListModel>(
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate<FeedListModel>(
                itemBuilder: (context, item, index) => Container(
                  margin: EdgeInsets.symmetric(vertical: 2.h),
                  child: FeedItem(item: item),
                ),
              ),
            );
          },
        ));
  }
}
