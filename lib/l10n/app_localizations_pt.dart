// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Ecclesias360';

  @override
  String get homeWelcome => 'Bem-vindo ao Ecclesias360';

  @override
  String get comiteAjouterDecisionTitre => 'Adicionar uma decisão';

  @override
  String get comiteAjouterErratumBouton => 'Adicionar uma errata';

  @override
  String get comiteAjouterTacheBouton => 'Adicionar uma tarefa';

  @override
  String get comiteAjouterTacheTitre => 'Adicionar uma tarefa de acompanhamento';

  @override
  String get comiteAucunMembre => 'Nenhum membro nomeado.';

  @override
  String get comiteAucuneDecision => 'Nenhuma decisão.';

  @override
  String get comiteAucuneSeance => 'Nenhuma sessão registrada.';

  @override
  String get comiteBoutonNommer => 'Nomear';

  @override
  String get comiteChampAssigneA => 'Atribuída a';

  @override
  String get comiteChampBrouillonPv => 'Rascunho da ata';

  @override
  String get comiteChampDate => 'Data';

  @override
  String get comiteChampFonction => 'Função (ex. Pastor, Diácono)';

  @override
  String get comiteChampLibelle => 'Rótulo';

  @override
  String get comiteChampNouvelErratum => 'Nova errata';

  @override
  String get comiteChampOrdreDuJour => 'Ordem do dia';

  @override
  String get comiteChampPorteeDisciplinaire => 'Alcance disciplinar (Módulo X)';

  @override
  String get comiteChampResultatVote => 'Resultado da votação (ex. 5 a favor, 1 contra)';

  @override
  String get comiteCloreMandatTooltip => 'Encerrar o mandato';

  @override
  String get comiteDecisionsTitre => 'Decisões';

  @override
  String get comiteEnregistrerBrouillon => 'Salvar o rascunho';

  @override
  String get comiteEnregistrerSeance => 'Salvar a sessão';

  @override
  String get comiteErratumsTitre => 'Errata';

  @override
  String comiteMembreActif(String fonction, String date) => '$fonction — desde $date';

  @override
  String comiteMembreClos(String fonction) => '$fonction (mandato encerrado)';

  @override
  String get comiteMembresTitre => 'Membros do comitê';

  @override
  String get comiteNommerMembreTitre => 'Nomear um membro do comitê';

  @override
  String get comiteNommerMembreTooltip => 'Nomear um membro';

  @override
  String get comiteNouvelleSeanceTitre => 'Nova sessão';

  @override
  String get comitePresentsTitre => 'Presentes';

  @override
  String get comiteProcesVerbalTitre => 'Ata';

  @override
  String get comitePvValideEtImmuable => 'Esta ata está validada e é imutável.';

  @override
  String get comiteQuorumAtteint => 'Quórum atingido';

  @override
  String get comiteQuorumNonAtteint => 'Quórum não atingido';

  @override
  String get comiteQuorumNonConfigure => 'Quórum não configurado';

  @override
  String get comiteSeanceIntrouvableCorps => 'Esta sessão não existe (mais).';

  @override
  String get comiteSeanceTitre => 'Sessão';

  @override
  String get comiteSeancesTitre => 'Sessões do comitê';

  @override
  String get comiteTachesDeSuiviTitre => 'Tarefas de acompanhamento';

  @override
  String get comiteValiderPv => 'Validar (imutável)';

  @override
  String get commonAjouter => 'Adicionar';

  @override
  String get commonAnnuler => 'Cancelar';

  @override
  String get commonCreer => 'Criar';

  @override
  String get commonDescription => 'Descrição';

  @override
  String get commonEnregistrer => 'Salvar';

  @override
  String get commonFidele => 'Membro';

  @override
  String get commonOui => 'sim';

  @override
  String get dashboardModulesTitre => 'Módulos';

  @override
  String get fideleActionArchiver => 'Arquivar (RG-II-08)';

  @override
  String get fideleActionCompetences => 'Competências profissionais';

  @override
  String get fideleActionDons => 'Dons espirituais';

  @override
  String get fideleActionGroupes => 'Grupos da Igreja';

  @override
  String get fideleAjouterLienBouton => 'Adicionar um vínculo';

  @override
  String get fideleAjouterLienTitre => 'Adicionar um vínculo familiar';

  @override
  String get fideleAjouterTuteurBouton => 'Adicionar um tutor';

  @override
  String get fideleAjouterTuteurTitre => 'Adicionar um tutor (terceiro)';

  @override
  String get fideleChampAdresse => 'Endereço';

  @override
  String get fideleChampDateNaissance => 'Data de nascimento';

  @override
  String get fideleChampEmail => 'E-mail';

  @override
  String get fideleChampLienTuteur => 'Vínculo (ex. pai)';

  @override
  String get fideleChampMineur => 'Menor de idade';

  @override
  String get fideleChampNoeud => 'Nó de pertencimento';

  @override
  String get fideleChampNoeudErreur => 'Escolha um nó de pertencimento.';

  @override
  String get fideleChampNom => 'Sobrenome';

  @override
  String get fideleChampNomErreur => 'O sobrenome é obrigatório.';

  @override
  String get fideleChampNomTuteur => 'Nome do tutor';

  @override
  String get fideleChampPrenoms => 'Nomes';

  @override
  String get fideleChampPrenomsErreur => 'Os nomes são obrigatórios.';

  @override
  String get fideleChampSexe => 'Sexo';

  @override
  String get fideleChampSexeErreur => 'Escolha um sexo.';

  @override
  String get fideleChampStatutCivil => 'Estado civil';

  @override
  String get fideleChampStatutCivilErreur => 'Escolha um estado civil.';

  @override
  String get fideleChampTelephone => 'Telefone';

  @override
  String get fideleCheminementTitre => 'Caminhada espiritual';

  @override
  String fideleDateNaissanceValeur(String date) => 'Data de nascimento: $date';

  @override
  String get fideleHistoriqueAucune => 'Nenhuma alteração registrada.';

  @override
  String fideleHistoriqueTitre(String nom) => 'Histórico — $nom';

  @override
  String get fideleHistoriqueTooltip => 'Histórico de alterações';

  @override
  String get fideleIntrouvableCorps => 'Este membro não existe (mais).';

  @override
  String get fideleIntrouvableTitre => 'Membro não encontrado';

  @override
  String get fideleLiensFamiliauxTitre => 'Vínculos familiares';

  @override
  String get fideleModifierCoordonnees => 'Editar dados de contato';

  @override
  String get fideleStatutActuel => 'Status atual';

  @override
  String get fideleStatutDisciplineNote => 'Este status só pode ser alterado a partir do módulo Disciplina (RG-II-03).';

  @override
  String fideleTransitionVers(String cible) => '→ $cible';

  @override
  String get fideleTuteurLegalTitre => 'Tutor legal (RG-II-06)';

  @override
  String get fidelesAucun => 'Nenhum membro registrado.';

  @override
  String get fidelesCreerAction => 'Criar um membro';

  @override
  String get fidelesRechercherIndice => 'Buscar um membro (sobrenome ou nomes)';

  @override
  String get fidelesTitre => 'Membros';

  @override
  String get moduleDonsReferentiel => 'Referencial de dons espirituais';

  @override
  String get moduleGroupesEglise => 'Grupos da Igreja';

  @override
  String get moduleMandatsEcheance => 'Mandatos a vencer';

  @override
  String get moduleOrganisation => 'Organização';

  @override
  String get moduleProfessions => 'Grupos profissionais';

  @override
  String get moduleRoles => 'Papéis';

  @override
  String get moduleZonesGeographiques => 'Zonas geográficas';

  @override
  String get navAccueil => 'Início';

  @override
  String get parametresTitre => 'Configurações';
}
