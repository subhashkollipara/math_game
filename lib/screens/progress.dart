class GameProgress {
  int additionLevel = 1;
  int subtractionLevel = 0;
  int multiplicationLevel = 0;
  int divisionLevel = 0;

  bool get additionUnlocked => additionLevel > 0;

  bool get subtractionUnlocked => subtractionLevel > 0;

  bool get multiplicationUnlocked => multiplicationLevel > 0;

  bool get divisionUnlocked => divisionLevel > 0;
}

// One shared progress object for the whole app
final gameProgress = GameProgress();