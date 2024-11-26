import 'package:book_app/core/utils/api_services.dart';
import 'package:book_app/features/home/data/dataSources/home_local_data_source.dart';
import 'package:book_app/features/home/data/dataSources/home_remote_data_sources.dart';
import 'package:book_app/features/home/data/repo/home_repo_implemention.dart';
import 'package:book_app/features/home/domain/repo/home_repo.dart';
import 'package:get_it/get_it.dart';

void setupServiceLocator() {
  getIt.registerSingleton<HomeRepo>(HomeRepoImplemention(
      homeLocalDataSource: HomeLocalDataSourcesImplemetation(),
      homeRemoteDataSource:
          HomeRemoteDataSourcesImplemetation(apiServices: ApiServices())));
}

final getIt = GetIt.instance;
