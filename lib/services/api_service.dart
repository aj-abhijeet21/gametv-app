import 'dart:convert';

import 'package:gametv_app/models/tournament.dart';
import 'package:gametv_app/models/user.dart';

import 'package:http/http.dart' as http;

enum AuthStatus {
  authenticated,
  unknown,
  unauthenticated,
}

class ApiService {
  String cursor = '';

  Future<List<Tournament>> getTournaments() async {
    String uri =
        'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all';
    var url = Uri.parse(uri);
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    cursor = jsonData['data']['cursor'];
    List data = jsonData['data']['tournaments'] as List;

    List<Tournament> list = [];

    data.forEach((tournament) {
      list.add(Tournament.fromJson(tournament));
    });

    print(list.length);
    return list;
  }

  Future<List<Tournament>> getMoreTournaments() async {
    print('inside load more');
    print('cursor: $cursor');
    String uri =
        'http://tournaments-dot-game-tv-prod.uc.r.appspot.com/tournament/api/tournaments_list_v2?limit=10&status=all&cursor=$cursor=';
    var url = Uri.parse(uri);
    var response = await http.get(url);
    var jsonData = jsonDecode(response.body);

    List data = jsonData['data']['tournaments'] as List;

    List<Tournament> list = [];

    data.forEach((tournament) {
      list.add(Tournament.fromJson(tournament));
    });

    print(list.length);
    return list;
  }

  Future<UserDetails> getUserDetails(String user) async {
    String uri = 'https://gametv.free.beeceptor.com/userdetails?user=$user';
    var url = Uri.parse(uri);
    UserDetails userDetails;
    try {
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      userDetails = UserDetails.fromJson(jsonData);
      return userDetails;
    } on Exception catch (e) {
      // TODO
      print(e);
    }
    return UserDetails(
      imgUrl: '',
      name: '',
      percentage: '0',
      played: '0',
      rating: '0',
      won: '0',
    );
  }

  Future<AuthStatus> logIn({
    required String username,
    required String password,
  }) async {
    String status = '';
    String uri =
        'https://gametv.free.beeceptor.com/auth?user=$username&pass=$password';
    var url = Uri.parse(uri);
    try {
      var response = await http.get(url);
      var jsonData = jsonDecode(response.body);
      print(jsonData);
      status = jsonData['status'];
    } on Exception catch (e) {
      // TODO
      print(e);
    }

    if (status == 'success') {
      return AuthStatus.authenticated;
    } else {
      return AuthStatus.unknown;
    }
  }
}
