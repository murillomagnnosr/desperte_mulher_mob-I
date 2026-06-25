import 'package:desperte_mulher/modules/analise/domain/entities/risk_level.dart';
import 'package:flutter_test/flutter_test.dart';

/// Smoke test mínimo (a suíte completa entra na Etapa 15).
/// Valida a regra de negócio central: o mapeamento percentual -> faixa.
void main() {
  group('RiskLevel.fromPercent', () {
    test('classifica corretamente as 5 faixas oficiais', () {
      expect(RiskLevel.fromPercent(10), RiskLevel.muitoBaixo);
      expect(RiskLevel.fromPercent(20), RiskLevel.muitoBaixo);
      expect(RiskLevel.fromPercent(40), RiskLevel.baixo);
      expect(RiskLevel.fromPercent(60), RiskLevel.moderado);
      expect(RiskLevel.fromPercent(80), RiskLevel.alto);
      expect(RiskLevel.fromPercent(100), RiskLevel.extremo);
    });

    test('faixas altas são marcadas como urgentes', () {
      expect(RiskLevel.alto.isUrgent, isTrue);
      expect(RiskLevel.extremo.isUrgent, isTrue);
      expect(RiskLevel.baixo.isUrgent, isFalse);
    });
  });
}
