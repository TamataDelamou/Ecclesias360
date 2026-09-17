import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import '../constants/app_routes.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
  ],
);
