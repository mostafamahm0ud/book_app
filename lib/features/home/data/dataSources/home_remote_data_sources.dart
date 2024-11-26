import 'package:book_app/constants.dart';
import 'package:book_app/core/utils/api_services.dart';
import 'package:book_app/core/utils/functions/cached_books.dart';
import 'package:book_app/features/home/data/models/book_model/book_model.dart';
import 'package:book_app/features/home/domain/entities/book_entity.dart';

// here we create the interface for the remote data source to get the data from the api and only return the data not check the data
abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0});
  Future<List<BookEntity>> fetchNewsBooks();
}

class HomeRemoteDataSourcesImplemetation extends HomeRemoteDataSource {
  final ApiServices apiServices;

  HomeRemoteDataSourcesImplemetation({required this.apiServices});
  @override
  Future<List<BookEntity>> fetchFeaturedBooks({int pageNumber = 0}) async {
    var data = await apiServices.get(
        endPoint:
            'volumes?Filtering=free-ebooks&q=programming&startIndex=${pageNumber*10}');

    List<BookEntity> books = getListOfBooks(data);

    cachedBooksData(books, KFeaturedBox);
    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewsBooks() async {
    var data = await apiServices.get(
        endPoint: 'volumes?Filtering=free-ebooks&Sorting=newest');

    List<BookEntity> books = getListOfBooks(data);
    cachedBooksData(books, KNewestBox);
    return books;
  }

  List<BookEntity> getListOfBooks(Map<String, dynamic> data) {
    List<BookEntity> books = [];
    for (var item in data['items']) {
      books.add(BookModel.fromJson(item));
    }

    cachedBooksData(books, KNewestBox);
    return books;
  }
}
