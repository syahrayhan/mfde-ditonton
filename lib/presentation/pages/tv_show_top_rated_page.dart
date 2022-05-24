import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/presentation/provider/tv_show_top_rated_notifier.dart';
import 'package:ditonton/presentation/widgets/tv_show_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvShowTopRatedPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-show-top-rated';
  const TvShowTopRatedPage({Key? key}) : super(key: key);

  @override
  State<TvShowTopRatedPage> createState() => _TvShowTopRatedPageState();
}

class _TvShowTopRatedPageState extends State<TvShowTopRatedPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<TvShowTopRatedNotifier>(context, listen: false)
            .fetchTopRatedTvShows());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated TV Shows'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<TvShowTopRatedNotifier>(
          builder: (context, value, child) {
            if (value.topRatedTvShowsState == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (value.topRatedTvShowsState == RequestState.Loaded) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  final tvShow = value.topRatedTvShows[index];
                  return TvShowCard(
                    tvShow: tvShow,
                  );
                },
                itemCount: value.topRatedTvShows.length,
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
