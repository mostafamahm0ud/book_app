import 'package:bloc/bloc.dart';
import 'package:book_app/features/home/domain/entities/book_entity.dart';
import 'package:book_app/features/home/domain/use_case/fetch_featured_books_use_case.dart';
import 'package:meta/meta.dart';

part 'fetch_featured_books_state.dart';

class FetchFeaturedBooksCubit extends Cubit<FetchFeaturedBooksState> {
  FetchFeaturedBooksCubit(this.fetchFeaturedBooksUseCase)
      : super(FetchFeaturedBooksInitial());

  final FetchFeaturedBooksUseCase fetchFeaturedBooksUseCase;
  Future<void> fetchFeaturedBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(FetchFeaturedBooksLoading());
    } else {
      emit(FetchFeaturedBooksPaginitionLoading());
    }

    var result = await fetchFeaturedBooksUseCase.call(pageNumber);

    result.fold(
        (failure) => emit(FetchFeaturedBooksFailuer(message: failure.message!)),
        (books) => emit(FetchFeaturedBooksSuccess(books: books)));
  }
}
