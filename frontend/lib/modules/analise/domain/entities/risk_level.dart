/// Faixas oficiais de classificação de risco do Desperte Mulher.
///
/// LÓGICA DE NEGÓCIO PRESERVADA: 5 níveis, com tetos em 20/40/60/80/100%.
/// O enum carrega apenas o significado de domínio; rótulo e cor de UI ficam
/// em uma extension na camada de apresentação (separação de responsabilidades).
enum RiskLevel {
  muitoBaixo,
  baixo,
  moderado,
  alto,
  extremo;

  /// Mapeia um percentual (0..100) para a faixa correspondente.
  static RiskLevel fromPercent(double percent) {
    if (percent <= 20) return RiskLevel.muitoBaixo;
    if (percent <= 40) return RiskLevel.baixo;
    if (percent <= 60) return RiskLevel.moderado;
    if (percent <= 80) return RiskLevel.alto;
    return RiskLevel.extremo;
  }

  /// Rótulo textual oficial.
  String get label => switch (this) {
        RiskLevel.muitoBaixo => 'Muito Baixo',
        RiskLevel.baixo => 'Baixo',
        RiskLevel.moderado => 'Moderado',
        RiskLevel.alto => 'Alto',
        RiskLevel.extremo => 'Extremo',
      };

  /// Indica se a faixa exige encaminhamento prioritário/urgente.
  bool get isUrgent => this == RiskLevel.alto || this == RiskLevel.extremo;
}
