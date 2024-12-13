import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:newchem_flutter_website/m_company_screen.dart';
import 'company_screen.dart';
import 'home_screen.dart';
import 'm_home_screen.dart';
import 'm_product_screen.dart';
import 'product_screen.dart';
import 'contact_screen.dart';
import 'm_contact_screen.dart';
import 'download_screen.dart';
import 'm_download_screen.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'popup.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:html' as html; // Web용 dart:html 패키지 사용

void main() {
  setUrlStrategy(PathUrlStrategy()); // Path URL 사용
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

// go_router 설정
final GoRouter _router = GoRouter(
  initialLocation: '/', // 초기 위치
  routes: [
    GoRoute(
      path: '/', // 홈 페이지 경로
      pageBuilder: (context, state) {
        // MediaQuery를 사용해 isMobile 계산
        final size = MediaQuery.of(context).size;
        final isMobile = size.width < 600;

        return CustomTransitionPage(
          key: state.pageKey,
          child: MyAppContainer(
            child: isMobile
                ? MHomePage( // 모바일 전용 페이지
              onNavigate: (int index) {
                _router.go(_getPathByIndex(index));
              },
              onProductNavigate: (int tabIndex) {
                _router.go('/products/$tabIndex');
              },
              onCompanyNavigate: (int tabIndex) {
                _router.go('/company/$tabIndex');
              },
            )
                : HomePage( // 기존 데스크톱 페이지
              onNavigate: (int index) {
                _router.go(_getPathByIndex(index));
              },
              onProductNavigate: (int tabIndex) {
                _router.go('/products/$tabIndex');
              },
              onCompanyNavigate: (int tabIndex) {
                _router.go('/company/$tabIndex');
              },
            ),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),

    GoRoute(
      path: '/company/:tabIndex', // Company 페이지의 탭별 경로
      pageBuilder: (context, state) {
        final size = MediaQuery.of(context).size;
        final width = size.width;
        final height = size.height;

        // 모바일, 태블릿, 데스크톱 기준으로 각기 다른 비율 설정
        final isMobile = width < 600;
        final isTablet = width >= 600 && width < 1024;
        final isDesktop = width >= 1024;

        final tabIndex =
            int.tryParse(state.pathParameters['tabIndex'] ?? '0') ?? 0;
        return CustomTransitionPage(
          key: state.pageKey,
          child: MyAppContainer(
            child: isMobile? MCompanyPage(
              selectedTabIndex: tabIndex,
              onTabChanged: (int newTabIndex) {
                context.go('/company/$newTabIndex'); // 탭 변경 시 URL 업데이트
              },
            ):CompanyPage(
              selectedTabIndex: tabIndex,
              onTabChanged: (int newTabIndex) {
                context.go('/company/$newTabIndex'); // 탭 변경 시 URL 업데이트
              },
            ),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/products/:tabIndex', // Products 페이지 경로 및 탭별 설정
      pageBuilder: (context, state) {
        final size = MediaQuery.of(context).size;
        final width = size.width;
        final height = size.height;

        // 모바일, 태블릿, 데스크톱 기준으로 각기 다른 비율 설정
        final isMobile = width < 600;
        final isTablet = width >= 600 && width < 1024;
        final isDesktop = width >= 1024;

        final tabIndex =
            int.tryParse(state.pathParameters['tabIndex'] ?? '0') ?? 0;
        return CustomTransitionPage(
          key: state.pageKey,
          child: MyAppContainer(
            child: isMobile? MProductScreen(
              initialTabIndex: tabIndex,
              onTabChanged: (int newTabIndex) {
                context.go('/products/$newTabIndex'); // 탭 변경 시 URL 업데이트
              },
            ):ProductScreen(
            initialTabIndex: tabIndex,
            onTabChanged: (int newTabIndex) {
              context.go('/products/$newTabIndex'); // 탭 변경 시 URL 업데이트
            },
          ),
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/contact', // Contact 페이지 경로
      pageBuilder: (context, state) {
        final size = MediaQuery.of(context).size;
        final isMobile = size.width < 600; // 모바일 기준 조건 설정

        return CustomTransitionPage(
          key: state.pageKey,
          child: MyAppContainer(
            child: isMobile
                ? MContactScreen() // 모바일 전용 ContactScreen
                : ContactScreen(),      // 데스크톱 ContactScreen
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),

    GoRoute(
      path: '/downloads', // Downloads 페이지 경로
      pageBuilder: (context, state) {
        final size = MediaQuery.of(context).size;
        final isMobile = size.width < 600; // 모바일 기준 조건 설정

        return CustomTransitionPage(
          key: state.pageKey,
          child: MyAppContainer(
            child: isMobile
                ? MDownloadScreen() // 모바일 전용 DownloadScreen
                : DownloadScreen(),      // 데스크톱 DownloadScreen
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
        );
      },
    ),
    GoRoute(
      path: '/popup',
      builder: (context, state) => PopupScreen(),
    ),


  ],
);

// 인덱스에 따른 경로를 반환하는 함수
String _getPathByIndex(int index) {
  switch (index) {
    case 0:
      return '/';
    case 1:
      return '/company/0';
    case 2:
      return '/products/0';
    case 3:
      return '/contact';
    case 4:
      return '/downloads';
    case 5:
      return '/popup';
    default:
      return '/';
  }
}

// 기존 StatefulWidget MyApp 구조를 유지하기 위해 MyApp을 StatefulWidget으로 감쌈
class MyAppContainer extends StatefulWidget {
  final Widget child;

  MyAppContainer({required this.child});

  @override
  _MyAppContainerState createState() => _MyAppContainerState();
}


class _MyAppContainerState extends State<MyAppContainer> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    // 모바일, 태블릿, 데스크톱 기준으로 각기 다른 비율 설정
    final isMobile = width < 600;
    final isTablet = width >= 600 && width < 1024;
    final isDesktop = width >= 1024;

    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          isMobile ? height * 0.05 : height * 0.07,
        ),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          // 그림자 제거
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: Container(
            padding: EdgeInsets.fromLTRB(
              0,
              height * (0.0148),
              0,
              0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: isMobile ? width * 0.05 : width * 0.1770),
                isMobile?
                GestureDetector(
                  onTap: (){
                    onItemTapped(0);
                  },

                  child: Container(
                    width: width * 0.0750,
                    height: height * 0.0300,
                    child:  Image.asset('assets/logo.png',fit: BoxFit.contain,),
                  ),
                ):
                GestureDetector(
                  onTap: (){
                    onItemTapped(0);
                  },

                  child: Container(
                    padding: EdgeInsets.only(top : height * 0.01),
                    width: width * 0.0858,
                    height: height * 0.0453,
                    child:  Image.asset('assets/logo.png',fit: BoxFit.contain,),
                  ),
                ),

                SizedBox(width: isMobile ? width * 0.08 : width * 0.2200),
                isMobile
                    ? Container(
                        // width: width * 0.7,
                        padding:
                            EdgeInsets.only(top: height * 0), // Row 높이를 살짝 내림
                        child: Row(
                          children: [
                            buildTextButton(
                              "HOME",
                              0,
                              width * 0.01,
                              0,
                              width * 0.1,
                              height * 0.0375,
                              onItemTapped,
                            ),
                            SizedBox(width: width * 0.012),
                            buildTextButton(
                              "COMPANY",
                              1,
                              width * 0.01,
                              height * 0.002,
                              width * 0.14,
                              height * 0.0375,
                              onItemTapped,
                            ),
                            SizedBox(width: width * 0.012),
                            buildTextButton(
                              "PRODUCTS",
                              2,
                              width * 0.01,
                              0,
                              width * 0.14,
                              height * 0.0375,
                              onItemTapped,
                            ),
                            SizedBox(width: width * 0.01),
                            buildTextButton(
                              "CONTACT US",
                              3,
                              width * 0.01,
                              0,
                              width * 0.14,
                              height * 0.0375,
                              onItemTapped,
                            ),
                            buildTextButton(
                              "DOWNLOADS",
                              4,
                              width * 0.01,
                              0,
                              width * 0.14,
                              height * 0.0375,
                              onItemTapped,
                            ),
                          ],
                        ),
                      )
                    : Container(
                        width: width * 0.4,
                        padding: EdgeInsets.only(
                            top: height * 0.01), // Row 높이를 살짝 내림
                        child: Row(
                          children: [
                            buildTextButton(
                              "HOME",
                              0,
                              width * 0.00713,
                              0,
                              width * 0.06,
                              height * 0.0375,
                              onItemTapped,
                            ),

                            buildTextButton(
                              "COMPANY",
                              1,
                              width * 0.00713,
                              0,
                              width * 0.060,
                              height * 0.0375,
                              onItemTapped,
                            ),

                            buildTextButton(
                              "PRODUCTS",
                              2,
                              width * 0.00713,
                              0,
                              width * 0.068,
                              height * 0.0375,
                              onItemTapped,
                            ),

                            buildTextButton(
                              "CONTACT US",
                              3,
                              width * 0.00713,
                              0,
                              width * 0.068,
                              height * 0.0375,
                              onItemTapped,
                            ),
                            buildTextButton(
                              "DOWNLOADS",
                              4,
                              width * 0.00713,
                              0,
                              width * 0.068,
                              height * 0.0375,
                              onItemTapped,
                            ),
                          ],
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
      body: widget.child, // 현재 페이지의 내용을 표시
    );
  }
}

int selectedIndex = 0; // default는 Home 페이지
// 전역에서 사용 가능한 _onItemTapped 함수 정의
void onItemTapped(int index) {
  selectedIndex = index;
  _router.go(_getPathByIndex(index));
}

// 전역에서 사용 가능한 buildTextButton 함수 정의
Container buildTextButton(String label, int index, double buttonFontSize,double buttonFontHeight,
    double buttonWidth, double buttonHeight, Function(int) onItemTapped) {
  return Container(
    width: buttonWidth,
    height: buttonHeight,
    child: TextButton(
      onPressed: () => onItemTapped(index),
      child: Text(
        label,
        maxLines: 1,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w600,
          fontSize: buttonFontSize,
          color: selectedIndex == index ? Color(0xff6194f9) : Color(0xff191919),
          height: buttonFontHeight
        ),
      ),
      style: TextButton.styleFrom(
        foregroundColor: Color(0xff191919),
        overlayColor: Colors.transparent, // 눌렀을 때 생기는 그림자 제거
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // 직사각형으로 설정
        ),
      ),
    ),
  );
}
