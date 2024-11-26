import 'package:book_app/constants.dart';
import 'package:book_app/core/utils/app_router.dart';
import 'package:book_app/core/utils/bloc_observer.dart';
import 'package:book_app/core/utils/functions/setup_service_locator.dart';
import 'package:book_app/features/home/domain/entities/book_entity.dart';
import 'package:book_app/features/home/domain/repo/home_repo.dart';
import 'package:book_app/features/home/domain/use_case/fetch_featured_books_use_case.dart';
import 'package:book_app/features/home/domain/use_case/fetch_news_books_use_case.dart';
import 'package:book_app/features/home/presentation/manager/featured_book_cubit/fetch_featured_books_cubit.dart';
import 'package:book_app/features/home/presentation/manager/newest_book_cubit/fetch_newest_books_cubit.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Hive with Flutter support
  final directory = await getApplicationDocumentsDirectory();
  Hive.init(directory.path); // Specify the path
  Hive.initFlutter(directory.path);
  // Register your adapter
  Hive.registerAdapter(BookEntityAdapter());

  // Open boxes
  await Hive.openBox<BookEntity>(KFeaturedBox);
  await Hive.openBox<BookEntity>(KNewestBox);

  setupServiceLocator();
  runApp(const BookApp());
  Bloc.observer = SimpleBlocObserver();
}

class BookApp extends StatelessWidget {
  const BookApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) {
            return FetchFeaturedBooksCubit(
              FetchFeaturedBooksUseCase(
                getIt.get<HomeRepo>(),
              ),
            )..fetchFeaturedBooks();
          },
        ),
        BlocProvider(
          create: (context) {
            return FetchNewestBooksCubit(
              FetchNewsBooksUseCase(
                getIt.get<HomeRepo>(),
              ),
            )..fetchNewestBooks();
          },
        ),
      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: kPrimaryColor,
          textTheme:
              GoogleFonts.montserratTextTheme(ThemeData.dark().textTheme),
        ),
      ),
    );
  }
}
