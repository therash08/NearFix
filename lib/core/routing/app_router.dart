import 'package:go_router/go_router.dart';
import '../../features/auth/presentation/screens/role_selection_screen.dart';
import '../../features/auth/presentation/screens/splash_screen.dart';
import '../../features/auth/presentation/screens/user_login_screen.dart';
import '../../features/auth/presentation/screens/provider_login_screen.dart';
import '../../features/auth/presentation/screens/admin_login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../core/auth/auth_model.dart';
import '../../features/user_app/presentation/screens/main_navigation_screen.dart';
import '../../features/provider_app/presentation/screens/provider_dashboard_screen.dart';
import '../../features/provider_app/presentation/screens/provider_add_service_screen.dart';
import '../../features/provider_app/presentation/screens/provider_services_screen.dart';
import '../../features/provider_app/presentation/screens/provider_bookings_screen.dart';
import '../../features/provider_app/presentation/screens/provider_profile_edit_screen.dart';
import '../../features/admin_panel/presentation/screens/admin_dashboard_screen.dart';
import '../../features/user_app/presentation/screens/search_service_screen.dart';
// service detail and booking confirm are opened via Navigator.push

final appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),
    GoRoute(
      path: '/role-selection',
      builder: (context, state) => const RoleSelectionScreen(),
    ),
    GoRoute(
      path: '/login-user',
      builder: (context, state) => const UserLoginScreen(),
    ),
    GoRoute(
      path: '/login-provider',
      builder: (context, state) => const ProviderLoginScreen(),
    ),
    GoRoute(
      path: '/signup-user',
      builder: (context, state) => const SignupScreen(role: UserRole.user),
    ),
    GoRoute(
      path: '/signup-provider',
      builder: (context, state) => const SignupScreen(role: UserRole.provider),
    ),
    GoRoute(
      path: '/signup-admin',
      builder: (context, state) => const SignupScreen(role: UserRole.admin),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const MainNavigationScreen(),
    ),
    GoRoute(
      path: '/services',
      builder: (context, state) => const SearchServiceScreen(),
    ),

    GoRoute(
      path: '/provider-dashboard',
      builder: (context, state) => const ProviderDashboardScreen(),
    ),
    GoRoute(
      path: '/provider/add-service',
      builder: (context, state) => const ProviderAddServiceScreen(),
    ),
    GoRoute(
      path: '/provider/services',
      builder: (context, state) => const ProviderServicesScreen(),
    ),
    GoRoute(
      path: '/provider/bookings',
      builder: (context, state) => const ProviderBookingsScreen(),
    ),
    GoRoute(
      path: '/provider/profile',
      builder: (context, state) => const ProviderProfileEditScreen(),
    ),
    GoRoute(
      path: '/admin-login',
      builder: (context, state) => const AdminLoginScreen(),
    ),
    GoRoute(
      path: '/admin-dashboard',
      builder: (context, state) => const AdminDashboardScreen(),
    ),
  ],
);
