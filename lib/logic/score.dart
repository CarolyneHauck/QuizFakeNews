class LogicScoreQuiz {
  int _score = 0;
  int get score => _score;

  void incrementScore(int points) {
    _score += points;
  }

  void decreaseScore(int points) {
    _score -= points;
  }

  int totalScore() {
    return _score;
  }

  void resetScore() {
    _score = 0;
  }
}
