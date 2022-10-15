import 'package:dexter_todo/core/repository/app_repository.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt();
void setUpLocator() {
  locator.registerLazySingleton(() => AppRepository());
}