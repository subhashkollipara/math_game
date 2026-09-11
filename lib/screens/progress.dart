import 'package:shared_preferences/shared_preferences.dart';

class GameProgress {
  int additionLevel = 1;
  int subtractionLevel = 0;
  int multiplicationLevel = 0;
  int divisionLevel = 0;

  bool get additionUnlocked => additionLevel > 0;
  bool get subtractionUnlocked => subtractionLevel > 0;
  bool get multiplicationUnlocked => multiplicationLevel > 0;
  bool get divisionUnlocked => divisionLevel > 0;

  Future<void> loadProgress() async {
    final prefs = await SharedPreferences.getInstance();

    additionLevel = prefs.getInt('additionLevel') ?? 1;
    subtractionLevel = prefs.getInt('subtractionLevel') ?? 0;
    multiplicationLevel = prefs.getInt('multiplicationLevel') ?? 0;
    divisionLevel = prefs.getInt('divisionLevel') ?? 0;
  }

  Future<void> saveProgress() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setInt('additionLevel', additionLevel);
    await prefs.setInt('subtractionLevel', subtractionLevel);
    await prefs.setInt('multiplicationLevel', multiplicationLevel);
    await prefs.setInt('divisionLevel', divisionLevel);
  }
}

final gameProgress = GameProgress();