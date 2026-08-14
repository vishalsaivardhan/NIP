import 'package:go_router/go_router.dart';
import 'package:nip/features/splash/splash_screen.dart';
import 'package:nip/features/onboarding/onboarding_screen.dart';
import 'package:nip/features/dashboard/dashboard_screen.dart';
import 'package:nip/features/wallet/wallet_screen.dart';
import 'package:nip/features/payments/pay_screen.dart';
import 'package:nip/features/receive/receive_screen.dart';
import 'package:nip/features/bluetooth/nearby_devices_screen.dart';
import 'package:nip/features/mesh/mesh_screen.dart';
import 'package:nip/features/transactions/transactions_screen.dart';
import 'package:nip/features/transactions/transaction_detail_screen.dart';
import 'package:nip/features/gateway/gateway_screen.dart';
import 'package:nip/features/security/security_screen.dart';
import 'package:nip/features/settings/settings_screen.dart';
import 'package:nip/features/demo/demo_screen.dart';
import 'package:nip/widgets/app_shell.dart';

/// Application router with GoRouter
/// Provides bottom navigation shell for main tabs
final appRouter = GoRouter(
  initialLocation: '/onboarding',
  routes: [
    // Splash (standalone, no bottom nav)
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),

    // Onboarding (standalone, no bottom nav)
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),

    // Main shell with bottom navigation
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        GoRoute(
          path: '/',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: DashboardScreen()),
        ),
        GoRoute(
          path: '/wallet',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: WalletScreen()),
        ),
        GoRoute(
          path: '/transactions',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: TransactionsScreen()),
        ),
        GoRoute(
          path: '/mesh',
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: MeshScreen()),
        ),
      ],
    ),

    // Non-tabbed routes (push on top of shell)
    GoRoute(path: '/pay', builder: (context, state) => const PayScreen()),
    GoRoute(
      path: '/receive',
      builder: (context, state) => const ReceiveScreen(),
    ),
    GoRoute(
      path: '/nearby',
      builder: (context, state) => const NearbyDevicesScreen(),
    ),
    GoRoute(
      path: '/transactions/:id',
      builder: (context, state) =>
          TransactionDetailScreen(transactionId: state.pathParameters['id']!),
    ),
    GoRoute(
      path: '/gateway',
      builder: (context, state) => const GatewayScreen(),
    ),
    GoRoute(
      path: '/security',
      builder: (context, state) => const SecurityScreen(),
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(),
    ),
    GoRoute(path: '/demo', builder: (context, state) => const DemoScreen()),
  ],
);
