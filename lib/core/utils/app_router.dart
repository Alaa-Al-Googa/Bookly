import 'package:bookly/features/home/presentation/views/home_view.dart';
import 'package:bookly/features/home/presentation/views/widgets/book_details_view.dart';
import 'package:bookly/features/splash/presentation/views/splash_view.dart';
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
        builder: (context, state) => const BookDetailsView(),
      ),
    ],
  );
}
