import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:http/src/response.dart';
import 'package:lennar/core/startup/app_startup.dart';
import 'package:lennar/core/utils/constants.dart';
import 'package:lennar/screens/home/model/feed_list_model.dart';
import 'package:lennar/screens/home/service/service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeService service;

  HomeCubit(this.service) : super(HomeInitial());



  getFeeds(int pageKey, int pageSize) async {
    emit(GetFeedsLoading());
    try {
      Response? response = await service.getFeedList(pageKey, pageSize);
      if (response.statusCode == 200 ) {

        List<FeedListModel> data = (jsonDecode(response.body) as List)
            .map((item) => FeedListModel.fromJson(item))
            .toList();

        serviceLocator.registerSingleton<List<FeedListModel>>(data);

        emit(GetFeedsSuccess(data));
      } else {
        emit(GetFeedsError(AppConstants.exceptionMessage));
      }
    } catch (_) {
      print(_.toString());
      emit(GetFeedsError(AppConstants.exceptionMessage));
    }
  }
}