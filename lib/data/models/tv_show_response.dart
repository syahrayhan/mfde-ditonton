import 'package:ditonton/data/models/tv_show_model.dart';
import 'package:equatable/equatable.dart';

class TvShowResponse extends Equatable {
  final List<TvShowModel> tvShowList;

  TvShowResponse({required this.tvShowList});

  factory TvShowResponse.fromJson(Map<String, dynamic> json) => TvShowResponse(
        tvShowList: List<TvShowModel>.from((json["results"] as List)
            .map((e) => TvShowModel.fromJson(e))
            .where((element) =>
                element.posterPath != null && element.overview != "")),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(tvShowList.map((e) => e.toJson())),
      };

  @override
  List<Object?> get props => [tvShowList];
}
