class QnaModel {
  final String question;
  final String simAnswer;
  final String fullAnswer;

  const QnaModel(this.question, this.simAnswer, this.fullAnswer);

  factory QnaModel.fromJson(Map<String, dynamic> json) {
    return QnaModel(
      json['question'] as String,
      json['simAnswer'] as String,
      json['fullAnswer'] as String,
    );
  }
}
