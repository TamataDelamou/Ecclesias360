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
}
