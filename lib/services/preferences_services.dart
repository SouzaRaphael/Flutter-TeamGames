import 'dart:convert';

import 'package:persistencia_local/models/time.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _favoriteTeam = 'favorite_team';

  final SharedPreferencesAsync _preferences = SharedPreferencesAsync();

  Future<Time?> getFavoriteTeam() async {
    String favorite_team = await _preferences.getString(_favoriteTeam) ?? '';

    if (favorite_team.isNotEmpty) {
      return Time.fromJson(jsonDecode(favorite_team));
    }
    
    return null;
  }

  Future<void> saveFavoriteTeam(Time time) async {
    await _preferences.setString(_favoriteTeam, jsonEncode(time.toJson()));
  }
}