part of 'fetch_featured_books_cubit.dart';

@immutable
sealed class FetchFeaturedBooksState {}

final class FetchFeaturedBooksInitial extends FetchFeaturedBooksState {}

final class FetchFeaturedBooksLoading extends FetchFeaturedBooksState {}

final class FetchFeaturedBooksPaginitionLoading
    extends FetchFeaturedBooksState {}

final class FetchFeaturedBooksPaginitionError extends FetchFeaturedBooksState {
  final String errMessage;

  FetchFeaturedBooksPaginitionError({required this.errMessage});
}

final class FetchFeaturedBooksSuccess extends FetchFeaturedBooksState {
  final List<BookEntity> books;

  FetchFeaturedBooksSuccess({required this.books});
}

final class FetchFeaturedBooksFailuer extends FetchFeaturedBooksState {
  final String message;

  FetchFeaturedBooksFailuer({required this.message});
}
