import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv_show.dart';
import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetTvShowNow {
  final TvShowRepository tvShowRepository;

  GetTvShowNow(this.tvShowRepository);

  Future<Either<Failure, List<TvShow>>> execute() {
    return tvShowRepository.getNowTvShow();
  }
}
