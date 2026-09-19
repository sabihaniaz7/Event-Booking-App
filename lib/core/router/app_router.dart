import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/admin/presentation/widgets/admin_shell.dart';
import '../../features/auth/presentation/controllers/auth_controller.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/signup_screen.dart';
import '../../features/booking/presentation/screens/book_ticket_screen.dart';
import '../../features/booking/presentation/screens/event_detail_screen.dart';
import '../../features/booking/presentation/screens/my_booking_screen.dart';
import '../../features/home/presentation/screens/browse_events_screens.dart';
import '../../features/home/presentation/screens/home_screen.dart';

// Other screens (Home, Events, Booking, etc.) are wired as lightweight
// stubs below so this router compiles and runs today — each stub gets
// replaced with the real screen in the upcoming deliveries.

class AppRoutes {
  AppRoutes._();
  static const login = '/login';
  static const signup = '/signup';
  static const home = '/home';
  static const eventDetails = '/event/:id';
  static const booking = '/event/:id/book';
  static const browse = '/browse';
  static const myBookings = '/my-bookings';
  static const profile = '/profile';
  static const admin = '/admin';
}

/// Riverpod provider so screens/tests can read the router,
/// and so it can watch authControllerProvider for redirects.
final appRouterProvider = Provider<GoRouter>((ref) {
  // `refreshListenable` re-runs `redirect` whenever auth state changes
  // (login, logout, token expiry) — without this, go_router only checks
  // redirects on navigation, not on state changes.
  final authListenable = _AuthChangeNotifier(ref);

  return GoRouter(
    initialLocation: AppRoutes.login,
    refreshListenable: authListenable,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final isLoggedIn = authState.value != null;
      final isAdmin = authState.value?.isAdmin ?? false;
      final loggingInOrOut =
          state.matchedLocation == AppRoutes.login ||
          state.matchedLocation == AppRoutes.signup;

      // Still resolving the initial getCurrentUser() call — don't redirect yet.
      if (authState.isLoading) return null;

      if (!isLoggedIn && !loggingInOrOut) return AppRoutes.login;
      if (isLoggedIn && loggingInOrOut) {
        return isAdmin ? AppRoutes.admin : AppRoutes.home;
      }
      // Non-admin trying to reach admin routes.
      if (state.matchedLocation.startsWith(AppRoutes.admin) && !isAdmin) {
        return AppRoutes.home;
      }
      return null;
    },
    routes: [
      GoRoute(path: AppRoutes.login, builder: (_, _) => const LoginScreen()),
      GoRoute(path: AppRoutes.signup, builder: (_, _) => const SignupScreen()),
      GoRoute(path: AppRoutes.home, builder: (_, _) => const HomeScreen()),
      GoRoute(
        path: AppRoutes.browse,
        builder: (_, _) => const BrowseEventsScreen(),
      ),
      GoRoute(
        path: AppRoutes.eventDetails,
        builder: (_, state) =>
            EventDetailsScreen(eventId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.booking,
        builder: (_, state) =>
            BookTicketScreen(eventId: state.pathParameters['id']!),
      ),
      GoRoute(
        path: AppRoutes.myBookings,
        builder: (_, _) => const MyBookingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (_, _) => const _StubScreen('Profile'),
      ),
      GoRoute(path: AppRoutes.admin, builder: (_, _) => const AdminShell()),
    ],
  );
});

class _AuthChangeNotifier extends ChangeNotifier {
  _AuthChangeNotifier(this.ref) {
    ref.listen(authControllerProvider, (_, _) => notifyListeners());
  }
  final Ref ref;
}

class _StubScreen extends StatelessWidget {
  const _StubScreen(this.label);
  final String label;
  @override
  Widget build(BuildContext context) =>
      Scaffold(body: Center(child: Text('$label — coming next')));
}
