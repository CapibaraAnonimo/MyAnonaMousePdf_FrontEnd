import 'package:bloc/bloc.dart';
import 'package:myanonamousepdf/blocs/book_details/book_details_state.dart';
import 'package:myanonamousepdf/blocs/book_list/book_list.dart';
import 'package:myanonamousepdf/config/locator.dart';
import 'package:myanonamousepdf/models/book.dart';
import 'package:myanonamousepdf/services/services.dart';
import 'book_details_event.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  final AuthenticationService _authenticationService;

  BookDetailsBloc(AuthenticationService authenticationService)
      : assert(authenticationService != null),
        _authenticationService = authenticationService,
        super(BookDetailsInitial()) {
    on<GetData>(_getData);
    on<DownloadBook>(_onDownload);
  }

  /*_onAppLoaded(
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
  }*/

  _getData(GetData event, Emitter<BookDetailsState> emit) async {
    try {
      emit(BookDetailsLoading());
      final bookService = getIt<JwtBookService>();
      final BookResponse book = await bookService.getBookById(event.id);
      if (book != null) {
        emit(BookDetailsSuccess(book: book));
      } else {
        emit(BookDetailsFailure(error: 'Something very weird just happened'));
      }
    } on Exception catch (e) {
      emit(BookDetailsFailure(error: e.toString()));
    }
  }

  _onDownload(DownloadBook event, Emitter<BookDetailsState> emit) async {
    //TODO hacer esto cuando se pueda
    try {
      final user = await _authenticationService.getCurrentUser();
      if (user != null) {
        /*emit(BookListSuccess());
        await Future.delayed(const Duration(seconds: 5));
        //_authenticationBloc.add(UserLoggedIn(user: user));*/
      } else {
        emit(BookDetailsFailure(error: 'Something very weird just happened'));
      }
    } on Exception catch (e) {
      emit(BookDetailsFailure(error: e.toString()));
    }
  }
}
