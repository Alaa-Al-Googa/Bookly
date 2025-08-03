import 'package:bookly/core/utils/service_locator.dart';
import 'package:bookly/features/home/data/models/book_model/book_model.dart';
import 'package:bookly/features/home/data/repos/home_repo_impl.dart';
import 'package:bookly/features/home/presentation/manger/similar_books_cubit/similar_books_cubit.dart';
import 'package:bookly/features/home/presentation/views/home_view.dart';
import 'package:bookly/features/home/presentation/views/widgets/book_details_view.dart';
import 'package:bookly/features/search/presentation/view/search_view.dart';
import 'package:bookly/features/splash/presentation/views/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static final router = GoRouter(
    routes: [
      // splash
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      // home
      GoRoute(path: '/home', builder: (context, state) => const HomeView()),
      //detailsBook
      GoRoute(
        path: '/detailsBook',
        builder: (context, state) => BlocProvider(
          create: (context) => SimilarBooksCubit(getIt.get<HomeRepoImpl>()),
          child: BookDetailsView(bookModel: state.extra as BookModel),
        ),
      ),
      //search
      GoRoute(path: '/search', builder: (context, state) => const SearchView()),
    ],
  );
}
