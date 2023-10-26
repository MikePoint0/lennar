import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:lennar/screens/home/cubit/home_cubit.dart';

import '../../screens/home/service/service.dart';

void registerCubit(GetIt serviceLocator) {

  serviceLocator.registerSingleton(
    HomeCubit(
      HomeService(
        client: Client(),
      ),
    ),
  );
}
