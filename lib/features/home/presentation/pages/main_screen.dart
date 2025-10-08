import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:netfake/features/video/presentation/pages/home_screen.dart';
import 'package:netfake/features/search/presentation/pages/search_screen.dart';
import '../../../../core/presentation/widget/app_drawer.dart';
import '../../../profile/presentation/pages/account_screen.dart';
import '../../../rating/presentation/pages/rating_screen.dart';
import '../../../favorites/presentation/pages/favorites_screen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
    HomeScreen(),
    FavoriteScreen(),
    RatingScreen(),
    AccountScreen(),
  ];
    return Scaffold(
      drawer: AppDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          children: [
            SvgPicture.asset(
                'assets/Logo.svg',
                width: 40,
                height: 40,
              ),
            // SizedBox(width: 40, height: 40, child: Placeholder()),
            const SizedBox(width: 10),
            Text(
              "NetFake",
              style: TextStyle(
                fontSize: 25.sp,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Spacer(), 
            IconButton(onPressed: (){
              Navigator.push(context,
               MaterialPageRoute(builder: (context) =>SearchScreen()),);
            },
            icon:Icon(Icons.search))
          ],
        ),
      ),
      body: _pages[_selectedIndex], // hiển thị nội dung tab
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Trang chủ"),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark), label: "Yêu thích"),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: "Xếp hạng"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Tài khoản"),
        ],
      ),
    );
  }
}
