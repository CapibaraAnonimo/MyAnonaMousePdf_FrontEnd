
import 'package:myanonamousepdf/services/services.dart';
import 'package:get_it/get_it.dart'; 
import 'package:injectable/injectable.dart';
import 'package:myanonamousepdf/config/locator.config.dart'; 

final getIt = GetIt.instance;


@InjectableInit()
void configureDependencies() => getIt.init();

void setupAsyncDependencies() {
  //var localStorageService = await LocalStorageService.getInstance();
  //getIt.registerSingleton(localStorageService);
  getIt.registerSingletonAsync<LocalStorageService>(() => LocalStorageService.getInstance());
}