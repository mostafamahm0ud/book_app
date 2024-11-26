import 'package:bloc/bloc.dart';
import 'package:book_app/features/home/domain/entities/book_entity.dart';
import 'package:book_app/features/home/domain/use_case/fetch_news_books_use_case.dart';
import 'package:meta/meta.dart';

part 'fetch_newest_books_state.dart';

class FetchNewestBooksCubit extends Cubit<FetchNewestBooksState> {
  FetchNewestBooksCubit(this.fetchNewsBooksUseCase)
      : super(FetchNewestBooksInitial());
  final FetchNewsBooksUseCase fetchNewsBooksUseCase;
  Future<void> fetchNewestBooks() async {
    emit(FetchNewestBooksLoading());
    var result = await fetchNewsBooksUseCase.call();
    result.fold(
        (failure) => emit(FetchNewestBooksFailure(message: failure.message!)),
        (books) => emit(FetchNewestBooksSuccess(books: books)));
  }
}
