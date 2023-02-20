// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:myanonamousepdf/repositories/AuthenticationRepository.dart'
    as _i4;
import 'package:myanonamousepdf/repositories/BookRepository.dart' as _i5;
import 'package:myanonamousepdf/rest/rest_client.dart' as _i3;
import 'package:myanonamousepdf/services/authentication_service.dart' as _i7;
import 'package:myanonamousepdf/services/book_service.dart'
    as _i6; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i3.RestClient>(_i3.RestClient());
    gh.singleton<_i4.AuthenticationRepository>(_i4.AuthenticationRepository());
    gh.singleton<_i5.BookRepository>(_i5.BookRepository());
    gh.singleton<_i6.JwtBookService>(_i6.JwtBookService());
    gh.singleton<_i7.JwtAuthenticationService>(_i7.JwtAuthenticationService());
    return this;
  }
}
