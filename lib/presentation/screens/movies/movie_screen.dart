import 'package:animate_do/animate_do.dart';
import 'package:cinemapedia/config/helpers/human_formats.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MovieScreen extends ConsumerStatefulWidget {
  static const name = 'movie-screen';

  final String movieID;

  const MovieScreen({super.key, required this.movieID});

  @override
  MovieScreenState createState() => MovieScreenState();
}

class MovieScreenState extends ConsumerState<MovieScreen> {
  @override
  void initState() {
    super.initState();
    ref.read(actorsByMovieProvider.notifier).loadActors(widget.movieID);
    ref.read(movieInfoProvider.notifier).loadMovie(widget.movieID);
  }

  @override
  Widget build(BuildContext context) {
    final Movie? movie = ref.watch(movieInfoProvider)[widget.movieID];

    if (movie == null) {
      return const Scaffold(
          body: Center(
              child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            strokeWidth: 2,
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'Cargando película ...',
          )
        ],
      )));
    }

    final size = MediaQuery.of(context).size;
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: size.height * 0.07,
        leading: IconButton(
          color: colors.secondary,
          onPressed: () {
            context.pop();
          },
          icon: const Icon(Icons.arrow_back_ios_new),
        ),
        title: Text(
          movie.title,
          style: TextStyle(
              fontSize: size.height * 0.02, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: Icon(
              Icons.search,
              color: colors.secondary,
              size: 25,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 10, 30, 10),
            child: Icon(
              Icons.ios_share_outlined,
              color: colors.secondary,
            ),
          ),
        ],
      ),
      body: CustomScrollView(
        physics: const ClampingScrollPhysics(),
        slivers: [
          SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
              return Column(children: [
                SizedBox(
                  width: size.width,
                  height: 200,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Image.network(
                        movie.backdropPath,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox.expand(
                          child: DecoratedBox(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                        colors: [Colors.transparent, Colors.black87],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        stops: [0.4, 1.0],
                      )))),
                      Positioned(
                        left: 15,
                        bottom: 5,
                        child: Row(
                          children: [
                            Text('${movie.releaseDate.year.toString()} | ',
                                style:
                                    TextStyle(fontSize: size.height * 0.015)),
                            Text(HumanFormats.reduceDecimals(movie.voteAverage),
                                style:
                                    TextStyle(fontSize: size.height * 0.015)),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 3),
                              child: Icon(Icons.star,
                                  color: colors.secondary, size: 15),
                            ),
                            Text('(${HumanFormats.number(movie.popularity)})',
                                style: TextStyle(fontSize: size.height * 0.015))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                _MovieDetails(
                  movie: movie,
                ),
                const SizedBox(height: 20),
                const _CustomView(),
                const SizedBox(height: 20),
                _CustomContainer(
                  movie: movie,
                ),
                const SizedBox(height: 20),
                const Row(children: [
                  SizedBox(width: 20),
                  Text('ACTORES',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold))
                ]),
                _ActorsByMovie(movieId: movie.id.toString()),
                const SizedBox(height: 100),
              ]);
            }, childCount: 1),
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 5, 23, 32),
    );
  }
}

class _CustomView extends StatelessWidget {
  const _CustomView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _CustomCircle(
          icon: Icons.save_alt_rounded,
          text: 'Listas',
        ),
        _CustomCircle(
          icon: Icons.check,
          text: 'Visto todo',
        ),
        _CustomCircle(
          icon: Icons.thumb_up_alt,
          text: '45k',
        ),
        _CustomCircle(
          icon: Icons.thumb_down_alt,
          text: '1.8k',
        ),
      ],
    );
  }
}

class _CustomCircle extends StatelessWidget {
  final IconData icon;
  final String text;

  const _CustomCircle({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      CircleAvatar(
        backgroundColor: Colors.grey[800],
        minRadius: 18,
        maxRadius: 18,
        child: Icon(
          icon,
          color: Colors.grey,
          size: 15,
        ),
      ),
      Padding(
          padding: const EdgeInsets.only(top: 8),
          child: Text(
            text,
            style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
          ))
    ]);
  }
}

class _MovieDetails extends StatelessWidget {
  final Movie movie;

  const _MovieDetails({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 0, 10),
          child: SizedBox(
            width: size.width * 0.95,
            child: Text(
              movie.title,
              style: const TextStyle(fontSize: 35, fontWeight: FontWeight.w600),
            ),
          ),
        ),
        SizedBox(
          width: size.width * 0.95,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
              child: Text(
                movie.overview,
                style: const TextStyle(fontSize: 13),
              )),
        ),
      ],
    );
  }
}

class _CustomContainer extends StatelessWidget {
  final Movie movie;
  const _CustomContainer({super.key, required this.movie});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String generos = '';
    final colors = Theme.of(context).colorScheme;

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        height: size.height * 0.30,
        width: size.width * 0.92,
        color: const Color.fromARGB(255, 13, 31, 41),
        child: Column(
          children: [
            ...movie.genreIds.map((gender) {
              if (gender == movie.genreIds.last) {
                generos += '$gender.';
              } else {
                generos += '$gender, ';
              }
              return Container();
            }),
            _LineaContainer(title: 'GÉNEROS', text: generos),
            _LineaContainer(
                title: 'ADULTOS', text: HumanFormats.returnBool(movie.adult)),
            _LineaContainer(
                title: 'LENGUAJE ORIGINAL',
                text: movie.originalLanguage.toUpperCase()),
            _LineaContainer(
              title: 'FECHA DE LANZAMIENTO',
              text:
                  '${movie.releaseDate.year.toString()} - ${movie.releaseDate.month.toString()} - ${movie.releaseDate.day.toString()}',
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    width: 120,
                    child: Text('VALORACIÓN',
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: Icon(
                      Icons.star,
                      color: colors.secondary,
                      size: 15,
                    ),
                  ),
                  Text(HumanFormats.reduceDecimals(movie.voteAverage),
                      style: const TextStyle(fontSize: 13)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LineaContainer extends StatelessWidget {
  const _LineaContainer({
    required this.text,
    required this.title,
  });

  final String title;

  final String text;

  @override
  Widget build(BuildContext context) {
    const categoryStyle = TextStyle(
        fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 120, child: Text(title, style: categoryStyle)),
          Text(text, style: const TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}

class _ActorsByMovie extends ConsumerWidget {
  final String movieId;
  const _ActorsByMovie({required this.movieId});

  @override
  Widget build(BuildContext context, ref) {
    final actorsByMovie = ref.watch(actorsByMovieProvider);

    if (actorsByMovie[movieId] == null) {
      return const CircularProgressIndicator(
        strokeWidth: 2,
      );
    }
    final actors = actorsByMovie[movieId]!;

    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: actors.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final actor = actors[index];

          return FadeInRight(
            child: Container(
              padding: const EdgeInsets.all(8),
              width: 135,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                      actor.profilePath,
                      height: 180,
                      width: 135,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    actor.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    actor.character ?? '',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 15, color: Colors.grey),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
