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
  String get archivageAucunDansCorbeille => 'Lixeira vazia.';

  @override
  String get archivageAucunDocument => 'Nenhum documento arquivado.';

  @override
  String get archivageBibliothequeTitre => 'Documentos arquivados';

  @override
  String get archivageChampReferenceFichier =>
      'Referência do arquivo (nome, link...)';

  @override
  String get archivageCorbeilleTitre => 'Lixeira';

  @override
  String get archivageDetailTitre => 'Documento arquivado';

  @override
  String get archivageDocumentIntrouvable =>
      'Este documento não foi encontrado (ou foi expurgado).';

  @override
  String get archivageMettreEnCorbeilleBouton => 'Mover para a lixeira';

  @override
  String archivageMiseCorbeilleLe(String date) {
    return 'Movido para a lixeira em $date';
  }

  @override
  String get archivageNiveauRestreint => 'Restrito';

  @override
  String get archivageNiveauStandard => 'Padrão';

  @override
  String get archivageNouvelleVersionBouton => 'Nova versão';

  @override
  String get archivageNouvelleVersionTitre => 'Adicionar uma nova versão';

  @override
  String get archivageOrigineLabel => 'Origem';

  @override
  String archivagePurgeableApres(String date) {
    return 'Expurgável a partir de $date';
  }

  @override
  String get archivagePurgerBouton => 'Expurgar definitivamente';

  @override
  String get archivagePurgerConfirmationMessage =>
      'Esta ação é irreversível: o documento e todas as suas versões serão excluídos.';

  @override
  String get archivagePurgerConfirmationTitre =>
      'Expurgar definitivamente este documento?';

  @override
  String get archivageRechercheLabel => 'Pesquisar um documento (número, tipo)';

  @override
  String get archivageRestaurerBouton => 'Restaurar';

  @override
  String archivageVersionLabel(int numero) {
    return 'Versão $numero';
  }

  @override
  String get archivageVersionsTitre => 'Histórico de versões';

  @override
  String get deplacementsAucunDeplacement => 'Nenhuma mutação registrada.';

  @override
  String get deplacementsAucuneMutation => 'Nenhuma mutação.';

  @override
  String get deplacementsChampFidele => 'Membro';

  @override
  String get deplacementsChampMotif => 'Motivo';

  @override
  String get deplacementsChampMotifRefus => 'Motivo da recusa (opcional)';

  @override
  String get deplacementsChampNoeudDestination => 'Igreja de destino';

  @override
  String get deplacementsCoteDestinationLabel => 'Igreja de destino';

  @override
  String get deplacementsCoteOrigineLabel => 'Igreja de origem';

  @override
  String get deplacementsDateDemandeLabel => 'Solicitada em';

  @override
  String get deplacementsDateValidationLabel => 'Aprovada em';

  @override
  String get deplacementsDemanderTitre => 'Solicitar uma mutação';

  @override
  String get deplacementsDetailTitre => 'Mutação';

  @override
  String get deplacementsHistoriqueTitre => 'Histórico de mutações';

  @override
  String get deplacementsIntrouvable => 'Esta mutação não foi encontrada.';

  @override
  String get deplacementsMotifLabel => 'Motivo';

  @override
  String get deplacementsRefuserBouton => 'Recusar';

  @override
  String get deplacementsRefuserTitre => 'Recusar esta mutação?';

  @override
  String get deplacementsStatutEnAttente => 'Pendente';

  @override
  String get deplacementsStatutRefusee => 'Recusada';

  @override
  String get deplacementsStatutValidee => 'Aprovada';

  @override
  String get deplacementsTitre => 'Mutações';

  @override
  String get deplacementsValiderDestinationBouton => 'Aprovar (destino)';

  @override
  String get deplacementsValiderOrigineBouton => 'Aprovar (origem)';

  @override
  String get deplacementsVoirLettreBouton => 'Ver carta de recomendação';

  @override
  String get comiteAjouterDecisionTitre => 'Adicionar uma decisão';

  @override
  String get comiteAjouterErratumBouton => 'Adicionar uma errata';

  @override
  String get comiteAjouterTacheBouton => 'Adicionar uma tarefa';

  @override
  String get comiteAjouterTacheTitre =>
      'Adicionar uma tarefa de acompanhamento';

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
  String get comiteChampResultatVote =>
      'Resultado da votação (ex. 5 a favor, 1 contra)';

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
  String comiteMembreActif(String fonction, String date) {
    return '$fonction — desde $date';
  }

  @override
  String comiteMembreClos(String fonction) {
    return '$fonction (mandato encerrado)';
  }

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
  String get culteAjouterSequenceBouton => 'Adicionar uma sequência';

  @override
  String get culteAjouterSequenceTitre => 'Adicionar uma sequência';

  @override
  String get culteAucunPredicateur => 'Nenhum';

  @override
  String get culteAucuneSequence => 'Nenhuma sequência.';

  @override
  String get culteChampAudioUrl => 'Link de áudio';

  @override
  String get culteChampCompteGlobal => 'Contagem global de presença';

  @override
  String get culteChampDateHeure => 'Data e hora';

  @override
  String get culteChampDureeMinutes => 'Duração prevista (minutos)';

  @override
  String get culteChampLibelleSequence => 'Título (ex. Louvor, Pregação)';

  @override
  String get culteChampModePresence => 'Modo de presença';

  @override
  String get culteChampNombreOccurrences => 'Número de ocorrências';

  @override
  String get culteChampOrdre => 'Ordem';

  @override
  String get culteChampPdfUrl => 'Link do PDF';

  @override
  String get culteChampPredicateur => 'Pregador (opcional)';

  @override
  String get culteChampRecurrent => 'Criar uma série recorrente (semanal)';

  @override
  String get culteChampResponsable => 'Responsável (opcional)';

  @override
  String get culteChampTexteBiblique => 'Texto bíblico';

  @override
  String get culteChampTheme => 'Tema (opcional)';

  @override
  String get culteChampType => 'Tipo de culto (ex. Culto dominical)';

  @override
  String get culteChampTypeErreur => 'O tipo de culto é obrigatório.';

  @override
  String get culteChampVideoUrl => 'Link de vídeo';

  @override
  String get culteDateHeureChoisir => 'Escolher a data e a hora';

  @override
  String get culteEnregistrerCompte => 'Salvar a contagem';

  @override
  String get culteLiturgieTitre => 'Liturgia';

  @override
  String get culteModePresenceGlobal => 'Global (contagem total)';

  @override
  String get culteModePresenceNominal => 'Nominal (por membro)';

  @override
  String get culteNonPublie => 'Nenhuma publicação para este culto.';

  @override
  String get cultePresencesTitre => 'Presenças';

  @override
  String get cultePublicationTitre => 'Publicação pós-culto';

  @override
  String cultePublieLe(String date) {
    return 'Publicado em $date';
  }

  @override
  String get cultePublierBouton => 'Publicar';

  @override
  String get culteStatutTitre => 'Status';

  @override
  String get cultesAucun => 'Nenhum culto registrado.';

  @override
  String get cultesNouveauTooltip => 'Novo culto';

  @override
  String get cultesTitre => 'Cultos';

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
  String fideleDateNaissanceValeur(String date) {
    return 'Data de nascimento: $date';
  }

  @override
  String get fideleHistoriqueAucune => 'Nenhuma alteração registrada.';

  @override
  String fideleHistoriqueTitre(String nom) {
    return 'Histórico — $nom';
  }

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
  String get fideleStatutDisciplineNote =>
      'Este status só pode ser alterado a partir do módulo Disciplina (RG-II-03).';

  @override
  String fideleTransitionVers(String cible) {
    return '→ $cible';
  }

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

  @override
  String get propositionChampExplication => 'Breve explicação (opcional)';

  @override
  String get propositionChampTitre => 'Título';

  @override
  String get propositionSoumettreTitre => 'Enviar uma proposta de tema';

  @override
  String get propositionSoumettreTooltip => 'Enviar uma proposta';

  @override
  String get propositionsAucune => 'Nenhuma proposta enviada.';

  @override
  String get propositionsThemeTitre => 'Propostas de tema';

  @override
  String get propositionsVoterEnTantQue => 'Votar/enviar como';

  @override
  String get disciplineTitre => 'Processos disciplinares';

  @override
  String get disciplineHistoriqueTitre => 'Histórico disciplinar confidencial';

  @override
  String get disciplineAucunDossier => 'Nenhum processo disciplinar.';

  @override
  String get disciplineAucunDossierFidele =>
      'Nenhum processo disciplinar para este membro.';

  @override
  String get disciplineOuvrirTooltip => 'Abrir um processo';

  @override
  String get disciplineOuvrirTitre => 'Abrir um processo disciplinar';

  @override
  String get disciplineChampFideleMisEnCause => 'Membro implicado';

  @override
  String get disciplineChampNatureFaute => 'Natureza da falta';

  @override
  String get disciplineChampRoleActeur => 'Papel atuante';

  @override
  String get disciplineChampActeur =>
      'Aberto por (opcional — membro da comissão)';

  @override
  String get disciplineActeurAucun => 'Nenhum';

  @override
  String get disciplineStatutEnInstruction => 'Em instrução';

  @override
  String get disciplineStatutSanctionne => 'Sancionado';

  @override
  String get disciplineStatutClos => 'Encerrado';

  @override
  String disciplineAlerteFinDePeriode(String date) {
    return 'Reintegração prevista para $date';
  }

  @override
  String get disciplineAlerteRevuePeriodique => 'Revisão periódica necessária';

  @override
  String get disciplineDetailTitre => 'Processo disciplinar';

  @override
  String get disciplineIntrouvable =>
      'Este processo disciplinar não foi encontrado.';

  @override
  String disciplineOuvertLe(String date) {
    return 'Aberto em $date';
  }

  @override
  String get disciplineCommissionTitre => 'Comissão instrutora';

  @override
  String get disciplineCommissionAucune => 'Nenhuma comissão atribuída.';

  @override
  String get disciplineCommissionAssignerBouton => 'Atribuir uma comissão';

  @override
  String get disciplineCommissionAssignerTitre => 'Atribuir uma comissão';

  @override
  String get disciplineCommissionCreerBouton => 'Criar uma nova comissão';

  @override
  String get disciplineCommissionCreerTitre => 'Criar uma comissão';

  @override
  String get disciplineChampNomCommission => 'Nome da comissão';

  @override
  String get disciplineCommissionMembresTitre => 'Membros da comissão';

  @override
  String get disciplineCommissionAjouterMembreTooltip => 'Adicionar um membro';

  @override
  String get disciplinePiecesTitre => 'Documentos do processo';

  @override
  String get disciplinePiecesAucune => 'Nenhum documento apresentado.';

  @override
  String get disciplinePieceAjouterTooltip => 'Adicionar um documento';

  @override
  String get disciplinePieceAjouterTitre => 'Adicionar um documento';

  @override
  String get disciplinePieceChampNature => 'Tipo de documento';

  @override
  String get disciplinePieceNatureTemoignage => 'Testemunho';

  @override
  String get disciplinePieceNaturePreuve => 'Prova';

  @override
  String get disciplinePieceChampContenu => 'Conteúdo (texto)';

  @override
  String get disciplineDecisionTitre => 'Decisão';

  @override
  String get disciplineChampDecision => 'Decisão fundamentada';

  @override
  String get disciplineChampDureeSanction =>
      'Duração da sanção em dias (vazio = indeterminada)';

  @override
  String get disciplineChampSuspendreMinisteres =>
      'Suspender as atribuições ministeriais ativas';

  @override
  String get disciplinePrononcerBouton => 'Emitir a decisão';

  @override
  String disciplineDecisionRendueLe(String date) {
    return 'Decisão emitida em $date';
  }

  @override
  String get disciplineCloturerBouton => 'Encerrar / Reintegrar';

  @override
  String get disciplineDossierClosNote =>
      'Processo encerrado — o membro recuperou seu estatuto anterior.';

  @override
  String get disciplineDureeIndeterminee => 'Duração indeterminada';

  @override
  String disciplineDureeJours(int jours) {
    return '$jours dia(s)';
  }
}
