class QnaModel {

  const QnaModel(this.question, this.simAnswer, this.fullAnswer);

  factory QnaModel.fromJson(final Map<String, dynamic> json) => QnaModel(
      json['question'] as String,
      json['simAnswer'] as String,
      json['fullAnswer'] as String,
    );
  final String question;
  final String simAnswer;
  final String fullAnswer;
}
