import 'package:flutter/material.dart';
import 'package:newchem_flutter_website/download_screen.dart';
import 'company_screen.dart'; // CompanyPage 파일 import
import 'home_screen.dart';
import 'product_screen.dart';
import 'contact_screen.dart';
import 'download_screen.dart';
import 'package:google_fonts/google_fonts.dart';

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
      String label, int index, double buttonFontSize) {
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
        foregroundColor: Colors.white, // 텍스트 색상을 검은색으로 설정

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

        return Scaffold(
          backgroundColor: Colors.white,
          body: Container(
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.fromLTRB(16, 16, 16, 16),
              child: Column(
                children: [
                  Container(
                    height: height * 0.115,
                    child: Center(
                        child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      // 로고와 버튼들 사이 간격 설정
                      children: [
                        Container(
                            width: isMobile? width * 0.30: isTablet? width * 0.25 : width * 0.15,
                            height: height * 0.115,
                            child: FittedBox(
                              fit: BoxFit.contain,
                              child: IconButton(
                                icon: Image.asset('assets/logo.png'),
                                onPressed: () => _onItemTapped(0),
                              ),
                            )),
                      ],
                    )),
                  ),
                  Container(
                    color: Colors.black,
                    child: Center(
                      child: Container(

                        height: height * 0.05,
                        child: Row(
                          children: [
                            Spacer(),
                            _buildTextButton(
                                "HOME", 0, width * 0.010),
                            SizedBox(width: width * 0.012 ,),
                            _buildTextButton(
                                "COMPANY", 1,  width * 0.010),
                            SizedBox(width: width * 0.012 ,),
                            _buildTextButton(
                                "PRODUCTS", 2,  width * 0.010),
                            SizedBox(width: width * 0.012 ,),
                            _buildTextButton(
                                "CONTACT US", 3,  width * 0.010),
                            SizedBox(width: width * 0.012 ,),
                            _buildTextButton(
                                "DOWNLOADS", 4,  width * 0.010),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: _pages[_selectedIndex],
                  )
                ],
              )), // 선택한 화면을 body에 보여줌
        );
      })),
    );
  }
}
