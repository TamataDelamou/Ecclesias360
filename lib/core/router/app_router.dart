import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/application/session_controller.dart';
import '../../features/auth/presentation/connexion_screen.dart';
import '../../features/auth/presentation/liaisons_comptes_screen.dart';
import '../../features/auth/presentation/verification_code_screen.dart';
import '../../features/parametres/domain/models/role.dart';

import '../../features/archivage/presentation/corbeille_documents_screen.dart';
import '../../features/archivage/presentation/document_archive_detail_screen.dart';
import '../../features/archivage/presentation/documents_archive_list_screen.dart';
import '../../features/comite/presentation/membres_comite_screen.dart';
import '../../features/comptabilite/presentation/comptabilite_screen.dart';
import '../../features/comite/presentation/seance_detail_screen.dart';
import '../../features/comite/presentation/seance_form_screen.dart';
import '../../features/comite/presentation/seances_comite_list_screen.dart';
import '../../features/cultes/presentation/culte_detail_screen.dart';
import '../../features/cultes/presentation/culte_form_screen.dart';
import '../../features/cultes/presentation/cultes_list_screen.dart';
import '../../features/cultes/presentation/propositions_theme_screen.dart';
import '../../features/deplacements/presentation/mutation_detail_screen.dart';
import '../../features/deplacements/presentation/mutations_list_screen.dart';
import '../../features/discipline/presentation/dossier_disciplinaire_detail_screen.dart';
import '../../features/discipline/presentation/dossiers_disciplinaires_list_screen.dart';
import '../../features/finances/presentation/contribution_detail_screen.dart';
import '../../features/finances/presentation/contributions_list_screen.dart';
import '../../features/finances/presentation/engagements_du_noeud_screen.dart';
import '../../features/finances/presentation/engagements_list_screen.dart';
import '../../features/finances/presentation/projet_detail_screen.dart';
import '../../features/finances/presentation/projets_list_screen.dart';
import '../../features/finances/presentation/tresoriers_noeud_screen.dart';
import '../../features/patrimoine/presentation/bien_detail_screen.dart';
import '../../features/patrimoine/presentation/biens_list_screen.dart';
import '../../features/patrimoine/presentation/campagne_detail_screen.dart';
import '../../features/patrimoine/presentation/campagnes_inventaire_screen.dart';
import '../../features/dons_spirituels/presentation/don_evaluation_form_screen.dart';
import '../../features/dons_spirituels/presentation/don_historique_screen.dart';
import '../../features/dons_spirituels/presentation/don_ministeres_compatibles_screen.dart';
import '../../features/dons_spirituels/presentation/dons_fidele_list_screen.dart';
import '../../features/dons_spirituels/presentation/dons_referentiel_screen.dart';
import '../../features/dons_spirituels/presentation/dons_statistiques_screen.dart';
import '../../features/fideles/presentation/fidele_detail_screen.dart';
import '../../features/fideles/presentation/fidele_form_screen.dart';
import '../../features/fideles/presentation/fidele_history_screen.dart';
import '../../features/fideles/presentation/fidele_list_screen.dart';
import '../../features/fideles/presentation/note_pastorale_detail_screen.dart';
import '../../features/fideles/presentation/notes_pastorales_screen.dart';
import '../../features/groupes_eglise/presentation/fidele_groupes_screen.dart';
import '../../features/groupes_eglise/presentation/groupe_membres_screen.dart';
import '../../features/groupes_eglise/presentation/groupe_regles_screen.dart';
import '../../features/groupes_eglise/presentation/groupes_eglise_list_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/parametres/presentation/parametres_screen.dart';
import '../../features/ministeres/presentation/mandats_echeance_screen.dart';
import '../../features/ministeres/presentation/ministere_detail_screen.dart';
import '../../features/ministeres/presentation/ministere_form_screen.dart';
import '../../features/ministeres/presentation/ministere_historique_responsables_screen.dart';
import '../../features/ministeres/presentation/ministere_journal_screen.dart';
import '../../features/ministeres/presentation/ministere_membres_screen.dart';
import '../../features/ministeres/presentation/ministeres_list_screen.dart';
import '../../features/mediatheque/presentation/contenu_mediatheque_detail_screen.dart';
import '../../features/mediatheque/presentation/favoris_mediatheque_screen.dart';
import '../../features/mediatheque/presentation/mediatheque_catalogue_screen.dart';
import '../../features/mediatheque/presentation/moderation_commentaires_screen.dart';
import '../../features/organization/presentation/church_directory_screen.dart';
import '../../features/organization/presentation/hierarchy_screen.dart';
import '../../features/organization/presentation/node_detail_screen.dart';
import '../../features/organization/presentation/node_form_screen.dart';
import '../../features/organization/presentation/node_responsables_screen.dart';
import '../../features/organization/presentation/rattachement_history_screen.dart';
import '../../features/parametres/presentation/roles_screen.dart';
import '../../features/professions/presentation/fidele_competences_screen.dart';
import '../../features/professions/presentation/profession_groupe_screen.dart';
import '../../features/professions/presentation/professions_list_screen.dart';
import '../../features/parametres/presentation/journal_parametres_screen.dart';
import '../../features/parametres/presentation/zones_geographiques_screen.dart';
import '../constants/app_routes.dart';
import '../widgets/app_shell.dart';
import 'app_transitions.dart';

/// Garde d'accès (RG-SEC-01) : aucune route applicative n'est accessible
/// sans session ; la session restaurée hors ligne (RG-OFF) suffit.
String? redirectionSession(SessionController session, String location) {
  final surConnexion = location.startsWith(AppRoutes.connexion);
  if (session.etat == EtatSession.chargement) {
    return location == AppRoutes.chargement ? null : AppRoutes.chargement;
  }
  if (!session.estConnecte) return surConnexion ? null : AppRoutes.connexion;
  if (surConnexion || location == AppRoutes.chargement) return AppRoutes.home;
  // RG-XXIII-06 : administration des paramètres réservée à l'administrateur.
  const reservesAdministrateur = [
    AppRoutes.liaisonsComptes,
    AppRoutes.zonesGeographiques,
    AppRoutes.journalParametres,
  ];
  if (reservesAdministrateur.contains(location) && !session.peut(Role.administrateur)) {
    return AppRoutes.parametres;
  }
  return null;
}

GoRouter creerAppRouter(SessionController session) => GoRouter(
  refreshListenable: session.garde,
  redirect: (context, state) => redirectionSession(session, state.matchedLocation),
  routes: [
    GoRoute(
      path: AppRoutes.chargement,
      builder: (context, state) => const Scaffold(body: Center(child: CircularProgressIndicator())),
    ),
    GoRoute(
      path: AppRoutes.connexion,
      builder: (context, state) => const ConnexionScreen(),
      routes: [
        GoRoute(
          path: 'verification',
          builder: (context, state) => const VerificationCodeScreen(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.liaisonsComptes,
      builder: (context, state) => const LiaisonsComptesScreen(),
    ),
    ShellRoute(
      builder: (context, state, child) => AppShell(location: state.uri.path, child: child),
      routes: [
        GoRoute(
          path: AppRoutes.home,
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: AppRoutes.organisation,
          builder: (context, state) => const HierarchyScreen(),
        ),
        GoRoute(
          path: AppRoutes.fideles,
          builder: (context, state) => const FideleListScreen(),
        ),
        GoRoute(
          path: AppRoutes.parametres,
          builder: (context, state) => const ParametresScreen(),
        ),
      ],
    ),
    GoRoute(
      path: AppRoutes.organisationNouveauNoeud,
      builder: (context, state) => NodeFormScreen(parentId: state.uri.queryParameters['parent']),
    ),
    GoRoute(
      path: AppRoutes.organisationAnnuaireEglises,
      builder: (context, state) => const ChurchDirectoryScreen(),
    ),
    GoRoute(
      path: '/organisation/:id',
      builder: (context, state) => NodeDetailScreen(nodeId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/organisation/:id/modifier',
      builder: (context, state) => NodeFormScreen(nodeId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/organisation/:id/historique',
      builder: (context, state) => RattachementHistoryScreen(nodeId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/organisation/:id/responsables',
      builder: (context, state) => NodeResponsablesScreen(nodeId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: AppRoutes.fidelesNouveau,
      builder: (context, state) => const FideleFormScreen(),
    ),
    GoRoute(
      path: '/fideles/:id',
      builder: (context, state) => FideleDetailScreen(fideleId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/fideles/:id/notes-pastorales',
      builder: (context, state) => NotesPastoralesScreen(fideleId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/notes-pastorales/:id',
      builder: (context, state) => NotePastoraleDetailScreen(noteId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/fideles/:id/historique',
      builder: (context, state) => FideleHistoryScreen(fideleId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: AppRoutes.zonesGeographiques,
      builder: (context, state) => const ZonesGeographiquesScreen(),
    ),
    GoRoute(
      path: AppRoutes.roles,
      builder: (context, state) => const RolesScreen(),
    ),
    GoRoute(
      path: AppRoutes.journalParametres,
      builder: (context, state) => const JournalParametresScreen(),
    ),
    GoRoute(
      path: '/organisation/:id/ministeres',
      builder: (context, state) => MinisteresListScreen(noeudId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/organisation/:id/ministeres/nouveau',
      builder: (context, state) => MinistereFormScreen(noeudId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: AppRoutes.mandatsEcheance,
      builder: (context, state) => const MandatsEcheanceScreen(),
    ),
    GoRoute(
      path: '/ministeres/:id',
      builder: (context, state) => MinistereDetailScreen(ministereId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/ministeres/:id/membres',
      builder: (context, state) => MinistereMembresScreen(ministereId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/ministeres/:id/historique-responsables',
      builder: (context, state) =>
          MinistereHistoriqueResponsablesScreen(ministereId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/ministeres/:id/journal',
      builder: (context, state) => MinistereJournalScreen(ministereId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: AppRoutes.donsReferentiel,
      builder: (context, state) => const DonsReferentielScreen(),
    ),
    GoRoute(
      path: '/fideles/:fideleId/dons',
      builder: (context, state) => DonsFideleListScreen(fideleId: state.pathParameters['fideleId']!),
    ),
    GoRoute(
      path: '/fideles/:fideleId/dons/:donId',
      builder: (context, state) => DonHistoriqueScreen(
        fideleId: state.pathParameters['fideleId']!,
        donId: state.pathParameters['donId']!,
      ),
    ),
    GoRoute(
      path: '/fideles/:fideleId/dons/:donId/evaluer',
      builder: (context, state) => DonEvaluationFormScreen(
        fideleId: state.pathParameters['fideleId']!,
        donId: state.pathParameters['donId']!,
      ),
    ),
    GoRoute(
      path: '/fideles/:fideleId/dons/:donId/ministeres-compatibles',
      builder: (context, state) => DonMinisteresCompatiblesScreen(
        fideleId: state.pathParameters['fideleId']!,
        donId: state.pathParameters['donId']!,
      ),
    ),
    GoRoute(
      path: '/organisation/:id/dons-statistiques',
      builder: (context, state) => DonsStatistiquesScreen(noeudId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: AppRoutes.professions,
      builder: (context, state) => const ProfessionsListScreen(),
    ),
    GoRoute(
      path: '/professions/:id',
      builder: (context, state) => ProfessionGroupeScreen(professionId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/fideles/:fideleId/competences',
      builder: (context, state) => FideleCompetencesScreen(fideleId: state.pathParameters['fideleId']!),
    ),
    GoRoute(
      path: AppRoutes.groupesEglise,
      builder: (context, state) => const GroupesEgliseListScreen(),
    ),
    GoRoute(
      path: '/groupes-eglise/:id/membres',
      builder: (context, state) => GroupeMembresScreen(groupeId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/groupes-eglise/:id/regles',
      builder: (context, state) => GroupeReglesScreen(groupeId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/fideles/:fideleId/groupes',
      builder: (context, state) => FideleGroupesScreen(fideleId: state.pathParameters['fideleId']!),
    ),
    GoRoute(
      path: '/organisation/:id/comite/membres',
      builder: (context, state) => MembresComiteScreen(noeudId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/organisation/:id/comite/seances',
      builder: (context, state) => SeancesComiteListScreen(noeudId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/organisation/:id/comite/seances/nouvelle',
      builder: (context, state) => SeanceFormScreen(noeudId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/comite/seances/:id',
      builder: (context, state) => SeanceDetailScreen(seanceId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/organisation/:id/cultes',
      builder: (context, state) => CultesListScreen(noeudId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/organisation/:id/cultes/nouveau',
      builder: (context, state) => CulteFormScreen(noeudId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/cultes/:id',
      builder: (context, state) => CulteDetailScreen(culteId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: AppRoutes.propositionsTheme,
      builder: (context, state) => const PropositionsThemeScreen(),
    ),
    GoRoute(
      path: '/organisation/:id/documents',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: DocumentsArchiveListScreen(noeudId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/organisation/:id/documents/corbeille',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: CorbeilleDocumentsScreen(noeudId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/documents/:id',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: DocumentArchiveDetailScreen(documentId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/organisation/:id/mutations',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: MutationsListScreen(noeudId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/fideles/:id/mutations',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: MutationsListScreen(fideleId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/mutations/:id',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: MutationDetailScreen(mutationId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/organisation/:id/discipline',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: DossiersDisciplinairesListScreen(noeudId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/fideles/:id/discipline',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: DossiersDisciplinairesListScreen(fideleId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/dossiers-disciplinaires/:id',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: DossierDisciplinaireDetailScreen(dossierId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/organisation/:id/finances',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: ContributionsListScreen(noeudId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/fideles/:id/finances',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: ContributionsListScreen(fideleId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/contributions/:id',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: ContributionDetailScreen(contributionId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/organisation/:id/tresoriers',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: TresoriersNoeudScreen(noeudId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/organisation/:id/projets',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: ProjetsListScreen(noeudId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/projets/:id',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: ProjetDetailScreen(projetId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/fideles/:id/engagements',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: EngagementsListScreen(fideleId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/organisation/:id/engagements',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: EngagementsDuNoeudScreen(noeudId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/organisation/:id/biens',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: BiensListScreen(noeudId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/biens/:id',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: BienDetailScreen(bienId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/organisation/:id/campagnes-inventaire',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: CampagnesInventaireScreen(noeudId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/campagnes-inventaire/:id',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: CampagneDetailScreen(campagneId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/organisation/:id/comptabilite',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: ComptabiliteScreen(noeudId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: AppRoutes.mediatheque,
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: const MediathequeCatalogueScreen(),
      ),
    ),
    // Avant '/mediatheque/:id', qui capturerait « moderation ».
    GoRoute(
      path: AppRoutes.mediathequeModeration,
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: const ModerationCommentairesScreen(),
      ),
    ),
    GoRoute(
      path: '/mediatheque/:id',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: ContenuMediathequeDetailScreen(contenuId: state.pathParameters['id']!),
      ),
    ),
    GoRoute(
      path: '/fideles/:id/favoris-mediatheque',
      pageBuilder: (context, state) => sharedAxisPage(
        key: state.pageKey,
        child: FavorisMediathequeScreen(fideleId: state.pathParameters['id']!),
      ),
    ),
  ],
);
