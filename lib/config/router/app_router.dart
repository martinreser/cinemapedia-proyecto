import 'package:cinemapedia/presentation/screens/screens.dart';
import 'package:cinemapedia/presentation/views/views.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  initialLocation: '/home/0',
  routes: [
    GoRoute(
        path: '/home/:page',
        builder: (context, state) {
          final pageIndex = state.pathParameters['page'] ?? '0';
          return HomeScreen(pageIndex: int.parse(pageIndex));
        },
        routes: [
          GoRoute(
              name: MovieScreen.name,
              path: 'movie/:id',
              builder: (context, state) {
                final movieId = state.pathParameters['id'] ?? 'no-id';

                return MovieScreen(movieID: movieId);
              }),
        ]),
    GoRoute(
      path: '/favorites',
      builder: (context, state) => const FavoritesView(),
    ),

    GoRoute(path: '/', redirect: (_, __) => '/home/0')
    // ShellRoute(
    //   builder: (context, state, child) {
    //     return HomeScreen(childView: child);
    //   },
    //   routes: [
    //     GoRoute(
    //         path: '/',
    //         builder: (context, state) => const HomeView(),
    //         routes: [
    //           GoRoute(
    //               name: MovieScreen.name,
    //               path: 'movie/:id',
    //               builder: (context, state) {
    //                 final movieId = state.pathParameters['id'] ?? 'no-id';

    //                 return MovieScreen(movieID: movieId);
    //               }),
    //         ]),
    //     GoRoute(
    //       path: '/favorites',
    //       builder: (context, state) => const FavoritesView(),
    //     ),
    //   ],
    // )
  ],
);
