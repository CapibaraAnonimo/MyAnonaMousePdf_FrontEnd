
import 'package:myanonamousepdf/services/services.dart';
import 'package:get_it/get_it.dart'; 
import 'package:injectable/injectable.dart';
import 'package:myanonamousepdf/config/locator.config.dart';
import 'package:shared_preferences/shared_preferences.dart'; 

final getIt = GetIt.instance;


@InjectableInit()
Future<void> configureDependencies() async => await getIt.init();

void setupAsyncDependencies() {
  getIt.registerSingletonAsync<SharedPreferences>(() => SharedPreferences.getInstance(),);
  getIt.registerSingletonAsync<LocalStorageService>(() => LocalStorageService.getInstance());
}