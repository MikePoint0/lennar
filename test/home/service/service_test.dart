import 'package:flutter_test/flutter_test.dart';
import 'package:lennar/screens/home/service/service.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import '../../fixtures/fixture_reader.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  MockHttpClient mockHttpClient = MockHttpClient();
  HomeService api = HomeService(client: mockHttpClient);

  void setUpMockHttpClientSuccess200() {
    when(() => mockHttpClient
            .get(Uri.parse('https://picsum.photos/v2/list?page=1&limit=20')))
        .thenAnswer((_) async => http.Response(fixture("feed.json"), 200));
  }

  void setUpMockHttpClientFailure404() {
    when(() => mockHttpClient
            .get(Uri.parse('https://picsum.photos/v2/list?page=1&limit=20')))
        .thenAnswer((_) async => http.Response('Error', 500));
  }

  group('getFeedList', () {
    test(
      'should return feed when the response code is 200 (success)',
      () async {
        // arrange
        setUpMockHttpClientSuccess200();

        // act
        final data = await api.getFeedList(1, 20);
        // assert
        expect(data, isNotNull);
        expect(data.statusCode, 200);
      },
    );

    test(
      'should throw a ServerException when the response code is 404 or other',
      () async {
        // arrange
        setUpMockHttpClientFailure404();
        // act
        final data = await api.getFeedList(1, 20);
        // assert
        expect(data?.statusCode, 500);
      },
    );
  });
}
