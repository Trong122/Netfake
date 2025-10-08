import 'package:flutter/material.dart';
class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
              "Nguyễn Văn A",
              style: TextStyle(color: Colors.white),
            ),
            accountEmail: Text(
              "NVA@gmail.com",
              style: TextStyle(color: Colors.grey),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home, color: Colors.white),
            title: Text("Trang chủ", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.bookmark, color: Colors.white),
            title: Text("Tủ phim", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.star, color: Colors.white),
            title: Text("Xếp hạng", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.person_outline, color: Colors.white),
            title: Text("Tài khoản", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
          ListTile(
            leading: Icon(Icons.logout, color: Colors.white),
            title: Text("Đăng xuất", style: TextStyle(color: Colors.white)),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}