import 'package:flutter/material.dart';
import 'package:newchem_flutter_website/download_screen.dart';
import 'company_screen.dart'; // CompanyPage 파일 import
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

  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(
        onNavigate: (int index) {
          _onItemTapped(index); // HomePage에서 받은 index로 페이지 전환
        },
      ), // 0: Home 화면
      CompanyPage(), // 1: Company 화면
      ProductScreen(), // 2: Products 화면
      ContactScreen(), // 3: Contact Us 화면
      DownloadScreen(), // 4: Downloads 화면
    ];
  }

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
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: IconButton(
            icon: Image.asset('assets/logo.png'), // 이미지를 아이콘으로 사용
            iconSize: MediaQuery.of(context).size.width * 0.1, // 화면 크기에 맞춰 아이콘 크기 조정
            onPressed: () => _onItemTapped(0), // 클릭 시 홈 화면으로 이동
          ),
          actions: [
            SizedBox(width: MediaQuery.of(context).size.width * 0.05),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, // 가로로 스크롤 가능하게 설정
              child: Wrap(
                spacing: MediaQuery.of(context).size.width * 0.03, // 버튼 간격 설정
                children: [
                  TextButton(
                    onPressed: () => _onItemTapped(0),
                    child: Text("HOME"),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black, // 텍스트 색상을 검은색으로 설정
                    ),
                  ),
                  TextButton(
                    onPressed: () => _onItemTapped(1),
                    child: Text("COMPANY"),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black, // 텍스트 색상을 검은색으로 설정
                    ),
                  ),
                  TextButton(
                    onPressed: () => _onItemTapped(2),
                    child: Text("PRODUCTS"),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black, // 텍스트 색상을 검은색으로 설정
                    ),
                  ),
                  TextButton(
                    onPressed: () => _onItemTapped(3),
                    child: Text("CONTACT US"),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black, // 텍스트 색상을 검은색으로 설정
                    ),
                  ),
                  TextButton(
                    onPressed: () => _onItemTapped(4),
                    child: Text("DOWNLOADS"),
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.black, // 텍스트 색상을 검은색으로 설정
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: MediaQuery.of(context).size.width * 0.03),
          ],
        ),
        body: _pages[_selectedIndex], // 선택한 화면을 body에 보여줌
      ),
    );
  }
}
