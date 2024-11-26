import 'package:book_app/core/erorrs/failure.dart';
import 'package:book_app/core/use_cases/use_case.dart';
import 'package:book_app/features/home/domain/entities/book_entity.dart';
import 'package:book_app/features/home/domain/repo/home_repo.dart';
import 'package:dartz/dartz.dart';

class FetchFeaturedBooksUseCase extends UseCase<List<BookEntity>, int> {
  final HomeRepo homeRepo;

  FetchFeaturedBooksUseCase(this.homeRepo);

  @override
  Future<Either<Failure, List<BookEntity>>> call(int pageNumber)async {
    return await homeRepo.fetchFeaturedBooks(pageNumber: pageNumber==0?0:pageNumber);
  }
}
