import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:games_services/games_services.dart';
import 'package:normaldo_gaming/ui/widgets/bouncing_button.dart';

class TopPlayersList extends StatefulWidget {
  const TopPlayersList({super.key});

  @override
  State<TopPlayersList> createState() => _TopPlayersListState();
}

class _TopPlayersListState extends State<TopPlayersList> {
  _TopPlayersState state = _Initial();

  void _loadData() {
    state = _Loading();
    GameAuth.isSignedIn.then((loggedIn) async {
      if (loggedIn) {
        final users = await Leaderboards.loadLeaderboardScores(
          iOSLeaderboardID: 'main_leaderboard',
          androidLeaderboardID: 'CgkIkbL246cOEAIQAQ',
          scope: PlayerScope.global,
          timeScope: TimeScope.allTime,
          maxResults: 3,
        );
        setState(() {
          state = _Fetched(users ?? []);
        });
      }
    }).catchError((e) {
      setState(() {
        state = _Failed();
      });
    });
  }

  @override
  void initState() {
    super.initState();

    _loadData();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return switch (state) {
      _Initial() => const SizedBox.shrink(),
      _Loading() => const Center(
            child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation(Colors.white),
        )),
      _Failed() => Column(
          children: [
            Text('Error'.tr(), style: textTheme.displayMedium),
            const SizedBox(height: 8),
            BouncingButton(
              onPressed: () async {
                final users = await Leaderboards.loadLeaderboardScores(
                  iOSLeaderboardID: 'main_leaderboard',
                  androidLeaderboardID: 'CgkIkbL246cOEAIQAQ',
                  scope: PlayerScope.global,
                  timeScope: TimeScope.allTime,
                  maxResults: 10,
                );
                setState(() {
                  state = _Fetched(users ?? []);
                });
              },
              child: const Icon(
                Icons.replay,
                size: 24,
                color: Colors.white,
              ),
            )
          ],
        ),
      _Fetched() => _buildLeaders((state as _Fetched).scores),
    };
  }

  Widget _buildLeaders(List<LeaderboardScoreData> scores) {
    final textTheme = Theme.of(context).textTheme;
    return ListView.builder(
      itemCount: scores.length,
      itemBuilder: (context, index) {
        final score = scores[index];
        return Row(
          children: [
            Text(
              score.scoreHolder.displayName,
              style: textTheme.displaySmall,
            ),
            const Spacer(),
            Text(score.displayScore, style: textTheme.displayMedium)
          ],
        );
      },
    );
  }
}

sealed class _TopPlayersState {}

final class _Initial extends _TopPlayersState {}

final class _Failed extends _TopPlayersState {}

final class _Loading extends _TopPlayersState {}

final class _Fetched extends _TopPlayersState {
  final List<LeaderboardScoreData> scores;

  _Fetched(this.scores);
}
