import 'package:book_app/constants.dart';
import 'package:book_app/features/home/domain/entities/book_entity.dart';
import 'package:hive/hive.dart';

abstract class HomeLocalDataSource {
  List<BookEntity> fetchFeaturedBooks();
  List<BookEntity> fetchNewsBooks();
}

class HomeLocalDataSourcesImplemetation extends HomeLocalDataSource {
  @override
  List<BookEntity> fetchFeaturedBooks() {
    var box = Hive.box<BookEntity>(KFeaturedBox);
    return box.values.toList();
  }

  @override
  List<BookEntity> fetchNewsBooks() {
    var box = Hive.box<BookEntity>(KNewestBox);

    return box.values.toList();
  }
}
