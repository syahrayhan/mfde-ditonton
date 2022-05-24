import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_show_popular_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowPopularPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-show-popular';
  const TvShowPopularPage({Key? key}) : super(key: key);

  @override
  State<TvShowPopularPage> createState() => _TvShowPopularPageState();
}

class _TvShowPopularPageState extends State<TvShowPopularPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvShowPopularNotifier>(context, listen: false)
            .fetchPopularTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvShowPopularNotifier>(
          builder: (context, value, child) {
            if (value.popularTvShowsState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.popularTvShowsState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = value.popularTvShows[index];
                  return TvShowCard(
                    tvShow: tvShow,
                  );
                },
                itemCount: value.popularTvShows.length,
              );
            } else {
              return Center(
                key: Key('error_message'),
                child: Text(value.message),
              );
            }
          },
        ),
      ),
    );
  }
}
