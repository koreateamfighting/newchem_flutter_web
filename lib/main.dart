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
  int _selectedIndex = 0; //default는 0
  int _companyTabIndex = 0; // Company 페이지의 탭 상태를 유지할 변수

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
      CompanyPage(
        selectedTabIndex: _companyTabIndex, // 전달된 탭 인덱스
        onTabChanged: (int tabIndex) {
          setState(() {
            _companyTabIndex = tabIndex; // 선택된 탭 인덱스를 저장
          });
        },
      ), // 1: Company 화면
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

  void _navigateToCompanyTab(int tabIndex) {
    setState(() {
      _companyTabIndex = tabIndex; // Company 탭 상태 변경
      _selectedIndex = 1; // CompanyPage로 이동
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(
        onWillPop: () async {
          if (_selectedIndex != 0) {
            setState(() {
              _selectedIndex = 0; // 뒤로 가기를 눌렀을 때 홈 화면으로 이동
            });
            return false; // 앱 종료 방지
          }
          return true; // 앱 종료
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
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
      ),
    );
  }
}