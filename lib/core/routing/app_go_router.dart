import 'package:firebase_auth/firebase_auth.dart';
import 'package:go_router/go_router.dart';
import 'go_router_refresh_change.dart';
import 'package:netfake/core/routing/app_routes.dart';
import 'package:netfake/features/auth/presentation/pages/login_pages.dart';
import 'package:netfake/features/auth/presentation/pages/signup_pages.dart';
import 'package:netfake/features/home/presentation/pages/main_screen.dart';
import 'package:netfake/features/video/presentation/pages/home_screen.dart';
import 'package:netfake/features/search/presentation/pages/search_screen.dart';
import 'package:netfake/features/rating/presentation/pages/rating_screen.dart';
import 'package:netfake/features/profile/presentation/pages/account_screen.dart';
import 'package:netfake/features/favorites/presentation/pages/favorites_screen.dart';
import 'package:netfake/features/favorites/presentation/pages/watch_video.dart';
import 'package:netfake/features/favorites/presentation/pages/video_detail_screen.dart';
import 'package:netfake/features/video/domain/entities/video.dart';
import 'package:netfake/features/admin/presentation/page/admin_page.dart';
import 'package:netfake/features/admin/presentation/page/search_video.dart';
class AppGoRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.login, // <-- bắt đầu từ login
    debugLogDiagnostics: true,
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.signup,
        builder: (context, state) => const SignupPages(),
      ),
      ShellRoute(
        builder: (context, state, child) => MainScreen(child: child),
        routes: [
          GoRoute(
            path: AppRoutes.home,
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: AppRoutes.favorites,
            builder: (context, state) => const FavoriteScreen(),
          ),
          GoRoute(
            path: AppRoutes.rating,
            builder: (context, state) => const RatingScreen(),
          ),
          GoRoute(
            path: AppRoutes.profile,
            builder: (context, state) =>  AccountScreen(),
          ),
        ],
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.watch, // hoặc '/watch/:id' nếu muốn dùng path param
        builder: (context, state) {
          final video = state.extra as Video; // Lấy video từ extra
          return VideoPlayerScreen(video: video); // Truyền vào màn hình
          },
      ),
      GoRoute(
        path: AppRoutes.detail, // hoặc '/watch/:id' nếu muốn dùng path param
        builder: (context, state) {
          final video = state.extra as Video; // Lấy video từ extra
          return VideoDetailScreen(video: video,); // Truyền vào màn hình
          },
      ),
       GoRoute(
        path: AppRoutes.admin, // hoặc '/watch/:id' nếu muốn dùng path param
        builder: (context, state) {
          return AdminScreen(); // Truyền vào màn hình
          },
      ),
      GoRoute(
        path: AppRoutes.searchAdmin,
        builder: (context, state) => const SearchScreenAdmin(),
      ),
    ],
    redirect: (context, GoRouterState state) {
      final user = FirebaseAuth.instance.currentUser;
      final loggedIn = user != null;

      // dùng state.uri.path để check page
      final loggingIn = state.uri.path == AppRoutes.login ||
                        state.uri.path == AppRoutes.signup;

      if (!loggedIn && !loggingIn) return AppRoutes.login;
      if (loggedIn && loggingIn) return AppRoutes.home;
      return null;
    },
    refreshListenable: GoRouterRefreshStream(FirebaseAuth.instance.authStateChanges()),
  );
}
