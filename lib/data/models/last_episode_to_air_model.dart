import 'package:ditonton/domain/entities/last_episode_to_air.dart';
import 'package:equatable/equatable.dart';

class LastEpisodeToAirModel extends Equatable {
  LastEpisodeToAirModel({
    required this.airDate,
    required this.episodeNumber,
    required this.id,
    required this.name,
    required this.overview,
    required this.productionCode,
    required this.runtime,
    required this.seasonNumber,
    required this.stillPath,
    required this.voteAverage,
    required this.voteCount,
  });

  final String airDate;
  final int episodeNumber;
  final int id;
  final String name;
  final String overview;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final String stillPath;
  final double voteAverage;
  final int voteCount;

  factory LastEpisodeToAirModel.fromJson(Map<String, dynamic> json) =>
      LastEpisodeToAirModel(
        airDate: json["air_date"],
        episodeNumber: json["episode_number"],
        id: json["id"],
        name: json["name"],
        overview: json["overview"],
        productionCode: json["production_code"],
        runtime: json["runtime"],
        seasonNumber: json["season_number"],
        stillPath: json["still_path"],
        voteAverage: json["vote_average"],
        voteCount: json["vote_count"],
      );

  Map<String, dynamic> toJson() => {
        "air_date": airDate,
        "episode_number": episodeNumber,
        "id": id,
        "name": name,
        "overview": overview,
        "production_code": productionCode,
        "runtime": runtime,
        "season_number": seasonNumber,
        "still_path": stillPath,
        "vote_average": voteAverage,
        "vote_count": voteCount,
      };

  LastEpisodeToAir toEntity() => LastEpisodeToAir(
        airDate: this.airDate,
        episodeNumber: this.episodeNumber,
        id: this.id,
        name: this.name,
        overview: this.overview,
        productionCode: this.productionCode,
        runtime: this.runtime,
        seasonNumber: this.seasonNumber,
        stillPath: this.stillPath,
        voteAverage: this.voteAverage,
        voteCount: this.voteCount,
      );

  @override
  List<Object?> get props => [
        airDate,
        episodeNumber,
        id,
        name,
        overview,
        productionCode,
        runtime,
        seasonNumber,
        stillPath,
        voteAverage,
        voteCount,
      ];
}
