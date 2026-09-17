import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/organization/presentation/church_directory_screen.dart';
import '../../features/organization/presentation/hierarchy_screen.dart';
import '../../features/organization/presentation/node_detail_screen.dart';
import '../../features/organization/presentation/node_form_screen.dart';
import '../../features/organization/presentation/rattachement_history_screen.dart';
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
  ],
);
