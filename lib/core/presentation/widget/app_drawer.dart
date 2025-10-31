import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:netfake/features/auth/presentation/provider/auth_provider.dart';
import 'package:go_router/go_router.dart';
import '/core/routing/app_routes.dart';
// import 'package:firebase_auth/firebase_auth.dart';

class AppDrawer extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authControllerProvider).value;
    return Drawer(
      backgroundColor: Colors.black,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(color: Colors.black),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person, size: 40, color: Colors.black),
            ),
            accountName: Text(
              user?.displayName ?? "No Name",
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              user?.email ?? "No Email",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.white),
            title: Text("Trang chủ", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go(AppRoutes.home); // Chuyển trang
            },
          ),
          ListTile(
            leading: Icon(Icons.bookmark, color: Colors.white),
            title: Text("Tủ phim", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go(AppRoutes.favorites); // Chuyển trang
            },
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.white),
            title: Text("Xếp hạng", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go(AppRoutes.rating); // Chuyển trang
            },
          ),
          ListTile(
            leading: Icon(Icons.person_outline, color: Colors.white),
            title: Text("Tài khoản", style: TextStyle(color: Colors.white)),
            onTap: () {
              Navigator.pop(context);
              context.go(AppRoutes.profile); // Chuyển trang
            },
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text("Đăng xuất", style: TextStyle(color: Colors.white)),
            onTap: () async {
              Navigator.pop(context);
              final authController = ref.read(authControllerProvider.notifier);
              await authController.signOut();
            },
          ),
        ],
      ),
    );
  }
}
