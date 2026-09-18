import 'package:go_router/go_router.dart';

import '../../features/comite/presentation/membres_comite_screen.dart';
import '../../features/comite/presentation/seance_detail_screen.dart';
import '../../features/comite/presentation/seance_form_screen.dart';
import '../../features/comite/presentation/seances_comite_list_screen.dart';
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
import '../../features/groupes_eglise/presentation/fidele_groupes_screen.dart';
import '../../features/groupes_eglise/presentation/groupe_membres_screen.dart';
import '../../features/groupes_eglise/presentation/groupe_regles_screen.dart';
import '../../features/groupes_eglise/presentation/groupes_eglise_list_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/ministeres/presentation/mandats_echeance_screen.dart';
import '../../features/ministeres/presentation/ministere_detail_screen.dart';
import '../../features/ministeres/presentation/ministere_form_screen.dart';
import '../../features/ministeres/presentation/ministere_historique_responsables_screen.dart';
import '../../features/ministeres/presentation/ministere_journal_screen.dart';
import '../../features/ministeres/presentation/ministere_membres_screen.dart';
import '../../features/ministeres/presentation/ministeres_list_screen.dart';
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
import '../../features/parametres/presentation/zones_geographiques_screen.dart';
import '../constants/app_routes.dart';

final GoRouter appRouter = GoRouter(
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
      path: AppRoutes.fideles,
      builder: (context, state) => const FideleListScreen(),
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
  ],
);
