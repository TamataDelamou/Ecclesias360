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
  String get disciplineAccesReserve =>
      'Acesso reservado a um pastor ou a um membro da comissão disciplinar.';

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

  @override
  String get financesTitre => 'Contribuições';

  @override
  String get financesHistoriqueTitre => 'Histórico de contribuições';

  @override
  String get financesAucuneContribution => 'Nenhuma contribuição registrada.';

  @override
  String get financesAucuneContributionFidele =>
      'Nenhuma contribuição para este membro.';

  @override
  String get financesSaisirTooltip => 'Registrar uma oferta';

  @override
  String get financesSaisirTitre => 'Registrar uma oferta';

  @override
  String get financesChampDonateur => 'Doador';

  @override
  String get financesDonateurAnonyme => 'Doador anônimo';

  @override
  String get financesChampLibelleDonateurAnonyme =>
      'Rótulo do doador anônimo (opcional)';

  @override
  String get financesChampTypeOffrande => 'Tipo de oferta';

  @override
  String get financesChampMontant => 'Valor';

  @override
  String get financesChampModePaiement => 'Forma de pagamento';

  @override
  String get financesModePaiementEspeces => 'Dinheiro';

  @override
  String get financesModePaiementMobileMoney => 'Dinheiro móvel';

  @override
  String get financesModePaiementVirement => 'Transferência bancária';

  @override
  String get financesSaisirBouton => 'Registrar';

  @override
  String get financesRapportParTypeTitre => 'Detalhamento por tipo de oferta';

  @override
  String get financesStatutEnAttente => 'Pendente';

  @override
  String get financesStatutValidee => 'Validada';

  @override
  String get financesStatutRejetee => 'Rejeitada';

  @override
  String get financesTresoriersTitre => 'Tesoureiros designados';

  @override
  String get financesTresoriersAucun => 'Nenhum tesoureiro designado.';

  @override
  String get financesTresorierDesignerTitre => 'Designar um tesoureiro';

  @override
  String get financesTresorierDesignerBouton => 'Designar';

  @override
  String get financesTresorierDesignerTooltip => 'Designar um tesoureiro';

  @override
  String financesTresorierDepuis(String date) {
    return 'Tesoureiro desde $date';
  }

  @override
  String get financesTresorierRetirerTooltip => 'Remover designação';

  @override
  String get financesRecuTitre => 'Recibo de contribuição';

  @override
  String get financesIntrouvable => 'Esta contribuição não foi encontrada.';

  @override
  String get financesValiderTitre => 'Validar a contribuição';

  @override
  String get financesChampRoleActeur => 'Função atuante';

  @override
  String get financesChampValidePar => 'Validado por';

  @override
  String get financesValiderBouton => 'Validar';

  @override
  String get financesRejeterTitre => 'Rejeitar a contribuição';

  @override
  String get financesChampMotif => 'Motivo';

  @override
  String get financesRejeterBouton => 'Rejeitar';

  @override
  String get financesContrePasserTitre => 'Estornar a contribuição';

  @override
  String get financesContrePasserBouton => 'Estornar';

  @override
  String financesSaisieLe(String date) {
    return 'Registrada em $date';
  }

  @override
  String financesValideeLe(String date) {
    return 'Validada em $date';
  }

  @override
  String get financesEstContrePassation => 'Esta contribuição é um estorno.';

  @override
  String get financesProjetsTitre => 'Projetos';

  @override
  String get financesProjetsAucun => 'Nenhum projeto.';

  @override
  String get financesProjetCreerTitre => 'Criar um projeto';

  @override
  String get financesProjetCreerTooltip => 'Criar um projeto';

  @override
  String get financesChampNomProjet => 'Nome do projeto';

  @override
  String get financesChampBudgetPrevisionnel => 'Orçamento previsto';

  @override
  String financesProjetSoldeSurBudget(int solde, int budget, String devise) {
    return 'Saldo: $solde $devise / orçamento $budget $devise';
  }

  @override
  String get financesProjetDetailTitre => 'Ficha do projeto';

  @override
  String get financesProjetIntrouvable => 'Este projeto não foi encontrado.';

  @override
  String get financesDepenseAjouterTitre => 'Adicionar uma despesa';

  @override
  String get financesDepenseAjouterBouton => 'Adicionar uma despesa';

  @override
  String get financesChampLibelleDepense => 'Rótulo da despesa';

  @override
  String get financesChampDerogationTracee =>
      'Exceção registrada (excede o saldo disponível)';

  @override
  String get financesDepensesTitre => 'Despesas';

  @override
  String get financesDepensesAucune => 'Nenhuma despesa registrada.';

  @override
  String financesDepenseDerogation(String date) {
    return '$date — exceção registrada';
  }

  @override
  String get financesEngagementsTitre => 'Compromissos e vencimentos';

  @override
  String get financesEngagementsAucun => 'Nenhum compromisso.';

  @override
  String get financesEngagementCreerTitre => 'Criar um compromisso';

  @override
  String get financesEngagementCreerTooltip => 'Criar um compromisso';

  @override
  String get financesChampTypeEngagement => 'Tipo de compromisso';

  @override
  String get financesTypeEngagementDime => 'Dízimo';

  @override
  String get financesTypeEngagementPromesseDon => 'Promessa de doação';

  @override
  String get financesChampMontantPrevu => 'Valor previsto';

  @override
  String get financesChampPeriodicite => 'Periodicidade';

  @override
  String get financesPeriodiciteHebdomadaire => 'Semanal';

  @override
  String get financesPeriodiciteMensuelle => 'Mensal';

  @override
  String get financesPeriodiciteTrimestrielle => 'Trimestral';

  @override
  String get financesPeriodiciteAnnuelle => 'Anual';

  @override
  String financesEngagementPeriodicite(String periodicite) {
    return 'Periodicidade: $periodicite';
  }

  @override
  String get financesEcheanceEnAttente => 'Pendente';

  @override
  String get financesEcheanceHonoree => 'Cumprida';

  @override
  String get financesEcheanceEnRetard => 'Atrasada';

  @override
  String get financesEcheanceHonorerBouton => 'Cumprir';

  @override
  String get patrimoineTitre => 'Bens';

  @override
  String get patrimoineCampagnesTitre => 'Campanhas de inventário';

  @override
  String get patrimoineAjouterTooltip => 'Adicionar um bem';

  @override
  String get patrimoineAucunBien => 'Nenhum bem registrado.';

  @override
  String get patrimoineAlerteSeuilTitre =>
      'Bens abaixo do limite de alerta de estoque';

  @override
  String get patrimoineAjouterTitre => 'Adicionar um bem';

  @override
  String get patrimoineChampIdInventaire => 'Identificador de inventário';

  @override
  String get patrimoineChampCategorie => 'Categoria';

  @override
  String get patrimoineChampDesignation => 'Designação';

  @override
  String get patrimoineChampValeurAcquisition => 'Valor de aquisição';

  @override
  String get patrimoineChampValeurVenale => 'Valor de mercado';

  @override
  String get patrimoineChampDateAcquisition => 'Data de aquisição';

  @override
  String get patrimoineChampSeuilAlerteStock => 'Limite de alerta de estoque';

  @override
  String get patrimoineEtatNeuf => 'Novo';

  @override
  String get patrimoineEtatBon => 'Bom';

  @override
  String get patrimoineEtatAReparer => 'A reparar';

  @override
  String get patrimoineEtatHorsService => 'Fora de serviço';

  @override
  String get patrimoineEtatCede => 'Cedido';

  @override
  String get patrimoineFicheTitre => 'Ficha do bem';

  @override
  String get patrimoineIntrouvable => 'Bem não encontrado.';

  @override
  String get patrimoineSignalerEtatTitre => 'Relatar o estado do bem';

  @override
  String get patrimoineChampEtat => 'Estado';

  @override
  String get patrimoineSignalerEtatBouton => 'Relatar estado';

  @override
  String get patrimoineSortirTitre => 'Retirar o bem do patrimônio';

  @override
  String get patrimoineChampTypeSortie => 'Tipo de saída';

  @override
  String get patrimoineTypeSortieCession => 'Cessão';

  @override
  String get patrimoineTypeSortieDon => 'Doação';

  @override
  String get patrimoineTypeSortieMiseAuRebut => 'Descarte';

  @override
  String get patrimoineChampRoleActeur => 'Função do ator';

  @override
  String get patrimoineChampValidePar => 'Validado por';

  @override
  String get patrimoineChampMotif => 'Motivo';

  @override
  String get patrimoineSortirBouton => 'Retirar o bem';

  @override
  String get patrimoineReserverTitre => 'Reservar o bem';

  @override
  String get patrimoineChampObjetReservation => 'Objeto da reserva';

  @override
  String get patrimoineObjetCulte => 'Culto';

  @override
  String get patrimoineObjetEvenement => 'Evento';

  @override
  String get patrimoineObjetAutre => 'Outro';

  @override
  String get patrimoineAucunCultePourReservation =>
      'Nenhum culto disponível para este nó.';

  @override
  String get patrimoineChampCulte => 'Culto';

  @override
  String get patrimoineChampObjetLibre => 'Descrição';

  @override
  String get patrimoineChampDateDebut => 'Data de início';

  @override
  String get patrimoineChampDateFin => 'Data de fim';

  @override
  String get patrimoineReserverBouton => 'Reservar';

  @override
  String get patrimoineMouvementAjouterTitre =>
      'Adicionar um movimento de estoque';

  @override
  String get patrimoineChampTypeMouvement => 'Tipo de movimento';

  @override
  String get patrimoineMouvementEntree => 'Entrada';

  @override
  String get patrimoineMouvementSortie => 'Saída';

  @override
  String get patrimoineChampQuantite => 'Quantidade';

  @override
  String get patrimoineStockTitre => 'Gestão de estoque';

  @override
  String get patrimoineMouvementAjouterBouton => 'Adicionar um movimento';

  @override
  String get patrimoineReservationsTitre => 'Reservas';

  @override
  String get patrimoineReservationsAucune => 'Nenhuma reserva registrada.';

  @override
  String get patrimoineCampagneDemarrerTooltip => 'Iniciar uma campanha';

  @override
  String get patrimoineCampagnesAucune =>
      'Nenhuma campanha de inventário registrada.';

  @override
  String get patrimoineCampagneEnCours => 'Em andamento';

  @override
  String get patrimoineCampagneCloturee => 'Encerrada';

  @override
  String get patrimoineCampagneDemarrerTitre =>
      'Iniciar uma campanha de inventário';

  @override
  String get patrimoineChampLibelleCampagne => 'Nome da campanha';

  @override
  String get patrimoineCampagneDemarrerBouton => 'Iniciar';

  @override
  String get patrimoineCampagneFicheTitre => 'Ficha da campanha';

  @override
  String get patrimoineCampagneIntrouvable => 'Campanha não encontrada.';

  @override
  String get patrimoineCampagneCloturerTitre => 'Encerrar a campanha';

  @override
  String get patrimoineCampagneCloturerConfirmation =>
      'Esta ação é irreversível: nenhuma nova contagem poderá ser registrada.';

  @override
  String get patrimoineCampagneCloturerBouton => 'Encerrar a campanha';

  @override
  String get patrimoineCampagneAjouterPointageTitre => 'Adicionar uma contagem';

  @override
  String get patrimoineChampBien => 'Bem';

  @override
  String get patrimoineChampEtatConstate => 'Estado constatado';

  @override
  String get patrimoineChampQuantiteConstatee => 'Quantidade constatada';

  @override
  String get patrimoineChampCommentaire => 'Comentário';

  @override
  String get patrimoineCampagneAjouterPointageBouton => 'Salvar a contagem';

  @override
  String get patrimoineCampagneAjouterPointageTooltip =>
      'Adicionar uma contagem';

  @override
  String get patrimoineCampagnePointagesTitre => 'Contagens';

  @override
  String get patrimoineCampagnePointagesAucun => 'Nenhuma contagem registrada.';

  @override
  String patrimoineAcquisLe(String date) {
    return 'Adquirido em $date';
  }

  @override
  String patrimoineSortiLe(String date) {
    return 'Retirado em $date';
  }

  @override
  String patrimoineQuantiteActuelle(int quantite) {
    return 'Quantidade atual: $quantite';
  }

  @override
  String patrimoineSeuilAlerte(int seuil) {
    return 'Limite de alerta: $seuil';
  }

  @override
  String patrimoineCampagneDemarreeLe(String date) {
    return 'Iniciada em $date';
  }

  @override
  String patrimoineCampagneClotureeLe(String date) {
    return 'Encerrada em $date';
  }

  @override
  String get comptabiliteTitre => 'Contabilidade';

  @override
  String get comptabiliteOngletCaisse => 'Caixa';

  @override
  String get comptabiliteOngletEcritures => 'Lançamentos';

  @override
  String get comptabiliteOngletRapport => 'Relatório';

  @override
  String get comptabiliteSoldeCaisseDuJour => 'Saldo de caixa do dia';

  @override
  String get comptabiliteAucuneEcriture => 'Nenhum lançamento registrado.';

  @override
  String get comptabiliteAucunePeriodeOuverte =>
      'Nenhum período contábil aberto.';

  @override
  String get comptabiliteDebit => 'Débito';

  @override
  String get comptabiliteCredit => 'Crédito';

  @override
  String get comptabiliteRapportRecettes => 'Receitas';

  @override
  String get comptabiliteRapportDepenses => 'Despesas';

  @override
  String get comptabiliteRapportSoldeNet => 'Saldo líquido';

  @override
  String get mediathequeCatalogueTitre => 'Catálogo da midiateca';

  @override
  String get mediathequeRechercheTheme => 'Pesquisar por tema';

  @override
  String get mediathequeAucunContenu => 'Nenhum conteúdo publicado no momento.';

  @override
  String get mediathequeAucunResultat => 'Nenhum resultado para esta pesquisa.';

  @override
  String get mediathequeFicheTitre => 'Ficha do conteúdo';

  @override
  String get mediathequeContenuIntrouvable =>
      'Este conteúdo não foi encontrado (ou não está mais disponível).';

  @override
  String get mediathequeChampType => 'Tipo';

  @override
  String get mediathequeChampTheme => 'Tema';

  @override
  String get mediathequeChampMotsCles => 'Palavras-chave';

  @override
  String get mediathequeChampIntervenant => 'Palestrante';

  @override
  String get mediathequeChampDate => 'Data';

  @override
  String get mediathequeChampFichier => 'Link do arquivo';

  @override
  String get mediathequeChampConsultations => 'Consultas';

  @override
  String get mediathequeEnTantQue => 'Agir como';

  @override
  String get mediathequeAjouterFavori => 'Adicionar aos favoritos';

  @override
  String get mediathequeRetirerFavori => 'Remover dos favoritos';

  @override
  String get mediathequeCommentairesTitre => 'Comentários';

  @override
  String get mediathequeAucunCommentaire => 'Nenhum comentário no momento.';

  @override
  String get mediathequeCommentaireEnAttente => 'Aguardando moderação';

  @override
  String get mediathequeSignalerCommentaire => 'Denunciar';

  @override
  String get mediathequeChampCommentaire => 'Seu comentário';

  @override
  String get mediathequeCommentaireAjouterBouton => 'Publicar';

  @override
  String get mediathequeFavorisTitre => 'Favoritos da midiateca';

  @override
  String get mediathequeFavorisAucun => 'Nenhum conteúdo favorito no momento.';

  @override
  String get authConnexionTitre => 'Entrar';

  @override
  String get authConnexionIntro =>
      'Entre sem senha: um código de uso único será enviado para você.';

  @override
  String get authIdentifiantTelephone => 'Telefone';

  @override
  String get authIdentifiantEmail => 'E-mail';

  @override
  String get authChampTelephone => 'Número no formato internacional';

  @override
  String get authChampTelephoneAide => 'Exemplo: +224 620 00 00 01';

  @override
  String get authChampEmail => 'Endereço de e-mail';

  @override
  String get authTelephoneInvalide =>
      'Número inválido: informe o código do país (ex. +224…).';

  @override
  String get authEmailInvalide => 'Endereço de e-mail inválido.';

  @override
  String get authMethodeTitre => 'Receber o código por';

  @override
  String get authMethodeSms => 'SMS';

  @override
  String get authMethodeWhatsapp => 'WhatsApp';

  @override
  String get authMethodeMagicLink => 'Link de acesso (Magic Link)';

  @override
  String get authMethodeCodeEmail => 'Código por e-mail';

  @override
  String get authBasculerVersEmail =>
      'Receber um código por e-mail em vez disso';

  @override
  String get authEnvoyerCode => 'Receber o código';

  @override
  String get authVerificationTitre => 'Verificação';

  @override
  String authVerificationIntro(String destinataire) {
    return 'Digite o código de 6 dígitos enviado para $destinataire.';
  }

  @override
  String get authVerificationMagicLink =>
      'Você também pode abrir o link do mesmo e-mail no dispositivo onde o aplicativo está instalado.';

  @override
  String get authChampCode => 'Código';

  @override
  String get authVerifier => 'Entrar';

  @override
  String get authRenvoyerCode => 'Reenviar o código';

  @override
  String get authModifierIdentifiant => 'Alterar o identificador';

  @override
  String get authDeconnexion => 'Sair';

  @override
  String authCompteConnecte(String identifiant) {
    return 'Conectado: $identifiant';
  }

  @override
  String get authLiaisonsTitre => 'Vínculos de contas';

  @override
  String get authLiaisonsAucune => 'Nenhum vínculo registrado.';

  @override
  String get authLiaisonsConflits => 'Conflitos a resolver';

  @override
  String get authLiaisonsJournal => 'Registro';

  @override
  String get authIssueLieAutomatiquement => 'Vinculada automaticamente';

  @override
  String get authIssueAdministrateurAmorcage => 'Administrador inicial';

  @override
  String get authIssueAucuneCorrespondance => 'Nenhuma ficha correspondente';

  @override
  String get authIssueCorrespondanceMultiple => 'Várias fichas correspondem';

  @override
  String get authIssueFicheDejaLiee => 'Ficha já vinculada a outra conta';

  @override
  String get authStatutEnAttente => 'Pendente';

  @override
  String get authStatutResoluLie => 'Resolvido: conta vinculada';

  @override
  String get authStatutResoluRejete =>
      'Resolvido: mantido como usuário simples';

  @override
  String get authLiaisonLier => 'Vincular a conta';

  @override
  String get authLiaisonRejeter => 'Manter como usuário simples';

  @override
  String get authLiaisonChoisirFiche => 'Ficha a vincular';

  @override
  String get authLiaisonConfirmation =>
      'Se a ficha estiver vinculada a outra conta, esse vínculo será removido e substituído. Confirmar?';

  @override
  String get authConfirmer => 'Confirmar';

  @override
  String get roleUtilisateurSimple => 'Usuário simples';

  @override
  String get roleMembre => 'Membro';

  @override
  String get roleResponsable => 'Responsável';

  @override
  String get rolePasteur => 'Pastor';

  @override
  String get roleAdministrateur => 'Administrador';

  @override
  String get authLierMonCompte => 'Vincular a minha conta a esta ficha';

  @override
  String authLierMonCompteConfirmation(String nom) {
    return 'A sua conta de administrador será vinculada à ficha de $nom, que assumirá o papel de administrador. A vinculação é registada e só pode ser desfeita pela resolução de um conflito de vinculação.';
  }

  @override
  String get authLierMonCompteFait => 'Conta vinculada à sua ficha.';
}
