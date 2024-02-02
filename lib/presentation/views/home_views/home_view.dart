import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);

    if (initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final slideShowMovies = ref.watch(moviesSlideshowProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            titlePadding: EdgeInsets.all(0),
            title: CustomAppBar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              const SizedBox(height: 20),
              MoviesSlideshow(movies: slideShowMovies),
              MovieHorizontalListview(
                movies: nowPlayingMovies,
                title: 'En cines',
                subtitle: 'Lunes 20',
                // El read se usa cuando estemos dentro de funciones o callbacks
                loadNextPage: () =>
                    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListview(
                movies: upcomingMovies,
                title: 'Proximamente',
                subtitle: 'En este mes',
                // El read se usa cuando estemos dentro de funciones o callbacks
                loadNextPage: () =>
                    ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListview(
                movies: popularMovies,
                title: 'Populares',
                // El read se usa cuando estemos dentro de funciones o callbacks
                loadNextPage: () =>
                    ref.read(popularMoviesProvider.notifier).loadNextPage(),
              ),
              MovieHorizontalListview(
                movies: topRatedMovies,
                title: 'Mejor valoradas',
                subtitle: 'Desde siempre',
                // El read se usa cuando estemos dentro de funciones o callbacks
                loadNextPage: () =>
                    ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
              ),
              const SizedBox(height: 20)
            ],
          );
        }, childCount: 1)),
      ],
    );

    // return CustomScrollView(
    //   slivers: [
    //     SliverAppBar(
    //       surfaceTintColor: Colors.white,
    //       floating: true,
    //       flexibleSpace: FlexibleSpaceBar(
    //         title: CustomAppBar(),
    //         background: Container(color: Colors.red),
    //       ),
    //     ),
    //     SliverList(
    //         delegate: SliverChildBuilderDelegate((context, index) {
    //       return Column(
    //         children: [
    //           SizedBox(height: 20),
    //           MoviesSlideshow(movies: slideShowMovies),
    //           MovieHorizontalListview(
    //             movies: nowPlayingMovies,
    //             title: 'En cines',
    //             subtitle: 'Lunes 20',
    //             // El read se usa cuando estemos dentro de funciones o callbacks
    //             loadNextPage: () =>
    //                 ref.read(nowPlayingMoviesProvider.notifier).loadNextPage(),
    //           ),
    //           MovieHorizontalListview(
    //             movies: upcomingMovies,
    //             title: 'Proximamente',
    //             subtitle: 'En este mes',
    //             // El read se usa cuando estemos dentro de funciones o callbacks
    //             loadNextPage: () =>
    //                 ref.read(upcomingMoviesProvider.notifier).loadNextPage(),
    //           ),
    //           MovieHorizontalListview(
    //             movies: popularMovies,
    //             title: 'Populares',
    //             // El read se usa cuando estemos dentro de funciones o callbacks
    //             loadNextPage: () =>
    //                 ref.read(popularMoviesProvider.notifier).loadNextPage(),
    //           ),
    //           MovieHorizontalListview(
    //             movies: topRatedMovies,
    //             title: 'Mejor valoradas',
    //             subtitle: 'Desde siempre',
    //             // El read se usa cuando estemos dentro de funciones o callbacks
    //             loadNextPage: () =>
    //                 ref.read(topRatedMoviesProvider.notifier).loadNextPage(),
    //           ),
    //           const SizedBox(height: 20)
    //         ],
    //       );
    //     }, childCount: 1)),
    //   ],
    // );
  }
}
