enum Difficulty {
  easy, medium, hard
}

enum AnswerOption {
  A, B, C, D
}

class Question {
  final AnswerOption correctAnswer;
  final String problemImageURL;
  final String answerImageURL;

  const Question({
    required this.correctAnswer,
    required this.problemImageURL,
    required this.answerImageURL,
  });

  Question.name(this.correctAnswer, this.problemImageURL, this.answerImageURL);

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      correctAnswer: json['correctAnswer'],
      problemImageURL: json['problemImageURL'],
      answerImageURL: json['answerImageURL'],
    );
  }
}