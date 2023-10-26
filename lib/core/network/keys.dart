import 'package:lennar/core/config/config.dart';

class ApiConstants {

  static const String baseUrl="https://picsum.photos/v2/";

  ApiConstants() {
    if (AppConfig.environment == Environment.production) {
      const String baseUrl="https://picsum.photos/v2/";
    }
  }

  static String feedList = '${baseUrl}list?';

}
