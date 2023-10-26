
import 'package:http/src/response.dart';
import 'package:lennar/core/network/keys.dart';
import 'package:http/http.dart' as http;
class HomeService {
  final http.Client client;

  HomeService({
    required this.client,
  });

  Future<Response> getFeedList(int pageKey, int pageSize) async {
    return client.get(Uri.parse("${ApiConstants.feedList}page=$pageKey&limit=$pageSize",));



  }
}