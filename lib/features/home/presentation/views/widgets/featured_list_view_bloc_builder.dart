// import 'dart:developer';

// import 'package:book_app/features/home/presentation/manager/featured_book_cubit/fetch_featured_books_cubit.dart';
// import 'package:book_app/features/home/presentation/views/widgets/featured_list_view.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';

// class FeaturedBooksListViewBlocBuilder extends StatelessWidget {
//   const FeaturedBooksListViewBlocBuilder({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<FetchFeaturedBooksCubit, FetchFeaturedBooksState>(
//         builder: (context, state) {
//       if (state is FetchFeaturedBooksSuccess ||
//           state is FetchFeaturedBooksPaginitionLoading) {
//         if (state is FetchFeaturedBooksSuccess) {
//           log(state.books.length.toString());
//           return FeaturedBooksListView(
//             books: state.books,
//           );
//         }else{
//           return FeaturedBooksListView(
//             books: state.books,
//           );
//         }
//       } else if (state is FetchFeaturedBooksFailuer) {
//         return Text(state.message);
//       } else {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       }
//     });
//   }
// }

import 'package:book_app/features/home/domain/entities/book_entity.dart';
import 'package:book_app/features/home/presentation/manager/featured_book_cubit/fetch_featured_books_cubit.dart';
import 'package:book_app/features/home/presentation/views/widgets/custom_featured_list_view_loading_indcator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'featured_list_view.dart';

class FeaturedBooksListViewBlocBuilder extends StatefulWidget {
  const FeaturedBooksListViewBlocBuilder({
    super.key,
  });

  @override
  State<FeaturedBooksListViewBlocBuilder> createState() =>
      _FeaturedBooksListViewBlocBuilderState();
}

class _FeaturedBooksListViewBlocBuilderState
    extends State<FeaturedBooksListViewBlocBuilder> {
  List<BookEntity> books = [];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FetchFeaturedBooksCubit, FetchFeaturedBooksState>(
      listener: (context, state) {
        if (state is FetchFeaturedBooksSuccess) {
          books.addAll(state.books);
        }

        // if (state is FetchFeaturedBooksPaginitionLoading) {
        //   ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        //     content: Center(child: CircularProgressIndicator()),
        //   ));
        // }
      },
      builder: (context, state) {
        if (state is FetchFeaturedBooksSuccess ||
            state is FetchFeaturedBooksPaginitionLoading ||
            state is FetchFeaturedBooksPaginitionError) {
          return FeaturedBooksListView(
            books: books,
          );
        } else if (state is FetchFeaturedBooksFailuer) {
          return Text(state.message);
        } else {
          return const FeaturedBooksListViewLoadingIndicator();
        }
      },
    );
  }
}
