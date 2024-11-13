import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'company_screen.dart';
import 'home_screen.dart';
import 'product_screen.dart';
import 'contact_screen.dart';
import 'download_screen.dart';
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
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: MyAppContainer(
          child: HomePage(
            onNavigate: (int index) {
              _router.go(_getPathByIndex(index)); // 페이지 전환
            },
            onProductNavigate: (int tabIndex) {
              _router.go('/products/$tabIndex'); // Product 탭 전환
            },
            onCompanyNavigate: (int tabIndex) {
              _router.go('/company/$tabIndex'); // Company 탭 전환
            },
          ),
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/company/:tabIndex', // Company 페이지의 탭별 경로
      pageBuilder: (context, state) {
        final tabIndex = int.tryParse(state.pathParameters['tabIndex'] ?? '0') ?? 0;
        return CustomTransitionPage(
          key: state.pageKey,
          child: MyAppContainer(
            child: CompanyPage(
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
        final tabIndex = int.tryParse(state.pathParameters['tabIndex'] ?? '0') ?? 0;
        return CustomTransitionPage(
          key: state.pageKey,
          child: MyAppContainer(
            child: ProductScreen(
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
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: MyAppContainer(child: ContactScreen()),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    ),
    GoRoute(
      path: '/downloads', // Downloads 페이지 경로
      pageBuilder: (context, state) => CustomTransitionPage(
        key: state.pageKey,
        child: MyAppContainer(child: DownloadScreen()),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
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
  late double deviceWidth;
  late double deviceHeight;

  @override
  void initState() {
    super.initState();

    // Flutter Web에서 초기 앱 실행 시 device width와 height를 가져옴
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final size = MediaQuery.of(context).size;
      deviceWidth = size.width;
      deviceHeight = size.height;
      print('Device Width: $deviceWidth, Device Height: $deviceHeight');
    });
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(height * (isMobile ? 0.1 : isTablet ? 0.08 : 0.07)),
        child: AppBar(
          backgroundColor: Colors.white,
          elevation: 0, // 그림자 제거
          shadowColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          title: Container(
            padding: EdgeInsets.fromLTRB(
              0,
              height * (isMobile ? 0.018 : isTablet ? 0.015 : 0.0148),
              0,
              0,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: width * (isMobile ? 0.15 : isTablet ? 0.18 : 0.1770)),
                Container(
                  width: width * (isMobile ? 0.1 : isTablet ? 0.09 : 0.0858),
                  height: height * (isMobile ? 0.05 : isTablet ? 0.047 : 0.0453),
                  child: FittedBox(
                    fit: BoxFit.fitWidth,
                    child: IconButton(
                      icon: Image.asset('assets/logo.png'),
                      onPressed: () => onItemTapped(0), // 수정된 부분
                      style: ButtonStyle(
                        overlayColor: MaterialStateProperty.all(Colors.transparent), // 눌렀을 때 음영 효과 제거
                      ),
                    ),
                  ),
                ),
                SizedBox(width: width * (isMobile ? 0.2 : isTablet ? 0.23 : 0.2600)),
                Container(
                  width: width * 0.28,
                  alignment: Alignment.center,
                  padding: EdgeInsets.only(top: height * 0.01), // Row 높이를 살짝 내림
                  child: Row(
                    children: [
                      buildTextButton(
                        "HOME",
                        0,
                        width * (isMobile ? 0.004 : isTablet ? 0.005 : 0.007),
                        width * (isMobile ? 0.045 : isTablet ? 0.05 : 0.05210),
                        height * (isMobile ? 0.035 : isTablet ? 0.036 : 0.0375),
                        onItemTapped,
                      ),
                      SizedBox(width: width * (isMobile ? 0.003 : isTablet ? 0.0035 : 0.004)),
                      buildTextButton(
                        "COMPANY",
                        1,
                        width * (isMobile ? 0.004 : isTablet ? 0.005 : 0.007),
                        width * (isMobile ? 0.045 : isTablet ? 0.05 : 0.05210),
                        height * (isMobile ? 0.035 : isTablet ? 0.036 :0.0375),
                        onItemTapped,
                      ),
                      SizedBox(width: width * (isMobile ? 0.003 : isTablet ? 0.0035 : 0.004)),
                      buildTextButton(
                        "PRODUCTS",
                        2,
                        width * (isMobile ? 0.004 : isTablet ? 0.005 : 0.007),
                        width * (isMobile ? 0.045 : isTablet ? 0.05 : 0.05210),
                        height * (isMobile ? 0.035 : isTablet ? 0.036 : 0.0375),
                        onItemTapped,
                      ),
                      SizedBox(width: width * (isMobile ? 0.003 : isTablet ? 0.0035 : 0.004)),
                      buildTextButton(
                        "CONTACT US",
                        3,
                        width * (isMobile ? 0.004 : isTablet ? 0.005 : 0.007),
                        width * (isMobile ? 0.055 : isTablet ? 0.06 : 0.053),
                        height * (isMobile ? 0.035 : isTablet ? 0.036 : 0.0375),
                        onItemTapped,
                      ),
                      SizedBox(width: width * (isMobile ? 0.003 : isTablet ? 0.0035 : 0.004)),
                      buildTextButton(
                        "DOWNLOADS",
                        4,
                        width * (isMobile ? 0.004 : isTablet ? 0.005 : 0.007),
                        width * (isMobile ? 0.055 : isTablet ? 0.06 : 0.05210),
                        height * (isMobile ? 0.035 : isTablet ? 0.036 : 0.0375),
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
      backgroundColor: Colors.white,
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
Container buildTextButton(String label, int index, double buttonFontSize,
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
          letterSpacing: -0.2,
          color: selectedIndex == index ? Color(0xff6194f9) : Color(0xff191919),
        ),
      ),
      style: TextButton.styleFrom(
        foregroundColor: Color(0xff191919),
        overlayColor:Colors.transparent,// 눌렀을 때 생기는 그림자 제거
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // 직사각형으로 설정
        ),
      ),
    ),
  );
}