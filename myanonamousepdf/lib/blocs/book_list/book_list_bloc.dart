import 'package:bloc/bloc.dart';
import 'package:myanonamousepdf/config/locator.dart';
import 'package:myanonamousepdf/services/services.dart';
import 'book_list_event.dart';
import 'book_list_state.dart';

class BookListBloc extends Bloc<BookListEvent, BookListState> {
  final AuthenticationService _authenticationService;

  BookListBloc(AuthenticationService authenticationService)
      : assert(authenticationService != null),
        _authenticationService = authenticationService,
        super(BookListInitial()) {
    on<Loading>(_onAppLoaded);
    on<BookPressed>(__onBookPressed);
  }

  _onAppLoaded(
    Loading event,
    Emitter<BookListState> emit,
  ) async {
    final bookService = getIt<JwtBookService>();

    emit(BookListLoading());
    try {
      await Future.delayed(Duration(milliseconds: 500)); // a simulated delay
      final currentUser = await _authenticationService.getCurrentUser();
      final books = await bookService.getAllBooks(event.page);
      final currentPage = await _authenticationService.getCurrentPage();
      final maxPages = await _authenticationService.getMaxPages();

      if (books.length >= 0) {
        emit(BookListSuccess(
            books: books, currentPage: currentPage!, maxPages: maxPages!));
      }
    } on Exception catch (e) {
      emit(
          BookListFailure(error: 'An unknown error occurred: ${e.toString()}'));
    }
  }

  __onBookPressed(BookPressed event, Emitter<BookListState> emit) async {
    try {
      final user = await _authenticationService.getCurrentUser();
      if (user != null) {
        /*emit(BookListSuccess());
        await Future.delayed(const Duration(seconds: 5));
        //_authenticationBloc.add(UserLoggedIn(user: user));*/
      } else {
        emit(BookListFailure(error: 'Something very weird just happened'));
      }
    } on Exception catch (e) {
      emit(BookListFailure(error: e.toString()));
    }
  }
}
