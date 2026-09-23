// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Ecclesias360';

  @override
  String get homeWelcome => 'Bienvenido a Ecclesias360';

  @override
  String get archivageAucunDansCorbeille => 'Papelera vacía.';

  @override
  String get archivageAucunDocument => 'Ningún documento archivado.';

  @override
  String get archivageBibliothequeTitre => 'Documentos archivados';

  @override
  String get archivageChampReferenceFichier =>
      'Referencia del archivo (nombre, enlace...)';

  @override
  String get archivageCorbeilleTitre => 'Papelera';

  @override
  String get archivageDetailTitre => 'Documento archivado';

  @override
  String get archivageDocumentIntrouvable =>
      'Este documento no se encuentra (o fue purgado).';

  @override
  String get archivageMettreEnCorbeilleBouton => 'Enviar a la papelera';

  @override
  String archivageMiseCorbeilleLe(String date) {
    return 'Enviado a la papelera el $date';
  }

  @override
  String get archivageNiveauRestreint => 'Restringido';

  @override
  String get archivageNiveauStandard => 'Estándar';

  @override
  String get archivageNouvelleVersionBouton => 'Nueva versión';

  @override
  String get archivageNouvelleVersionTitre => 'Agregar una nueva versión';

  @override
  String get archivageOrigineLabel => 'Origen';

  @override
  String archivagePurgeableApres(String date) {
    return 'Purgable a partir del $date';
  }

  @override
  String get archivagePurgerBouton => 'Purgar definitivamente';

  @override
  String get archivagePurgerConfirmationMessage =>
      'Esta acción es irreversible: el documento y todas sus versiones serán eliminados.';

  @override
  String get archivagePurgerConfirmationTitre =>
      '¿Purgar definitivamente este documento?';

  @override
  String get archivageRechercheLabel => 'Buscar un documento (número, tipo)';

  @override
  String get archivageRestaurerBouton => 'Restaurar';

  @override
  String archivageVersionLabel(int numero) {
    return 'Versión $numero';
  }

  @override
  String get archivageVersionsTitre => 'Historial de versiones';

  @override
  String get deplacementsAucunDeplacement => 'Ninguna mutación registrada.';

  @override
  String get deplacementsAucuneMutation => 'Ninguna mutación.';

  @override
  String get deplacementsChampFidele => 'Miembro';

  @override
  String get deplacementsChampMotif => 'Motivo';

  @override
  String get deplacementsChampMotifRefus => 'Motivo del rechazo (opcional)';

  @override
  String get deplacementsChampNoeudDestination => 'Iglesia de destino';

  @override
  String get deplacementsCoteDestinationLabel => 'Iglesia de destino';

  @override
  String get deplacementsCoteOrigineLabel => 'Iglesia de origen';

  @override
  String get deplacementsDateDemandeLabel => 'Solicitada el';

  @override
  String get deplacementsDateValidationLabel => 'Aprobada el';

  @override
  String get deplacementsDemanderTitre => 'Solicitar una mutación';

  @override
  String get deplacementsDetailTitre => 'Mutación';

  @override
  String get deplacementsHistoriqueTitre => 'Historial de mutaciones';

  @override
  String get deplacementsIntrouvable => 'Esta mutación no se encuentra.';

  @override
  String get deplacementsMotifLabel => 'Motivo';

  @override
  String get deplacementsRefuserBouton => 'Rechazar';

  @override
  String get deplacementsRefuserTitre => '¿Rechazar esta mutación?';

  @override
  String get deplacementsStatutEnAttente => 'Pendiente';

  @override
  String get deplacementsStatutRefusee => 'Rechazada';

  @override
  String get deplacementsStatutValidee => 'Aprobada';

  @override
  String get deplacementsTitre => 'Mutaciones';

  @override
  String get deplacementsValiderDestinationBouton => 'Aprobar (destino)';

  @override
  String get deplacementsValiderOrigineBouton => 'Aprobar (origen)';

  @override
  String get deplacementsVoirLettreBouton => 'Ver carta de recomendación';

  @override
  String get comiteAjouterDecisionTitre => 'Agregar una decisión';

  @override
  String get comiteAjouterErratumBouton => 'Agregar una errata';

  @override
  String get comiteAjouterTacheBouton => 'Agregar una tarea';

  @override
  String get comiteAjouterTacheTitre => 'Agregar una tarea de seguimiento';

  @override
  String get comiteAucunMembre => 'Ningún miembro nombrado.';

  @override
  String get comiteAucuneDecision => 'Ninguna decisión.';

  @override
  String get comiteAucuneSeance => 'Ninguna sesión registrada.';

  @override
  String get comiteBoutonNommer => 'Nombrar';

  @override
  String get comiteChampAssigneA => 'Asignada a';

  @override
  String get comiteChampBrouillonPv => 'Borrador del acta';

  @override
  String get comiteChampDate => 'Fecha';

  @override
  String get comiteChampFonction => 'Función (ej. Pastor, Diácono)';

  @override
  String get comiteChampLibelle => 'Título';

  @override
  String get comiteChampNouvelErratum => 'Nueva errata';

  @override
  String get comiteChampOrdreDuJour => 'Orden del día';

  @override
  String get comiteChampPorteeDisciplinaire =>
      'Alcance disciplinario (Módulo X)';

  @override
  String get comiteChampResultatVote =>
      'Resultado de la votación (ej. 5 a favor, 1 en contra)';

  @override
  String get comiteCloreMandatTooltip => 'Finalizar el mandato';

  @override
  String get comiteDecisionsTitre => 'Decisiones';

  @override
  String get comiteEnregistrerBrouillon => 'Guardar el borrador';

  @override
  String get comiteEnregistrerSeance => 'Guardar la sesión';

  @override
  String get comiteErratumsTitre => 'Erratas';

  @override
  String comiteMembreActif(String fonction, String date) {
    return '$fonction — desde el $date';
  }

  @override
  String comiteMembreClos(String fonction) {
    return '$fonction (mandato finalizado)';
  }

  @override
  String get comiteMembresTitre => 'Miembros del comité';

  @override
  String get comiteNommerMembreTitre => 'Nombrar un miembro del comité';

  @override
  String get comiteNommerMembreTooltip => 'Nombrar un miembro';

  @override
  String get comiteNouvelleSeanceTitre => 'Nueva sesión';

  @override
  String get comitePresentsTitre => 'Presentes';

  @override
  String get comiteProcesVerbalTitre => 'Acta';

  @override
  String get comitePvValideEtImmuable =>
      'Esta acta está validada y es inmutable.';

  @override
  String get comiteQuorumAtteint => 'Cuórum alcanzado';

  @override
  String get comiteQuorumNonAtteint => 'Cuórum no alcanzado';

  @override
  String get comiteQuorumNonConfigure => 'Cuórum no configurado';

  @override
  String get comiteSeanceIntrouvableCorps => 'Esta sesión no existe (ya).';

  @override
  String get comiteSeanceTitre => 'Sesión';

  @override
  String get comiteSeancesTitre => 'Sesiones del comité';

  @override
  String get comiteTachesDeSuiviTitre => 'Tareas de seguimiento';

  @override
  String get comiteValiderPv => 'Validar (inmutable)';

  @override
  String get commonAjouter => 'Añadir';

  @override
  String get commonAnnuler => 'Cancelar';

  @override
  String get commonCreer => 'Crear';

  @override
  String get commonDescription => 'Descripción';

  @override
  String get commonEnregistrer => 'Guardar';

  @override
  String get commonFidele => 'Feligrés';

  @override
  String get commonOui => 'sí';

  @override
  String get culteAjouterSequenceBouton => 'Agregar una secuencia';

  @override
  String get culteAjouterSequenceTitre => 'Agregar una secuencia';

  @override
  String get culteAucunPredicateur => 'Ninguno';

  @override
  String get culteAucuneSequence => 'Ninguna secuencia.';

  @override
  String get culteChampAudioUrl => 'Enlace de audio';

  @override
  String get culteChampCompteGlobal => 'Recuento global de asistencia';

  @override
  String get culteChampDateHeure => 'Fecha y hora';

  @override
  String get culteChampDureeMinutes => 'Duración prevista (minutos)';

  @override
  String get culteChampLibelleSequence => 'Título (ej. Alabanza, Predicación)';

  @override
  String get culteChampModePresence => 'Modo de asistencia';

  @override
  String get culteChampNombreOccurrences => 'Número de repeticiones';

  @override
  String get culteChampOrdre => 'Orden';

  @override
  String get culteChampPdfUrl => 'Enlace PDF';

  @override
  String get culteChampPredicateur => 'Predicador (opcional)';

  @override
  String get culteChampRecurrent => 'Crear una serie recurrente (semanal)';

  @override
  String get culteChampResponsable => 'Responsable (opcional)';

  @override
  String get culteChampTexteBiblique => 'Texto bíblico';

  @override
  String get culteChampTheme => 'Tema (opcional)';

  @override
  String get culteChampType => 'Tipo de culto (ej. Culto dominical)';

  @override
  String get culteChampTypeErreur => 'El tipo de culto es obligatorio.';

  @override
  String get culteChampVideoUrl => 'Enlace de video';

  @override
  String get culteDateHeureChoisir => 'Elegir la fecha y la hora';

  @override
  String get culteEnregistrerCompte => 'Guardar el recuento';

  @override
  String get culteLiturgieTitre => 'Liturgia';

  @override
  String get culteModePresenceGlobal => 'Global (recuento total)';

  @override
  String get culteModePresenceNominal => 'Nominal (por feligrés)';

  @override
  String get culteNonPublie => 'Ninguna publicación para este culto.';

  @override
  String get cultePresencesTitre => 'Asistencia';

  @override
  String get cultePublicationTitre => 'Publicación posterior al culto';

  @override
  String cultePublieLe(String date) {
    return 'Publicado el $date';
  }

  @override
  String get cultePublierBouton => 'Publicar';

  @override
  String get culteStatutTitre => 'Estado';

  @override
  String get cultesAucun => 'Ningún culto registrado.';

  @override
  String get cultesNouveauTooltip => 'Nuevo culto';

  @override
  String get cultesTitre => 'Cultos';

  @override
  String get dashboardModulesTitre => 'Módulos';

  @override
  String get fideleActionArchiver => 'Archivar (RG-II-08)';

  @override
  String get fideleActionCompetences => 'Competencias profesionales';

  @override
  String get fideleActionDons => 'Dones espirituales';

  @override
  String get fideleActionGroupes => 'Grupos de la Iglesia';

  @override
  String get fideleAjouterLienBouton => 'Agregar un vínculo';

  @override
  String get fideleAjouterLienTitre => 'Agregar un vínculo familiar';

  @override
  String get fideleAjouterTuteurBouton => 'Agregar un tutor';

  @override
  String get fideleAjouterTuteurTitre => 'Agregar un tutor (tercero)';

  @override
  String get fideleChampAdresse => 'Dirección';

  @override
  String get fideleChampDateNaissance => 'Fecha de nacimiento';

  @override
  String get fideleChampEmail => 'Correo electrónico';

  @override
  String get fideleChampLienTuteur => 'Vínculo (ej. padre)';

  @override
  String get fideleChampMineur => 'Menor de edad';

  @override
  String get fideleChampNoeud => 'Nodo de pertenencia';

  @override
  String get fideleChampNoeudErreur => 'Elija un nodo de pertenencia.';

  @override
  String get fideleChampNom => 'Apellido';

  @override
  String get fideleChampNomErreur => 'El apellido es obligatorio.';

  @override
  String get fideleChampNomTuteur => 'Nombre del tutor';

  @override
  String get fideleChampPrenoms => 'Nombres';

  @override
  String get fideleChampPrenomsErreur => 'Los nombres son obligatorios.';

  @override
  String get fideleChampSexe => 'Sexo';

  @override
  String get fideleChampSexeErreur => 'Elija un sexo.';

  @override
  String get fideleChampStatutCivil => 'Estado civil';

  @override
  String get fideleChampStatutCivilErreur => 'Elija un estado civil.';

  @override
  String get fideleChampTelephone => 'Teléfono';

  @override
  String get fideleCheminementTitre => 'Camino espiritual';

  @override
  String fideleDateNaissanceValeur(String date) {
    return 'Fecha de nacimiento: $date';
  }

  @override
  String get fideleHistoriqueAucune => 'Ninguna modificación registrada.';

  @override
  String fideleHistoriqueTitre(String nom) {
    return 'Historial — $nom';
  }

  @override
  String get fideleHistoriqueTooltip => 'Historial de modificaciones';

  @override
  String get fideleIntrouvableCorps => 'Este feligrés no existe (ya).';

  @override
  String get fideleIntrouvableTitre => 'Feligrés no encontrado';

  @override
  String get fideleLiensFamiliauxTitre => 'Vínculos familiares';

  @override
  String get fideleModifierCoordonnees => 'Editar los datos de contacto';

  @override
  String get fideleStatutActuel => 'Estado actual';

  @override
  String get fideleStatutDisciplineNote =>
      'Este estado solo puede modificarse desde el módulo Disciplina (RG-II-03).';

  @override
  String fideleTransitionVers(String cible) {
    return '→ $cible';
  }

  @override
  String get fideleTuteurLegalTitre => 'Tutor legal (RG-II-06)';

  @override
  String get fidelesAucun => 'Ningún feligrés registrado.';

  @override
  String get fidelesCreerAction => 'Crear un feligrés';

  @override
  String get fidelesRechercherIndice =>
      'Buscar un feligrés (apellido o nombres)';

  @override
  String get fidelesTitre => 'Feligreses';

  @override
  String get moduleDonsReferentiel => 'Referencial de dones espirituales';

  @override
  String get moduleGroupesEglise => 'Grupos de la Iglesia';

  @override
  String get moduleMandatsEcheance => 'Mandatos por vencer';

  @override
  String get moduleOrganisation => 'Organización';

  @override
  String get moduleProfessions => 'Grupos profesionales';

  @override
  String get moduleRoles => 'Roles';

  @override
  String get moduleZonesGeographiques => 'Zonas geográficas';

  @override
  String get navAccueil => 'Inicio';

  @override
  String get parametresTitre => 'Configuración';

  @override
  String get propositionChampExplication => 'Breve explicación (opcional)';

  @override
  String get propositionChampTitre => 'Título';

  @override
  String get propositionSoumettreTitre => 'Enviar una propuesta de tema';

  @override
  String get propositionSoumettreTooltip => 'Enviar una propuesta';

  @override
  String get propositionsAucune => 'Ninguna propuesta enviada.';

  @override
  String get propositionsThemeTitre => 'Propuestas de tema';

  @override
  String get propositionsVoterEnTantQue => 'Votar/enviar como';

  @override
  String get disciplineTitre => 'Expedientes disciplinarios';

  @override
  String get disciplineHistoriqueTitre =>
      'Historial disciplinario confidencial';

  @override
  String get disciplineAucunDossier => 'Ningún expediente disciplinario.';

  @override
  String get disciplineAucunDossierFidele =>
      'Ningún expediente disciplinario para este miembro.';

  @override
  String get disciplineOuvrirTooltip => 'Abrir un expediente';

  @override
  String get disciplineOuvrirTitre => 'Abrir un expediente disciplinario';

  @override
  String get disciplineChampFideleMisEnCause => 'Miembro implicado';

  @override
  String get disciplineChampNatureFaute => 'Naturaleza de la falta';

  @override
  String get disciplineAccesReserve =>
      'Acceso reservado a un pastor o a un miembro de la comisión disciplinaria.';

  @override
  String get disciplineStatutEnInstruction => 'En instrucción';

  @override
  String get disciplineStatutSanctionne => 'Sancionado';

  @override
  String get disciplineStatutClos => 'Cerrado';

  @override
  String disciplineAlerteFinDePeriode(String date) {
    return 'Reintegración prevista el $date';
  }

  @override
  String get disciplineAlerteRevuePeriodique => 'Revisión periódica necesaria';

  @override
  String get disciplineDetailTitre => 'Expediente disciplinario';

  @override
  String get disciplineIntrouvable =>
      'Este expediente disciplinario no se pudo encontrar.';

  @override
  String disciplineOuvertLe(String date) {
    return 'Abierto el $date';
  }

  @override
  String get disciplineCommissionTitre => 'Comisión instructora';

  @override
  String get disciplineCommissionAucune => 'Ninguna comisión asignada.';

  @override
  String get disciplineCommissionAssignerBouton => 'Asignar una comisión';

  @override
  String get disciplineCommissionAssignerTitre => 'Asignar una comisión';

  @override
  String get disciplineCommissionCreerBouton => 'Crear una nueva comisión';

  @override
  String get disciplineCommissionCreerTitre => 'Crear una comisión';

  @override
  String get disciplineChampNomCommission => 'Nombre de la comisión';

  @override
  String get disciplineCommissionMembresTitre => 'Miembros de la comisión';

  @override
  String get disciplineCommissionAjouterMembreTooltip => 'Añadir un miembro';

  @override
  String get disciplinePiecesTitre => 'Documentos del expediente';

  @override
  String get disciplinePiecesAucune => 'Ningún documento aportado.';

  @override
  String get disciplinePieceAjouterTooltip => 'Añadir un documento';

  @override
  String get disciplinePieceAjouterTitre => 'Añadir un documento';

  @override
  String get disciplinePieceChampNature => 'Tipo de documento';

  @override
  String get disciplinePieceNatureTemoignage => 'Testimonio';

  @override
  String get disciplinePieceNaturePreuve => 'Prueba';

  @override
  String get disciplinePieceChampContenu => 'Contenido (texto)';

  @override
  String get disciplineDecisionTitre => 'Decisión';

  @override
  String get disciplineChampDecision => 'Decisión motivada';

  @override
  String get disciplineChampDureeSanction =>
      'Duración de la sanción en días (vacío = indeterminada)';

  @override
  String get disciplineChampSuspendreMinisteres =>
      'Suspender las asignaciones ministeriales activas';

  @override
  String get disciplinePrononcerBouton => 'Emitir la decisión';

  @override
  String disciplineDecisionRendueLe(String date) {
    return 'Decisión emitida el $date';
  }

  @override
  String get disciplineCloturerBouton => 'Cerrar / Reintegrar';

  @override
  String get disciplineDossierClosNote =>
      'Expediente cerrado — el miembro ha recuperado su estatus anterior.';

  @override
  String get disciplineDureeIndeterminee => 'Duración indeterminada';

  @override
  String disciplineDureeJours(int jours) {
    return '$jours día(s)';
  }

  @override
  String get financesTitre => 'Contribuciones';

  @override
  String get financesHistoriqueTitre => 'Historial de contribuciones';

  @override
  String get financesAucuneContribution => 'Ninguna contribución registrada.';

  @override
  String get financesAucuneContributionFidele =>
      'Ninguna contribución para este miembro.';

  @override
  String get financesSaisirTooltip => 'Registrar una ofrenda';

  @override
  String get financesSaisirTitre => 'Registrar una ofrenda';

  @override
  String get financesChampDonateur => 'Donante';

  @override
  String get financesDonateurAnonyme => 'Donante anónimo';

  @override
  String get financesChampLibelleDonateurAnonyme =>
      'Etiqueta del donante anónimo (opcional)';

  @override
  String get financesChampTypeOffrande => 'Tipo de ofrenda';

  @override
  String get financesChampMontant => 'Monto';

  @override
  String get financesChampModePaiement => 'Método de pago';

  @override
  String get financesModePaiementEspeces => 'Efectivo';

  @override
  String get financesModePaiementMobileMoney => 'Dinero móvil';

  @override
  String get financesModePaiementVirement => 'Transferencia bancaria';

  @override
  String get financesSaisirBouton => 'Registrar';

  @override
  String get financesRapportParTypeTitre => 'Desglose por tipo de ofrenda';

  @override
  String get financesStatutEnAttente => 'Pendiente';

  @override
  String get financesStatutValidee => 'Validada';

  @override
  String get financesStatutRejetee => 'Rechazada';

  @override
  String get financesTresoriersTitre => 'Tesoreros designados';

  @override
  String get financesTresoriersAucun => 'Ningún tesorero designado.';

  @override
  String get financesTresorierDesignerTitre => 'Designar un tesorero';

  @override
  String get financesTresorierDesignerBouton => 'Designar';

  @override
  String get financesTresorierDesignerTooltip => 'Designar un tesorero';

  @override
  String financesTresorierDepuis(String date) {
    return 'Tesorero desde el $date';
  }

  @override
  String get financesTresorierRetirerTooltip => 'Quitar designación';

  @override
  String get financesRecuTitre => 'Recibo de contribución';

  @override
  String get financesIntrouvable => 'Esta contribución no se encuentra.';

  @override
  String get financesValiderTitre => 'Validar la contribución';

  @override
  String get financesChampRoleActeur => 'Rol actuante';

  @override
  String get financesChampValidePar => 'Validado por';

  @override
  String get financesValiderBouton => 'Validar';

  @override
  String get financesRejeterTitre => 'Rechazar la contribución';

  @override
  String get financesChampMotif => 'Motivo';

  @override
  String get financesRejeterBouton => 'Rechazar';

  @override
  String get financesContrePasserTitre => 'Contrapasar la contribución';

  @override
  String get financesContrePasserBouton => 'Contrapasar';

  @override
  String financesSaisieLe(String date) {
    return 'Registrada el $date';
  }

  @override
  String financesValideeLe(String date) {
    return 'Validada el $date';
  }

  @override
  String get financesEstContrePassation =>
      'Esta contribución es una contrapartida.';

  @override
  String get financesProjetsTitre => 'Proyectos';

  @override
  String get financesProjetsAucun => 'Ningún proyecto.';

  @override
  String get financesProjetCreerTitre => 'Crear un proyecto';

  @override
  String get financesProjetCreerTooltip => 'Crear un proyecto';

  @override
  String get financesChampNomProjet => 'Nombre del proyecto';

  @override
  String get financesChampBudgetPrevisionnel => 'Presupuesto previsto';

  @override
  String financesProjetSoldeSurBudget(int solde, int budget, String devise) {
    return 'Saldo: $solde $devise / presupuesto $budget $devise';
  }

  @override
  String get financesProjetDetailTitre => 'Ficha del proyecto';

  @override
  String get financesProjetIntrouvable => 'Este proyecto no se encuentra.';

  @override
  String get financesDepenseAjouterTitre => 'Agregar un gasto';

  @override
  String get financesDepenseAjouterBouton => 'Agregar un gasto';

  @override
  String get financesChampLibelleDepense => 'Etiqueta del gasto';

  @override
  String get financesChampDerogationTracee =>
      'Excepción registrada (supera el saldo disponible)';

  @override
  String get financesDepensesTitre => 'Gastos';

  @override
  String get financesDepensesAucune => 'Ningún gasto registrado.';

  @override
  String financesDepenseDerogation(String date) {
    return '$date — excepción registrada';
  }

  @override
  String get financesEngagementsTitre => 'Compromisos y vencimientos';

  @override
  String get financesEngagementsAucun => 'Ningún compromiso.';

  @override
  String get financesEngagementCreerTitre => 'Crear un compromiso';

  @override
  String get financesEngagementCreerTooltip => 'Crear un compromiso';

  @override
  String get financesChampTypeEngagement => 'Tipo de compromiso';

  @override
  String get financesTypeEngagementDime => 'Diezmo';

  @override
  String get financesTypeEngagementPromesseDon => 'Promesa de donación';

  @override
  String get financesChampMontantPrevu => 'Monto previsto';

  @override
  String get financesChampPeriodicite => 'Periodicidad';

  @override
  String get financesPeriodiciteHebdomadaire => 'Semanal';

  @override
  String get financesPeriodiciteMensuelle => 'Mensual';

  @override
  String get financesPeriodiciteTrimestrielle => 'Trimestral';

  @override
  String get financesPeriodiciteAnnuelle => 'Anual';

  @override
  String financesEngagementPeriodicite(String periodicite) {
    return 'Periodicidad: $periodicite';
  }

  @override
  String get financesEcheanceEnAttente => 'Pendiente';

  @override
  String get financesEcheanceHonoree => 'Cumplida';

  @override
  String get financesEcheanceEnRetard => 'Atrasada';

  @override
  String get financesEcheanceHonorerBouton => 'Cumplir';

  @override
  String get patrimoineTitre => 'Bienes';

  @override
  String get patrimoineCampagnesTitre => 'Campañas de inventario';

  @override
  String get patrimoineAjouterTooltip => 'Añadir un bien';

  @override
  String get patrimoineAucunBien => 'No hay bienes registrados.';

  @override
  String get patrimoineAlerteSeuilTitre =>
      'Bienes bajo el umbral de alerta de stock';

  @override
  String get patrimoineAjouterTitre => 'Añadir un bien';

  @override
  String get patrimoineChampIdInventaire => 'Identificador de inventario';

  @override
  String get patrimoineChampCategorie => 'Categoría';

  @override
  String get patrimoineChampDesignation => 'Designación';

  @override
  String get patrimoineChampValeurAcquisition => 'Valor de adquisición';

  @override
  String get patrimoineChampValeurVenale => 'Valor venal';

  @override
  String get patrimoineChampDateAcquisition => 'Fecha de adquisición';

  @override
  String get patrimoineChampSeuilAlerteStock => 'Umbral de alerta de stock';

  @override
  String get patrimoineEtatNeuf => 'Nuevo';

  @override
  String get patrimoineEtatBon => 'Bueno';

  @override
  String get patrimoineEtatAReparer => 'Por reparar';

  @override
  String get patrimoineEtatHorsService => 'Fuera de servicio';

  @override
  String get patrimoineEtatCede => 'Cedido';

  @override
  String get patrimoineFicheTitre => 'Ficha del bien';

  @override
  String get patrimoineIntrouvable => 'Bien no encontrado.';

  @override
  String get patrimoineSignalerEtatTitre => 'Reportar el estado del bien';

  @override
  String get patrimoineChampEtat => 'Estado';

  @override
  String get patrimoineSignalerEtatBouton => 'Reportar estado';

  @override
  String get patrimoineSortirTitre => 'Retirar el bien del patrimonio';

  @override
  String get patrimoineChampTypeSortie => 'Tipo de salida';

  @override
  String get patrimoineTypeSortieCession => 'Cesión';

  @override
  String get patrimoineTypeSortieDon => 'Donación';

  @override
  String get patrimoineTypeSortieMiseAuRebut => 'Desecho';

  @override
  String get patrimoineChampRoleActeur => 'Rol del actor';

  @override
  String get patrimoineChampValidePar => 'Validado por';

  @override
  String get patrimoineChampMotif => 'Motivo';

  @override
  String get patrimoineSortirBouton => 'Retirar el bien';

  @override
  String get patrimoineReserverTitre => 'Reservar el bien';

  @override
  String get patrimoineChampObjetReservation => 'Objeto de la reserva';

  @override
  String get patrimoineObjetCulte => 'Culto';

  @override
  String get patrimoineObjetEvenement => 'Evento';

  @override
  String get patrimoineObjetAutre => 'Otro';

  @override
  String get patrimoineAucunCultePourReservation =>
      'No hay ningún culto disponible para este nodo.';

  @override
  String get patrimoineChampCulte => 'Culto';

  @override
  String get patrimoineChampObjetLibre => 'Descripción';

  @override
  String get patrimoineChampDateDebut => 'Fecha de inicio';

  @override
  String get patrimoineChampDateFin => 'Fecha de fin';

  @override
  String get patrimoineReserverBouton => 'Reservar';

  @override
  String get patrimoineMouvementAjouterTitre => 'Añadir un movimiento de stock';

  @override
  String get patrimoineChampTypeMouvement => 'Tipo de movimiento';

  @override
  String get patrimoineMouvementEntree => 'Entrada';

  @override
  String get patrimoineMouvementSortie => 'Salida';

  @override
  String get patrimoineChampQuantite => 'Cantidad';

  @override
  String get patrimoineStockTitre => 'Gestión de stock';

  @override
  String get patrimoineMouvementAjouterBouton => 'Añadir un movimiento';

  @override
  String get patrimoineReservationsTitre => 'Reservas';

  @override
  String get patrimoineReservationsAucune => 'No hay reservas registradas.';

  @override
  String get patrimoineCampagneDemarrerTooltip => 'Iniciar una campaña';

  @override
  String get patrimoineCampagnesAucune =>
      'No hay campañas de inventario registradas.';

  @override
  String get patrimoineCampagneEnCours => 'En curso';

  @override
  String get patrimoineCampagneCloturee => 'Cerrada';

  @override
  String get patrimoineCampagneDemarrerTitre =>
      'Iniciar una campaña de inventario';

  @override
  String get patrimoineChampLibelleCampagne => 'Nombre de la campaña';

  @override
  String get patrimoineCampagneDemarrerBouton => 'Iniciar';

  @override
  String get patrimoineCampagneFicheTitre => 'Ficha de la campaña';

  @override
  String get patrimoineCampagneIntrouvable => 'Campaña no encontrada.';

  @override
  String get patrimoineCampagneCloturerTitre => 'Cerrar la campaña';

  @override
  String get patrimoineCampagneCloturerConfirmation =>
      'Esta acción es irreversible: no se podrá registrar ningún conteo nuevo.';

  @override
  String get patrimoineCampagneCloturerBouton => 'Cerrar la campaña';

  @override
  String get patrimoineCampagneAjouterPointageTitre => 'Añadir un conteo';

  @override
  String get patrimoineChampBien => 'Bien';

  @override
  String get patrimoineChampEtatConstate => 'Estado constatado';

  @override
  String get patrimoineChampQuantiteConstatee => 'Cantidad constatada';

  @override
  String get patrimoineChampCommentaire => 'Comentario';

  @override
  String get patrimoineCampagneAjouterPointageBouton => 'Guardar el conteo';

  @override
  String get patrimoineCampagneAjouterPointageTooltip => 'Añadir un conteo';

  @override
  String get patrimoineCampagnePointagesTitre => 'Conteos';

  @override
  String get patrimoineCampagnePointagesAucun => 'No hay conteos registrados.';

  @override
  String patrimoineAcquisLe(String date) {
    return 'Adquirido el $date';
  }

  @override
  String patrimoineSortiLe(String date) {
    return 'Retirado el $date';
  }

  @override
  String patrimoineQuantiteActuelle(int quantite) {
    return 'Cantidad actual: $quantite';
  }

  @override
  String patrimoineSeuilAlerte(int seuil) {
    return 'Umbral de alerta: $seuil';
  }

  @override
  String patrimoineCampagneDemarreeLe(String date) {
    return 'Iniciada el $date';
  }

  @override
  String patrimoineCampagneClotureeLe(String date) {
    return 'Cerrada el $date';
  }

  @override
  String get comptabiliteTitre => 'Contabilidad';

  @override
  String get comptabiliteOngletCaisse => 'Caja';

  @override
  String get comptabiliteOngletEcritures => 'Asientos';

  @override
  String get comptabiliteOngletRapport => 'Informe';

  @override
  String get comptabiliteSoldeCaisseDuJour => 'Saldo de caja del día';

  @override
  String get comptabiliteAucuneEcriture => 'No hay asientos registrados.';

  @override
  String get comptabiliteAucunePeriodeOuverte =>
      'No hay ningún período contable abierto.';

  @override
  String get comptabiliteDebit => 'Débito';

  @override
  String get comptabiliteCredit => 'Crédito';

  @override
  String get comptabiliteRapportRecettes => 'Ingresos';

  @override
  String get comptabiliteRapportDepenses => 'Gastos';

  @override
  String get comptabiliteRapportSoldeNet => 'Saldo neto';

  @override
  String get mediathequeCatalogueTitre => 'Catálogo de la mediateca';

  @override
  String get mediathequeRechercheTheme => 'Buscar por tema';

  @override
  String get mediathequeAucunContenu =>
      'Ningún contenido publicado por el momento.';

  @override
  String get mediathequeAucunResultat => 'Ningún resultado para esta búsqueda.';

  @override
  String get mediathequeFicheTitre => 'Ficha del contenido';

  @override
  String get mediathequeContenuIntrouvable =>
      'Este contenido no se encuentra (o ya no está disponible).';

  @override
  String get mediathequeChampType => 'Tipo';

  @override
  String get mediathequeChampTheme => 'Tema';

  @override
  String get mediathequeChampMotsCles => 'Palabras clave';

  @override
  String get mediathequeChampIntervenant => 'Ponente';

  @override
  String get mediathequeChampDate => 'Fecha';

  @override
  String get mediathequeChampFichier => 'Enlace del archivo';

  @override
  String get mediathequeChampConsultations => 'Consultas';

  @override
  String get mediathequeEnTantQue => 'Actuar como';

  @override
  String get mediathequeAjouterFavori => 'Añadir a favoritos';

  @override
  String get mediathequeRetirerFavori => 'Quitar de favoritos';

  @override
  String get mediathequeCommentairesTitre => 'Comentarios';

  @override
  String get mediathequeAucunCommentaire => 'Ningún comentario por el momento.';

  @override
  String get mediathequeCommentaireEnAttente => 'Pendiente de moderación';

  @override
  String get mediathequeSignalerCommentaire => 'Reportar';

  @override
  String get mediathequeChampCommentaire => 'Tu comentario';

  @override
  String get mediathequeCommentaireAjouterBouton => 'Publicar';

  @override
  String get mediathequeFavorisTitre => 'Favoritos de la mediateca';

  @override
  String get mediathequeFavorisAucun =>
      'Ningún contenido favorito por el momento.';

  @override
  String get authConnexionTitre => 'Iniciar sesión';

  @override
  String get authConnexionIntro =>
      'Inicie sesión sin contraseña: se le enviará un código de un solo uso.';

  @override
  String get authIdentifiantTelephone => 'Teléfono';

  @override
  String get authIdentifiantEmail => 'Correo electrónico';

  @override
  String get authChampTelephone => 'Número en formato internacional';

  @override
  String get authChampTelephoneAide => 'Ejemplo: +224 620 00 00 01';

  @override
  String get authChampEmail => 'Dirección de correo';

  @override
  String get authTelephoneInvalide =>
      'Número no válido: indique el prefijo del país (p. ej. +224…).';

  @override
  String get authEmailInvalide => 'Dirección de correo no válida.';

  @override
  String get authMethodeTitre => 'Recibir el código por';

  @override
  String get authMethodeSms => 'SMS';

  @override
  String get authMethodeWhatsapp => 'WhatsApp';

  @override
  String get authMethodeMagicLink => 'Enlace de acceso (Magic Link)';

  @override
  String get authMethodeCodeEmail => 'Código por correo';

  @override
  String get authBasculerVersEmail =>
      'Recibir un código por correo en su lugar';

  @override
  String get authEnvoyerCode => 'Recibir el código';

  @override
  String get authVerificationTitre => 'Verificación';

  @override
  String authVerificationIntro(String destinataire) {
    return 'Introduzca el código de 6 dígitos enviado a $destinataire.';
  }

  @override
  String get authVerificationMagicLink =>
      'También puede abrir el enlace del mismo correo en el dispositivo donde está instalada la aplicación.';

  @override
  String get authChampCode => 'Código';

  @override
  String get authVerifier => 'Iniciar sesión';

  @override
  String get authRenvoyerCode => 'Reenviar el código';

  @override
  String get authModifierIdentifiant => 'Cambiar el identificador';

  @override
  String get authDeconnexion => 'Cerrar sesión';

  @override
  String authCompteConnecte(String identifiant) {
    return 'Conectado: $identifiant';
  }

  @override
  String get authLiaisonsTitre => 'Vinculaciones de cuentas';

  @override
  String get authLiaisonsAucune => 'No hay vinculaciones registradas.';

  @override
  String get authLiaisonsConflits => 'Conflictos por resolver';

  @override
  String get authLiaisonsJournal => 'Registro';

  @override
  String get authIssueLieAutomatiquement => 'Vinculada automáticamente';

  @override
  String get authIssueAdministrateurAmorcage => 'Administrador inicial';

  @override
  String get authIssueAucuneCorrespondance => 'Ninguna ficha coincidente';

  @override
  String get authIssueCorrespondanceMultiple => 'Varias fichas coinciden';

  @override
  String get authIssueFicheDejaLiee => 'Ficha ya vinculada a otra cuenta';

  @override
  String get authStatutEnAttente => 'Pendiente';

  @override
  String get authStatutResoluLie => 'Resuelto: cuenta vinculada';

  @override
  String get authStatutResoluRejete =>
      'Resuelto: se mantiene como usuario simple';

  @override
  String get authLiaisonLier => 'Vincular la cuenta';

  @override
  String get authLiaisonRejeter => 'Mantener como usuario simple';

  @override
  String get authLiaisonChoisirFiche => 'Ficha a vincular';

  @override
  String get authLiaisonConfirmation =>
      'Si la ficha está vinculada a otra cuenta, ese vínculo se eliminará y se sustituirá. ¿Confirmar?';

  @override
  String get authConfirmer => 'Confirmar';

  @override
  String get roleUtilisateurSimple => 'Usuario simple';

  @override
  String get roleMembre => 'Miembro';

  @override
  String get roleResponsable => 'Responsable';

  @override
  String get rolePasteur => 'Pastor';

  @override
  String get roleAdministrateur => 'Administrador';

  @override
  String get authLierMonCompte => 'Vincular mi cuenta a esta ficha';

  @override
  String authLierMonCompteConfirmation(String nom) {
    return 'Su cuenta de administrador se vinculará a la ficha de $nom, que tomará el rol de administrador. La vinculación queda registrada y solo se deshace resolviendo un conflicto de vinculación.';
  }

  @override
  String get authLierMonCompteFait => 'Cuenta vinculada a su ficha.';
}
