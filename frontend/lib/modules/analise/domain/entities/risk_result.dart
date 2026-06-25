import 'package:equatable/equatable.dart';

import 'risk_level.dart';

/// Resultado da análise de risco.
///
/// Contém o percentual normalizado (0..100), a faixa, a contribuição por
/// categoria e os encaminhamentos sugeridos (rede de apoio). Imutável.
class RiskResult extends Equatable {
  const RiskResult({
    required this.percent,
    required this.level,
    required this.categoryBreakdown,
    required this.recommendations,
  });

  final double percent;
  final RiskLevel level;

  /// Percentual de risco por categoria (para explicar o resultado).
  final Map<String, double> categoryBreakdown;

  /// Encaminhamentos sugeridos conforme a faixa.
  final List<String> recommendations;

  @override
  List<Object?> get props =>
      [percent, level, categoryBreakdown, recommendations];
}
