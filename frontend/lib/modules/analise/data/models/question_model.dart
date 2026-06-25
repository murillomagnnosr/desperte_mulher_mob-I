import '../../domain/entities/question.dart';

/// DTO de [AnswerOption] — (de)serialização JSON da API.
class AnswerOptionModel extends AnswerOption {
  const AnswerOptionModel({
    required super.id,
    required super.label,
    required super.score,
  });

  factory AnswerOptionModel.fromJson(Map<String, dynamic> json) {
    return AnswerOptionModel(
      id: json['id'] as String,
      label: json['label'] as String,
      score: (json['score'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() => {'id': id, 'label': label, 'score': score};
}

/// DTO de [Question] — converte o JSON da API em entidade de domínio.
///
/// Mantemos Model separado da Entity (Clean Architecture): mudanças no
/// contrato da API não vazam para o domínio nem para a UI.
class QuestionModel extends Question {
  const QuestionModel({
    required super.id,
    required super.category,
    required super.text,
    required super.options,
  });

  factory QuestionModel.fromJson(Map<String, dynamic> json) {
    return QuestionModel(
      id: json['id'] as String,
      category: RiskCategory.values.byName(json['category'] as String),
      text: json['text'] as String,
      options: (json['options'] as List<dynamic>)
          .map((e) => AnswerOptionModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'category': category.name,
        'text': text,
        'options': options
            .map((o) => AnswerOptionModel(id: o.id, label: o.label, score: o.score)
                .toJson(),)
            .toList(),
      };
}
