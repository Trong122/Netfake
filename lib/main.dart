import 'package:flutter/material.dart';
import 'features/home/presentation/pages/main_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // kích thước thiết kế gốc
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.dark(), // chủ đề tối
          home: child, // đây là màn hình chính
        
        );
      },
      child: const MainScreen(), // màn hình chính của app
    );
  }
}