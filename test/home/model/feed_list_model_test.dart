import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:lennar/screens/home/model/feed_list_model.dart';

import '../../fixtures/fixture_reader.dart';

void main() {
  final tFeedListModel = FeedListModel(
      id: "7",
      author: 'Alejandro Escamilla',
      width: 4728,
      height: 3168,
      url: "https://unsplash.com/photos/BbQLHCpVUqA",
      downloadUrl: "https://picsum.photos/id/7/4728/3168");
  test(
    'should be a type of FeedListModel',
    () async {
      // assert
      expect(tFeedListModel, isA<FeedListModel>());
    },
  );

  group('fromJson', () {
    test(
      'should return a valid model ',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(fixture('feed.json'));
        // act
        final result = FeedListModel.fromJson(jsonMap);
        // assert
        expect(result, tFeedListModel);
      },
    );


  });

  group('toJson', () {
    test(
      'should return a JSON map containing the proper data',
      () async {
        // act
        final result = tFeedListModel.toJson();
        // assert
        final expectedMap = {
          "id": "7",
          "author": "Alejandro Escamilla",
          "width": 4728,
          "height": 3168,
          "url": "https://unsplash.com/photos/BbQLHCpVUqA",
          "download_url": "https://picsum.photos/id/7/4728/3168"
        };
        expect(result, expectedMap);
      },
    );
  });
}
