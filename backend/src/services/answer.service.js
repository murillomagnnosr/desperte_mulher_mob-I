import { questionRepository } from '../repositories/question.repository.js';
import { resultRepository } from '../repositories/result.repository.js';
import { AppError } from '../utils/AppError.js';

const CATEGORY_TITLES = {
  violencia: 'Histórico de violência',
  controle: 'Controle e isolamento',
  escalada: 'Escalada e acesso a armas',
  dependentes: 'Crianças e dependentes',
  apoio: 'Rede de apoio e condições',
};

// Tetos das 5 faixas oficiais (LÓGICA DE NEGÓCIO — não alterar).
const LEVELS = [
  [20, 'muitoBaixo'],
  [40, 'baixo'],
  [60, 'moderado'],
  [80, 'alto'],
];

function levelFor(percent) {
  for (const [max, level] of LEVELS) if (percent <= max) return level;
  return 'extremo';
}

function recommendationsFor(level) {
  const base = [
    'Você não está sozinha. Procure a rede de apoio quando se sentir segura.',
    'Em emergência, ligue 190 (Polícia) ou 180 (Central de Atendimento à Mulher).',
  ];
  if (level === 'alto' || level === 'extremo') {
    return [
      'Considere acionar imediatamente a rede de proteção.',
      'Procure a Casa da Mulher Brasileira ou a Ouvidoria da Mulher.',
      'Avalie solicitar uma Medida Protetiva de Urgência.',
      ...base,
    ];
  }
  return [
    'Mantenha-se informada e atenta aos sinais.',
    'Fortaleça sua rede de apoio (pessoas de confiança).',
    ...base,
  ];
}

const round1 = (n) => Math.round(n * 10) / 10;

export const answerService = {
  /**
   * Calcula o risco a partir das respostas e PERSISTE o resultado.
   * @param {{ answers: Record<string,string>, userId?: string }} input
   */
  async evaluate({ answers, userId }) {
    const questions = await questionRepository.findAllActive();
    const options = await questionRepository.findOptions();

    const optById = new Map(options.map((o) => [o.id, o]));
    const catByQuestion = new Map(questions.map((q) => [q.id, q.category]));

    // Pontuação máxima de cada pergunta (maior score entre as opções).
    const maxByQuestion = new Map();
    for (const o of options) {
      const s = Number(o.score);
      if (s > (maxByQuestion.get(o.question_id) ?? 0)) {
        maxByQuestion.set(o.question_id, s);
      }
    }

    const catMax = {};
    const catScore = {};
    for (const q of questions) {
      catMax[q.category] = (catMax[q.category] ?? 0) + (maxByQuestion.get(q.id) ?? 0);
      catScore[q.category] = catScore[q.category] ?? 0;
    }
    const totalMax = [...maxByQuestion.values()].reduce((a, b) => a + b, 0);

    let total = 0;
    const saved = [];
    for (const [questionId, optionId] of Object.entries(answers)) {
      const opt = optById.get(optionId);
      if (!opt || opt.question_id !== questionId) {
        throw new AppError('Resposta inválida para a pergunta informada.', 422);
      }
      const score = Number(opt.score);
      total += score;
      const cat = catByQuestion.get(questionId);
      if (cat) catScore[cat] += score;
      saved.push({ questionId, optionId, score });
    }

    const percent = totalMax === 0 ? 0 : round1((total / totalMax) * 100);
    const level = levelFor(percent);

    const categoryBreakdown = {};
    for (const cat of Object.keys(catMax)) {
      const pct = catMax[cat] === 0 ? 0 : round1((catScore[cat] / catMax[cat]) * 100);
      categoryBreakdown[CATEGORY_TITLES[cat] ?? cat] = pct;
    }

    const persisted = await resultRepository.save({
      userId,
      percent,
      level,
      answers: saved,
    });

    return {
      id: persisted.id,
      percent,
      level,
      categoryBreakdown,
      recommendations: recommendationsFor(level),
    };
  },
};
