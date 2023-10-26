import 'dart:convert';

import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lennar/screens/home/cubit/home_cubit.dart';
import 'package:lennar/screens/home/model/feed_list_model.dart';
import 'package:lennar/screens/home/service/service.dart';

import 'package:mocktail/mocktail.dart';

import '../../fixtures/fixture_reader.dart';
import '../service/service_test.dart';

import 'package:http/http.dart' as http;

void main() {
  group('HomeCubit', () {
    late HomeCubit homeCubit;
    MockHttpClient mockHttpClient = MockHttpClient();
    HomeService api = HomeService(client: mockHttpClient);
    setUp(() {
      homeCubit = HomeCubit(api);
    });

    tearDown(() {
      homeCubit.close();
    });

    final mockResponse = http.Response(
      fixture("feeds.json"),
      200,
    );
    List<FeedListModel> data = (jsonDecode(mockResponse.body) as List)
        .map((item) => FeedListModel.fromJson(item))
        .toList();

    blocTest<HomeCubit, HomeState>(
      'emits [GetFeedsLoading, GetFeedsSuccess] when getFeedList is called successfully',
      build: () {
        when(() => mockHttpClient.get(
                Uri.parse('https://picsum.photos/v2/list?page=1&limit=20')))
            .thenAnswer((_) async => http.Response(fixture("feeds.json"), 200));
        return homeCubit;
      },
      act: (cubit) => cubit.getFeeds(1, 20),
      expect: () => [GetFeedsLoading(), GetFeedsSuccess(data)],
    );

    blocTest<HomeCubit, HomeState>(
      'emits [GetFeedsLoading, GetFeedsError] when getFeedList is failed',
      build: () {
        when(() => mockHttpClient.get(
                Uri.parse('https://picsum.photos/v2/list?page=1&limit=20')))
            .thenAnswer((_) async => http.Response(fixture("feeds.json"), 500));
        return homeCubit;
      },
      act: (cubit) => cubit.getFeeds(1, 20),
      expect: () => [GetFeedsLoading(), GetFeedsError("")],
    );
  });
}
