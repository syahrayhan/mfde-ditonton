import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie.dart';
import 'package:ditonton/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/presentation/bloc/popular_movie/popular_movie_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'popular_movie_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late PopularMovieBloc bloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    bloc = PopularMovieBloc(mockGetPopularMovies);
  });

  test('initial state should be initial', () {
    expect(bloc.state, PopularMovieInitial());
  });

  final tMovie = Movie(
    adult: false,
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    originalTitle: 'originalTitle',
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    releaseDate: 'releaseDate',
    title: 'title',
    video: false,
    voteAverage: 1,
    voteCount: 1,
  );

  final tMovieList = <Movie>[tMovie];

  blocTest(
    'should emit [Loading, Loaded] when data is gotten successfully',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Right(tMovieList));
      return bloc;
    },
    act: (PopularMovieBloc bloc) => bloc.add(OnPopularMovieRequested()),
    expect: () => [PopularMovieLoading(), PopularMovieLoaded(tMovieList)],
    verify: (PopularMovieBloc bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );

  blocTest(
    'should emit [Loading, Error] when data is unsuccessful',
    build: () {
      when(mockGetPopularMovies.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return bloc;
    },
    act: (PopularMovieBloc bloc) => bloc.add(OnPopularMovieRequested()),
    expect: () => [PopularMovieLoading(), PopularMovieError('Server Failure')],
    verify: (PopularMovieBloc bloc) {
      verify(mockGetPopularMovies.execute());
    },
  );
}
