/// Textos fixos da aplicação (pt-BR), centralizados.
///
/// Mantém a redação ORIGINAL do site Desperte Mulher onde aplicável — a
/// regra do projeto é preservar a lógica e o conteúdo de negócio, mudando
/// apenas a forma. Centralizar strings também é o primeiro passo para a
/// internacionalização (PT/ES/EN), prevista no site original.
abstract final class AppStrings {
  AppStrings._();

  // Identidade
  static const String appName = 'Desperte Mulher';
  static const String tagline = 'Sua segurança importa';
  static const String heroTitle =
      'Conhecimento é o primeiro passo para a liberdade!';

  // Garantias (selos de confiança)
  static const String seloAnonimato = '100% Anonimato';
  static const String seloGratuito = 'Gratuito e sem cadastro';
  static const String seloCientifico = 'Baseado em metodologia científica';
  static const String seloSuporte = 'Suporte 24h disponível';

  // CTAs
  static const String ctaEntenderRisco = 'Quero entender meu risco';
  static const String ctaComoFunciona = 'Como funciona?';
  static const String ctaIniciarAnalise = 'Iniciar a Análise de Risco';
  static const String ctaAvaliacaoGratuita = 'Iniciar avaliação gratuita';
  static const String ctaDenunciaAnonima = 'Denúncia Anônima';
  static const String ctaFacaParteRede = 'Faça Parte da Rede';
  static const String ctaMedidaProtetiva = 'Pedido de Medida Protetiva';
  static const String ctaObservatorio = 'Observatório da Violência';
  static const String ctaFalarOuvidoria = 'Falar com a Ouvidoria da Mulher';
  static const String ctaFalarRede = 'Falar com alguém da rede';
  static const String ctaFalarCasaMulher = 'Falar com a Casa da Mulher Brasileira';

  // "Por que é importante"
  static const List<String> porQueImporta = [
    'Identifica padrões invisíveis',
    'Apoia decisões seguras',
    'Agiliza o acesso à ajuda',
    'Protege seus filhos',
    'Você decide o ritmo',
    'Reconhece sua força',
  ];

  // "O que avaliamos"
  static const List<String> oQueAvaliamos = [
    'Histórico de violência física, psicológica e ameaças',
    'Controle financeiro, isolamento social e monitoramento',
    'Acesso a armas e escalada de comportamentos',
    'Situação de vulnerabilidade de crianças e dependentes',
    'Rede de apoio e condições de moradia e renda',
  ];

  // Contatos de emergência
  static const String tel180 = '180';
  static const String tel190 = '190';
  static const String telOuvidoria = '(63) 99282-0574';
  static const String telCasaMulher = '(63) 3212-7496';
  static const String emailContato = 'despertemulher.org@gmail.com';

  // Denúncia anônima
  static const String denunciaFechar = 'Fechar sem enviar';
  static const String denunciaEnviar = 'Enviar a Denúncia';

  // Genéricos
  static const String entrar = 'Entrar';
  static const String sair = 'Sair';
  static const String continuar = 'Continuar';
  static const String voltar = 'Voltar';
  static const String tentarNovamente = 'Tentar novamente';
  static const String carregando = 'Carregando...';
  static const String erroGenerico =
      'Algo deu errado. Por favor, tente novamente.';
}
