# Etapa 1 — Engenharia Reversa do Site Atual

> Fonte: análise da aplicação pública em <https://despertemulher.org/> (páginas
> `/`, `/sobre`, `/analise`, `/login`). Objetivo: mapear o sistema existente
> **sem alterar a lógica de negócio**, apenas para fundamentar a reformulação.

## 1.1 Identidade e propósito

**Desperte Mulher — "Sua segurança importa".** Ferramenta gratuita e anônima de
**análise de risco para mulheres em situação de violência doméstica**, com foco
no estado do Tocantins (TO). Surgiu de um encontro (2024, Brasília) entre um
programador da Polícia Civil-TO e um agente federal especialista em análise de
risco. Parceiros: Polícia Federal, Polícia Civil-TO, Secretaria da Mulher,
OAB-TO (Comissão de Feminicídio), Casa da Mulher Brasileira, Lions Club, TO
Hosts, Universidade Católica do Tocantins.

> ⚠️ **Domínio sensível.** A reformulação preserva integralmente perguntas,
> pontuação, formulários e encaminhamentos. Muda-se forma, não conteúdo.

## 1.2 Páginas e rotas

| # | Rota | Página | Função |
|---|------|--------|--------|
| 1 | `/` | Início | Hero, garantias, "por que importa", níveis de risco, "o que avaliamos", contatos, parceiros |
| 2 | `/sobre` | Sobre | Origem, fundadores, parceiros |
| 3 | `/apoios` | Apoios e Parcerias | Logos e instituições |
| 4 | `/analise` | O que é a Análise de Risco | Metodologia + CTA "Iniciar avaliação gratuita" |
| 5 | `/observatorio` | Observatório | Observatório da Violência (dados) |
| 6 | `/termosuso` | Termos de Uso | Termos + porta de entrada da análise |
| 7 | `/login` | Login do Acolhe | Autenticação da área profissional |
| 8 | *(fluxo)* | Questionário de Risco | Perguntas de avaliação |
| 9 | *(fluxo)* | Resultado | Classificação % + encaminhamentos |
| 10 | *(modal)* | Denúncia Anônima | Formulário de denúncia |

## 1.3 Menu / Navegação

Início · Sobre · Apoios e Parcerias · O que é a Análise de Risco · Observatório ·
Termos de Uso · **Iniciar a Análise de Risco** (CTA) · **Login do Acolhe**.
Idiomas: PT-BR · ES · EN.

## 1.4 Formulários e campos

| Formulário | Campos | Botões |
|-----------|--------|--------|
| Denúncia Anônima | Tipo de violência (select), Município-TO (select), Endereço, Ponto de referência, Texto (textarea) | "Fechar sem enviar", "Enviar a Denúncia" |
| Análise de Risco | Perguntas por categoria → pontuação → % de risco | "Iniciar avaliação gratuita", navegação |
| Login do Acolhe | Usuário, Senha | "Entrar" |

## 1.5 Funcionalidades-núcleo (lógica preservada)

- **Questionário de risco** avaliando: histórico de violência física/psicológica/
  ameaças; controle financeiro, isolamento social e monitoramento; acesso a
  armas e escalada de comportamentos; vulnerabilidade de crianças e dependentes;
  rede de apoio e condições de moradia/renda.
- **Classificação:** Muito Baixo 20% · Baixo 40% · Moderado 60% · Alto 80% ·
  Extremo 100%.
- **Denúncia anônima**, **contatos de emergência** (180/190), **Login Acolhe**
  (área profissional da rede de apoio), **Observatório** (estatísticas),
  **multi-idioma**.

## 1.6 Mapeamento site → telas do novo app (Etapa 8)

| Tela (TCC) | Origem no site |
|-----------|----------------|
| HomePage | Início |
| SobrePage | Sobre |
| ProjetosPage | Apoios e Parcerias / Observatório |
| ContatoPage | Ouvidoria / Falar com a rede |
| PerguntasPage | Questionário de Análise de Risco |
| ResultadoPage | Resultado da análise |
| LoginPage / CadastroPage | Login do Acolhe / Cadastro na rede |
| PainelAdminPage / PerfilPage / ConfigPage | Área logada Acolhe |
