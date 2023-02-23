import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:myanonamousepdf/config/locator.dart';
import 'package:myanonamousepdf/blocs/blocs.dart';
import 'package:myanonamousepdf/pages/books.dart';
import 'package:myanonamousepdf/services/services.dart';
import 'package:myanonamousepdf/pages/pages.dart';
import 'package:flutter/services.dart';

void main() {
  //WidgetsFlutterBinding.ensureInitialized();
  //await SharedPreferences.getInstance();
  setupAsyncDependencies();
  configureDependencies();
  //await getIt.allReady();

  runApp(BlocProvider<AuthenticationBloc>(
    create: (context) {
      final authService = getIt<JwtAuthenticationService>();
      late LocalStorageService _localStorageService;
      
      return AuthenticationBloc(authService)..add(AppLoaded());
    },
    child: MyAnonaMousePdf(),
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
}

class MyAnonaMousePdf extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Authentication Demo',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        scaffoldBackgroundColor: Color.fromARGB(255, 30, 30, 30),
        appBarTheme: AppBarTheme(
            backgroundColor: Color.fromARGB(255, 45, 45, 45).withOpacity(0.5),
            elevation: 0),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
          if (state is AuthenticationAuthenticated) {
            // show home page
            return BookListPage(
              context: context,
              user: state.user,
            ); /*HomePage(
              user: state.user,
            );*/
          }
          // otherwise show login page
          return LoginPage();
        },
      ),
    );
  }
}
