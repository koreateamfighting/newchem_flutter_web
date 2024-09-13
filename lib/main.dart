import 'package:flutter/material.dart';
import 'package:newchem_flutter_website/download_screen.dart';
import 'company_screen.dart';  // CompanyPage 파일 import
import 'home_screen.dart';
import 'product_screen.dart';
import 'contact_screen.dart';
import 'download_screen.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _selectedIndex = 0;

  // 화면을 바꿀 때 표시할 내용 리스트
  final List<Widget> _pages = [
    HomePage(),       // 0: Home 화면
    CompanyPage(),    // 1: Company 화면 (변경된 페이지)
    ProductScreen(),   // 2: Products 화면
    ContactScreen(),    // 3: Contact Us 화면
    DownloadScreen(),  // 4: Downloads 화면
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset('assets/logo.png', height: 50),
          actions: [
            TextButton(onPressed: () => _onItemTapped(0), child: Text("HOME")),
            TextButton(onPressed: () => _onItemTapped(1), child: Text("COMPANY")),
            TextButton(onPressed: () => _onItemTapped(2), child: Text("PRODUCTS")),
            TextButton(onPressed: () => _onItemTapped(3), child: Text("CONTACT US")),
            TextButton(onPressed: () => _onItemTapped(4), child: Text("DOWNLOADS")),
          ],
        ),
        body: _pages[_selectedIndex], // 선택한 화면을 body에 보여줌
      ),
    );
  }
}




