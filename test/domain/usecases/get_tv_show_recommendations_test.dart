import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/usecases/get_tv_show_recommendations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvShowRecommendations usecase;
  late MockTvShowRepository mockTvShowRepository;

  setUp(() {
    mockTvShowRepository = MockTvShowRepository();
    usecase = GetTvShowRecommendations(mockTvShowRepository);
  });

  final tMovies = <TvShow>[];

  group('GetTvShowRecommendations Tests', () {
    final tId = 1;
    group('execute', () {
      test(
          'should get list of tv show from the repository when execute function is called',
          () async {
        // arrange
        when(mockTvShowRepository.getTvShowRecomendation(tId))
            .thenAnswer((_) async => Right(tMovies));
        // act
        final result = await usecase.execute(tId);
        // assert
        expect(result, Right(tMovies));
      });
    });
  });
}
