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
  int _selectedIndex = 0; // default는 Home 페이지
  int _companyTabIndex = 0; // Company 페이지의 탭 상태를 유지할 변수
  int _productTabIndex = 0; // Product 페이지의 탭 상태를 유지할 변수
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    // 초기 화면 목록 설정
    _pages = [
      HomePage(
        onNavigate: (int index) {
          _onItemTapped(index);
        },
        onProductNavigate: (int tabIndex) {
          _navigateToProductTab(tabIndex); // HomePage에서 탭 인덱스 전달받음
        },
        onCompanyNavigate: (int tabIndex) {
          _navigateToCompanyTab(tabIndex); // CompanyPage에서 탭 인덱스 전달받음
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
      ProductScreen(
        initialTabIndex: _productTabIndex, // 전달된 탭 인덱스로 ProductScreen 열기
      ), // 2: Products 화면
      ContactScreen(), // 3: Contact Us 화면
      DownloadScreen(), // 4: Downloads 화면
    ];
  }

  // 페이지 전환 시 실행되는 함수
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _navigateToPage(index);
  }

  void _navigateToPage(int index) {
    Navigator.of(context).push(PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) => _pages[index],
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        const begin = Offset(1.0, 0.0); // 화면 오른쪽에서 왼쪽으로 슬라이드
        const end = Offset.zero;
        const curve = Curves.easeInOut;

        var tween =
            Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
        var offsetAnimation = animation.drive(tween);

        return SlideTransition(
          position: offsetAnimation,
          child: child,
        );
      },
    ));
  }

  // ProductScreen으로 이동할 때 호출
  void _navigateToProductTab(int tabIndex) {
    setState(() {
      _productTabIndex = tabIndex; // Product 탭 상태 변경
      _selectedIndex = 2; // ProductScreen으로 이동
      _updateProductScreen(); // 페이지 새로고침
    });
  }

  // CompanyPage로 이동할 때 호출
  void _navigateToCompanyTab(int tabIndex) {
    setState(() {
      _companyTabIndex = tabIndex; // Company 탭 상태 변경
      _selectedIndex = 1; // CompanyPage로 이동
      _updateCompanyPage(); // 페이지 새로고침
    });
  }

  // ProductScreen을 새로고침하는 함수
  void _updateProductScreen() {
    _pages[2] = ProductScreen(
      initialTabIndex: _productTabIndex, // 현재 선택된 Product 탭 인덱스 반영
    );
  }

  // CompanyPage를 새로고침하는 함수
  void _updateCompanyPage() {
    _pages[1] = CompanyPage(
      selectedTabIndex: _companyTabIndex, // 현재 선택된 Company 탭 인덱스 반영
      onTabChanged: (int tabIndex) {
        setState(() {
          _companyTabIndex = tabIndex;
        });
      },
    );
  }

// 반응형 TextButton 빌더
  TextButton _buildTextButton(
      String label, int index, bool isMobile, double buttonFontSize) {
    return TextButton(
      onPressed: () => _onItemTapped(index),
      child: Text(
        label,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: buttonFontSize, // 전달받은 fontSize 값 적용
        ),
      ),
      style: TextButton.styleFrom(
        foregroundColor: Colors.black, // 텍스트 색상을 검은색으로 설정
        padding: isMobile
            ? EdgeInsets.symmetric(horizontal: 12)
            : EdgeInsets.symmetric(horizontal: 16), // 모바일일 경우 버튼 간격을 더 작게 설정
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WillPopScope(onWillPop: () async {
        if (_selectedIndex != 0) {
          setState(() {
            _selectedIndex = 0; // 뒤로 가기를 눌렀을 때 홈 화면으로 이동
          });
          return false; // 앱 종료 방지
        }
        return true; // 앱 종료
      }, child: LayoutBuilder(builder: (context, constraints) {
        // width와 height 모두를 고려한 반응형 조건 설정
        final isMobile = width < 600 && height < 800;
        final isTablet = width >= 600 && width < 1024 && height < 1200;
        final isDesktop = width >= 1024 && height >= 1200;


        // 화면 크기에 따른 반응형 비율 설정
        double appBarHeight = height * 0.1;
        double buttonFontSize = width * 0.015; // width의 1.5%로 버튼 글씨 크기 설정
        double buttonPadding = width * 0.02; // width의 2%로 버튼 간격 설정


        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Color(0xffd4e2f5).withOpacity(0.9),
            // 살짝 투명도를 추가
            elevation: 0,
            // 그림자 제거
            surfaceTintColor: Colors.transparent,
            title: LayoutBuilder(
              builder: (context, constraints) {
                // 화면 너비에 따라 로고 크기 조정

                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  // 로고와 버튼들 사이 간격 설정
                  children: [
                    Container(
                        width: width * 0.10, // width의 25%를 로고 크기로 설정
                        height: isMobile
                            ? 80
                            : isTablet
                                ? 50
                                : 80,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: IconButton(
                            icon: Image.asset('assets/logo.png'),
                            onPressed: () => _onItemTapped(0),
                          ),
                        )),
                    SizedBox(
                      width: isMobile
                          ? MediaQuery.of(context).size.width * 0.05
                          : isTablet
                              ? MediaQuery.of(context).size.width * 0.3
                              : MediaQuery.of(context).size.width * 0.6,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            // 화면이 작아질수록 버튼 간격과 글씨 크기를 줄이기
                            double buttonFontSize = isMobile
                                ? 8
                                : isTablet
                                    ? 16
                                    : 16; // 화면 크기에 따른 글씨 크기 설정

                            double buttonSpacing = isMobile
                                ? 2
                                : isTablet
                                    ? 8
                                    : 1; // 화면 크기에 따른 버튼 간격 설정

                            return Wrap(
                              spacing: buttonSpacing,
                              alignment: WrapAlignment.end, // 버튼들을 오른쪽 정렬
                              children: [
                                _buildTextButton(
                                    "HOME", 0, isMobile, buttonFontSize),
                                _buildTextButton(
                                    "COMPANY", 1, isMobile, buttonFontSize),
                                _buildTextButton(
                                    "PRODUCTS", 2, isMobile, buttonFontSize),
                                _buildTextButton(
                                    "CONTACT US", 3, isMobile, buttonFontSize),
                                _buildTextButton(
                                    "DOWNLOADS", 4, isMobile, buttonFontSize),
                              ],
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          body: _pages[_selectedIndex], // 선택한 화면을 body에 보여줌
        );
      })),
    );
  }
}
