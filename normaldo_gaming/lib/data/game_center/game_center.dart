import 'package:games_services/games_services.dart';

enum Leaderboards { personal, totalGames, oneGame }

abstract interface class GameCenter {
  Future<String?> signIn();
  Future<void> signOut();
  Future<bool> isSignedIn();
  Future<String?> getPlayerId();
  Future<int?> getPlayerScore({required Leaderboards leaderboard});
  Future showAccessPoint();
  Future hideAccessPoint();
}

class GameCenterImpl implements GameCenter {
  @override
  Future<String?> signIn() {
    return GameAuth.signIn();
  }

  @override
  Future<void> signOut() {
    return GameAuth.signOut();
  }

  @override
  Future<bool> isSignedIn() {
    return GameAuth.isSignedIn;
  }

  @override
  Future<String?> getPlayerId() {
    return Player.getPlayerID();
  }

  @override
  Future<int?> getPlayerScore({required Leaderboards leaderboard}) {
    return Player.getPlayerScore(
      iOSLeaderboardID: leaderboard.name,
      androidLeaderboardID: leaderboard.name,
    );
  }

  @override
  Future showAccessPoint() {
    return Player.showAccessPoint(AccessPointLocation.topLeading);
  }

  @override
  Future hideAccessPoint() {
    return Player.hideAccessPoint();
  }
}
