import 'package:book_app/core/erorrs/failure.dart';
import 'package:book_app/features/home/data/dataSources/home_local_data_source.dart';
import 'package:book_app/features/home/data/dataSources/home_remote_data_sources.dart';
import 'package:book_app/features/home/domain/entities/book_entity.dart';
import 'package:book_app/features/home/domain/repo/home_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class HomeRepoImplemention extends HomeRepo {
  final HomeLocalDataSource homeLocalDataSource;
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepoImplemention(
      {required this.homeLocalDataSource, required this.homeRemoteDataSource});
  @override
  Future<Either<Failure, List<BookEntity>>> fetchFeaturedBooks() async {
    try {
      List<BookEntity> books;
      books = homeLocalDataSource.fetchFeaturedBooks();
      if (books.isNotEmpty) {
        return right(books);
      }
      books = await homeRemoteDataSource.fetchFeaturedBooks();
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(message: '${e.response?.statusMessage}'));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<BookEntity>>> fetchNewsBooks() async {
    try {
      List<BookEntity> books;

      books = homeLocalDataSource.fetchNewsBooks();
      if (books.isNotEmpty) {
        return right(books);
      }
      books = await homeRemoteDataSource.fetchNewsBooks();
      return right(books);
    } catch (e) {
      if (e is DioException) {
        return left(ServerFailure(message: '${e.response?.statusMessage}'));
      }
      return left(ServerFailure(message: e.toString()));
    }
  }
}
