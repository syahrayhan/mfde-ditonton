import 'package:ditonton/domain/repositories/tv_show_repository.dart';

class GetTvWatchlistStatus {
  final TvShowRepository repository;

  GetTvWatchlistStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToTvShowWatchlist(id);
  }
}
