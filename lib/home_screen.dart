import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:html' as html; // Web용 dart:html 패키지 사å용
import 'dart:ui_web' as ui;
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'popup.dart';
import 'dart:html' as html;
import 'package:newchem_flutter_website/main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  final Function(int) onNavigate;
  final Function(int) onProductNavigate;
  final Function(int) onCompanyNavigate;

  HomePage(
      {required this.onNavigate,
      required this.onProductNavigate,
      required this.onCompanyNavigate});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentImageIndex = 0;
  late html.DivElement? _popupDiv; // 팝업 요소를 추적할 변수
  final CarouselSliderController _controller = CarouselSliderController();
  final ScrollController _scrollController = ScrollController();
  bool isHovered = false;
  static bool _popupClosed = false; // 팝업이 닫혔는지 여부를 추적하는 플래그

  final List<String> _backgroundImages = [
    'assets/main-background2.png',
    'assets/main-background4.png',
    'assets/main-background6.png',
  ];
  String url =
      'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d669.6223690480622!2d127.01586977089258!3d37.02699966322705!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b3d001631c641%3A0x2cd353d15ed8488b!2z6rOg642V7KeA7Iud6rO17J6R7IaM7JWE7J207YOA7JuMIOyngOyLneyCsOyXheyEvO2EsA!5e0!3m2!1sko!2skr!4v1717727526433!5m2!1sko!2skr" width="849" height="500" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade';
  String url2 =
      'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3214.0718188284864!2d127.40560918528085!3d36.33480920020751!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x35654939a7b233b1%3A0x1a9c09f4d30f558f!2z64yA7KCE6rSR7Jet7IucIOykkeq1rCDrqqnrj5nroZwgNDI!5e0!3m2!1sko!2skr!4v1731478790160!5m2!1sko!2skr" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade';

  int _currentStep = 1; // 현재 단계 설정
  double _lineOpacity = 0.2; // 선의 초기 불투명도
  final Widget _iframeWidget1 = HtmlElementView(
    viewType: 'iframeElement1',
    key: UniqueKey(),
  );

  final Widget _iframeWidget2 = HtmlElementView(
    viewType: 'iframeElement2',
    key: UniqueKey(),
  );

  final List<Map<String, dynamic>> slideImages = [
    {
      'image': 'assets/sliderbackground01.png',
      'name': 'Rotary Evaporator',
      'logo': 'assets/heidolph_logo.png',
      'logoname': 'HEIDOLPH',
      'route': '0',
      'description':
          'Heidolph는 혁신적이고 글로벌한 기업으로서, 프리미엄 실험실 장비 생산의 선두주자입니다.\n저희 뉴켐은 Heidolph 전 제품을 대전지역에 독점 공급하고 있습니다.',
      'productImages': [
        'assets/products/Hei-VAP_Series.png',
        'assets/products/Hei-VAP_Industrial.png',
        'assets/products/Automatic_Distillation.png'
      ],
      'productName': [
        'Hei-VAP Series',
        'Hei-VAP Industrial',
        'Automatic Distillation'
      ]
    },
    {
      'image': 'assets/sliderbackground02.png',
      'name': 'Stirring',
      'logo': 'assets/heidolph_logo.png',
      'logoname': 'HEIDOLPH',
      'route': '0',
      'description':
          'Heidolph는 혁신적이고 글로벌한 기업으로서, 프리미엄 실험실 장비 생산의 선두주자입니다.\n저희 뉴켐은 Heidolph 전 제품을 대전지역에 독점 공급하고 있습니다.',
      'productImages': [
        'assets/products/Magnetic_stirrer.png',
        'assets/products/Overhead_stirrer.png'
      ],
      'productName': ['Magnetic stirrer', 'Overhead stirrer']
    },
    {
      'image': 'assets/sliderbackground04.png',
      'name': 'Glass Reaction System',
      'logo': 'assets/normag_logo.png',
      'logoname': 'NORMAG',
      'route': '1',
      'description':
          '독일 NORMAG는 화학 및 제약 산업의 실험실부터 생산용 scale까지\n유리 반응기 및 부품을 제조/판매하는 회사입니다.',
      'productImages': [
        'assets/products/Lab_Fast_Pro.png',
        'assets/products/Pilot_compact_reactor.png',
        'assets/products/ReactionSystemPilot.png'
      ],
      'productName': [
        'Lab Fast Pro',
        'Pilot Compact Reactor (10 ~ 30L)',
        'Glass Reaction System(30 ~200L)'
      ]
    },
    {
      'image': 'assets/sliderbackground05.png',
      'name': 'Continuous Cetrifuse Extractor',
      'logo': 'assets/CINCIndustry_logo.png',
      'logoname': 'CINC Inc.',
      'route': '2',
      'description':
          '미국 CINC는 액체-액체 원심분리기를 설계,제조 및 공급하는 기업으로,전 세계의 석유,화학,광업,\n제약,식품,향료,인쇄 및 환경 산업 분야의 연구를 수행하는 고객들의 신뢰를 받고 있습니다.',
      'productImages': [
        'assets/products/Cinc_Industry_Product.png',
      ],
      'productName': ['CINC Industries']
    },
  ];

  final List<Map<String, String>> downloadData = [
    {
      "number": "1",
      "title": "[NORMAG]카달로그",
      "link":
          "https://drive.google.com/file/d/1yhI9hVqEQVRXpuR2u0bmN-c0yvwTUNd9/view?usp=sharing",
      "author": "관리자",
      "date": "2024.10.16",
      "image": 'assets/download_image_01.png'
    },
    {
      "number": "2",
      "title": "[하이돌프] 종합 카달로그",
      "link":
          "https://drive.google.com/file/d/1Ols-r9GJcyZiHQMKNkxA7Ysaj51_fQa7/view?usp=sharing",
      "author": "관리자",
      "date": "2024.10.16",
      "image": 'assets/download_image_02.png'
    },
    {
      "number": "3",
      "title": "준비중",
      "link":
          "https://drive.google.com/file/d/1yhI9hVqEQVRXpuR2u0bmN-c0yvwTUNd9/view?usp=sharing",
      "author": "관리자",
      "date": "2024.10.17",
      "image": 'assets/download_image_02.png'
    },
  ];

  int _current = 0;
  late List<Widget> imageSliders;

  void initState() {
    super.initState();
    // 3초마다 이미지 전환
    // 페이지 로드 시 HTML 팝업 표시 (한 번 닫았으면 표시하지 않음)
    if (!_popupClosed) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showHtmlPopup();
      });
    }

    Timer.periodic(Duration(seconds: 8), (timer) {
      setState(() {
        _currentImageIndex =
            (_currentImageIndex + 1) % _backgroundImages.length;
      });
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _popupClosed = true; // 팝업이 닫혔음을 기록
    // 팝업 제거
    if (_popupDiv != null) {
      _popupDiv!.remove();
      _popupDiv = null; // 참조 해제
    }

    super.dispose();
  }
  void _showHtmlPopup() {
    // 새로운 div 요소 생성
    _popupDiv = html.DivElement()
      ..style.position = 'fixed'
      ..style.top = '32%'
      ..style.left = '80%'
      ..style.transform = 'translate(-50%, -50%)'
      ..style.backgroundColor = 'white'
      ..style.border = '1px solid black'
      ..style.zIndex = '1000'
      ..style.width = '600px'
      ..style.height = "600px"
      ..style.textAlign = 'center';

    // 이미지 추가
    final image = html.ImageElement(
        src: 'https://loadimage-wusgl4pmyq-uc.a.run.app')
      ..style.width = '100%' // 이미지 크기를 팝업에 맞게 설정
      ..style.height = '95%' // 비율 유지
      ..onClick.listen((event) {
        // 클릭 시 특정 URL로 이동
        html.window.open(
          'https://heidolph.activehosted.com/index.php?action=social&chash=35f4a8d465e6e1edc05f3d8ab658c551.83&s=796fee5a1c3947d587d6eac61a4149eb',
          '_blank',
        );
      });
    _popupDiv!.children.add(image);

    // 닫기 버튼 추가
    final closeButton = html.ButtonElement()
      ..text = "닫기"
      ..style.marginTop = '0px'
      ..onClick.listen((event) {
        _popupDiv?.remove(); // 팝업 제거
        _popupDiv = null; // 참조 해제
        _popupClosed = true; // 팝업이 닫혔음을 기록
      });
    _popupDiv!.children.add(closeButton);

    // HTML body에 팝업 추가
    html.document.body?.append(_popupDiv!);
  }



  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _previousPage() {
    if (_currentIndex > 0) {
      _pageController.previousPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentIndex--;
      });
    }
  }

  void _nextPage() {
    if (_currentIndex < downloadData.length - 1) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
      setState(() {
        _currentIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    final isMobile = width < 600 && height < 916;
    final isTablet = width >= 600 && width < 1024 && height < 1200;
    final isDesktop = width >= 1024 && height >= 1200;

    final html.IFrameElement _iFrameElement1 = html.IFrameElement();
    final html.IFrameElement _iFrameElement2 = html.IFrameElement();

    _iFrameElement1.style.height = '100%';
    _iFrameElement1.style.width = '100%';
    _iFrameElement1.src = '${url}';
    _iFrameElement1.style.border = 'none';

    _iFrameElement2.style.height = '100%';
    _iFrameElement2.style.width = '100%';
    _iFrameElement2.src = '${url2}';
    _iFrameElement2.style.border = 'none';
// ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement1',
      (int viewId) {
        final element = html.IFrameElement();
        element.src = url;
        element.style.border = 'none';
        return element;
      },
    );

    ui.platformViewRegistry.registerViewFactory(
      'iframeElement2',
      (int viewId) {
        final element = html.IFrameElement();
        element.src = url2;
        element.style.border = 'none';
        return element;
      },
    );
//내 컴퓨터 환경 2560 * 1440
    return ScreenUtilInit(
      designSize: Size(1920, 1080),
      child: MaterialApp(
        home: LayoutBuilder(builder: (context, constraints) {
          return Scaffold(
            backgroundColor: Color(0xffd4e2f5).withOpacity(0.9),
            body: SingleChildScrollView(
              controller: _scrollController,
              child: Container(
                  width: width,
                  height: height *
                      (isMobile
                          ? 1.895
                          : isTablet
                              ? 5
                              : 4.85572),
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      isMobile
                          ? Container(
                              padding: EdgeInsets.zero,
                              width: width,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: width,
                                        child: CarouselSlider(
                                          carouselController: _controller,
                                          items: slideImages.map((item) {
                                            return GestureDetector(
                                              onTap: () {
                                                widget.onProductNavigate(
                                                    int.parse(item['route']!));
                                              },
                                              child: Container(
                                                width: width,
                                                height: height * 1.5,
                                                child: Stack(
                                                  children: [
                                                    Image.asset(item['image']!,
                                                        fit: BoxFit.fill,
                                                        width: width,
                                                        height: height * 1.5),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                            height:
                                                                height * 0.02),
                                                        Text(
                                                          item['name']!,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                width * 0.02,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),

                                                        SelectableText(
                                                          item['description']!,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                width * 0.01,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing: 0.6,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                height * 0.01),
                                                        Container(
                                                          width: width * 0.15,
                                                          height:
                                                              height * 0.015,
                                                          color: Colors
                                                              .transparent,
                                                          child: InkWell(
                                                            onTap: () {
                                                              int tabIndex;
                                                              // item['logoname'] 값에 따라 탭 인덱스를 설정
                                                              if (item[
                                                                      'logoname'] ==
                                                                  'HEIDOLPH') {
                                                                tabIndex = 0;
                                                              } else if (item[
                                                                      'logoname'] ==
                                                                  'NORMAG') {
                                                                tabIndex = 1;
                                                              } else if (item[
                                                                      'logoname'] ==
                                                                  'CINC Inc.') {
                                                                tabIndex = 2;
                                                              } else {
                                                                tabIndex =
                                                                    0; // 기본값으로 설정할 인덱스 (필요시)
                                                              }
                                                              widget
                                                                  .onProductNavigate(
                                                                      tabIndex);
                                                            },
                                                            child: MouseRegion(
                                                              onEnter: (_) =>
                                                                  setState(() =>
                                                                      isHovered =
                                                                          true),
                                                              onExit: (_) =>
                                                                  setState(() =>
                                                                      isHovered =
                                                                          false),
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: isHovered
                                                                          ? Color(
                                                                              0xff5695F0)
                                                                          : Colors
                                                                              .white,
                                                                      width: width *
                                                                          0.001),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              61),
                                                                ),
                                                                child: Text(
                                                                  item[
                                                                      'logoname']!,
                                                                  style:
                                                                      TextStyle(
                                                                    color: isHovered
                                                                        ? Color(
                                                                            0xff5695F0)
                                                                        : Colors
                                                                            .white,
                                                                    fontSize:
                                                                        width *
                                                                            0.012,
                                                                    fontFamily:
                                                                        'Pretendard',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                height * 0.01),
                                                        // 추가된 productImages와 productName을 위한 Row

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceAround,
                                                          children: [
                                                            ...List.generate(
                                                              item['productImages']
                                                                  .length,
                                                              (index) {
                                                                String
                                                                    productImage =
                                                                    item['productImages']
                                                                        [index];
                                                                String
                                                                    productName =
                                                                    item['productName']
                                                                        [index];
                                                                return Container(
                                                                  width: item['productImages']
                                                                              .length ==
                                                                          1
                                                                      ? width *
                                                                          0.35
                                                                      : width *
                                                                          0.22,
                                                                  height:
                                                                      height *
                                                                          0.1,
                                                                  decoration:
                                                                      ShapeDecoration(
                                                                    color: Colors
                                                                        .white
                                                                        .withOpacity(
                                                                            0.65),
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      side: BorderSide(
                                                                          width: width *
                                                                              0.001,
                                                                          color:
                                                                              Colors.transparent),
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8),
                                                                    ),
                                                                  ),
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                          height: width < 1600
                                                                              ? height * 0.002
                                                                              : height * 0.01),
                                                                      Image
                                                                          .asset(
                                                                        item[
                                                                            'logo'],
                                                                        width: width < 1600
                                                                            ? width *
                                                                                0.015
                                                                            : width *
                                                                                0.02,
                                                                        fit: BoxFit
                                                                            .contain,
                                                                      ),
                                                                      Text(
                                                                        productName,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              width * 0.006,
                                                                          fontFamily:
                                                                              'Pretendard',
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ),
                                                                      ),
                                                                      SizedBox(
                                                                        height: width < 1600
                                                                            ? height *
                                                                                0.004
                                                                            : height *
                                                                                0.015,
                                                                      ),
                                                                      Image
                                                                          .asset(
                                                                        productImage,
                                                                        width: width *
                                                                            0.15,
                                                                        height: width < 1600
                                                                            ? height *
                                                                                0.01
                                                                            : height *
                                                                                0.05,
                                                                        fit: width <
                                                                                1600
                                                                            ? BoxFit.contain
                                                                            : BoxFit.fitHeight,
                                                                      ),
                                                                    ],
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          options: CarouselOptions(
                                            autoPlay: true,
                                            autoPlayInterval:
                                                Duration(seconds: 8),
                                            // 자동 재생 시간 조절
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 1000),
                                            // 전환 속도 조절
                                            enlargeCenterPage: false,
                                            viewportFraction: 1,
                                            scrollPhysics:
                                                BouncingScrollPhysics(),
                                            // 부드러운 스크롤 적용
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _current = index;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(height: height * 0.12),
                                              ...slideImages
                                                  .asMap()
                                                  .entries
                                                  .map((entry) {
                                                return Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        _controller
                                                            .animateToPage(
                                                                entry.key);
                                                      },
                                                      child: Container(
                                                        width: width * 0.012,
                                                        height: height * 0.02,
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    4.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: _current ==
                                                                  entry.key
                                                              ? Colors
                                                                  .transparent
                                                              : Colors
                                                                  .transparent,
                                                          border: Border.all(
                                                            color: _current ==
                                                                    entry.key
                                                                ? Colors.white
                                                                : Colors
                                                                    .transparent,
                                                            width: _current ==
                                                                    entry.key
                                                                ? 1
                                                                : 0, // 선택된 항목에만 테두리를 주기
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Container(
                                                            width:
                                                                width * 0.004,
                                                            height:
                                                                height * 0.006,
                                                            decoration:
                                                                BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: isMobile
                                                            ? 0
                                                            : height * 0.005),

                                                    // 원 사이의 간격 설정
                                                  ],
                                                );
                                              }).toList(),
                                              SizedBox(
                                                  height: isMobile
                                                      ? 0
                                                      : height * 0.25),
                                              Visibility(
                                                child: Transform(
                                                  transform: Matrix4.identity()
                                                    ..translate(10, 12)
                                                    ..rotateZ(-1.57),
                                                  child: Text(
                                                    'Scroll',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: width * 0.007,
                                                      fontFamily: 'Pretendard',
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                                visible: !isMobile,
                                              ),
                                              SizedBox(height: height * 0.004),
                                              Visibility(
                                                child: Image.asset(
                                                    'assets/arrow_down.png'),
                                                visible: !isMobile,
                                              )
                                            ],
                                          ),
                                          SizedBox(width: width * 0.015),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            )
                          : Container(
                              padding: EdgeInsets.zero,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        width: width,
                                        child: CarouselSlider(
                                          carouselController: _controller,
                                          items: slideImages.map((item) {
                                            return GestureDetector(
                                              onTap: () {
                                                widget.onProductNavigate(
                                                    int.parse(item['route']!));
                                              },
                                              child: Container(
                                                width: width,
                                                child: Stack(
                                                  children: [
                                                    Image.asset(
                                                      item['image']!,
                                                      fit: BoxFit.contain,
                                                      width: width,
                                                      height: height * 1.111,
                                                    ),
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        SizedBox(
                                                            height: width < 1600
                                                                ? height *
                                                                    0.07.h
                                                                : height *
                                                                    0.2129.h),
                                                        Text(
                                                          item['name']!,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                width * 0.0281,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height: width < 1600
                                                                ? height *
                                                                    0.0008.h
                                                                : height *
                                                                    0.022.h),
                                                        SelectableText(
                                                          item['description']!,
                                                          textAlign:
                                                              TextAlign.center,
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize:
                                                                width * 0.0101,
                                                            fontFamily:
                                                                'Pretendard',
                                                            fontWeight:
                                                                FontWeight.w500,
                                                            letterSpacing: 0.6,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height: width < 1600
                                                                ? height * 0.02
                                                                : height *
                                                                    0.05),
                                                        Container(
                                                          width: width * 0.0968,
                                                          height: width < 1600
                                                              ? height * 0.03
                                                              : height * 0.05,
                                                          color: Colors
                                                              .transparent,
                                                          child: InkWell(
                                                            onTap: () {
                                                              int tabIndex;
                                                              // item['logoname'] 값에 따라 탭 인덱스를 설정
                                                              if (item[
                                                                      'logoname'] ==
                                                                  'HEIDOLPH') {
                                                                tabIndex = 0;
                                                              } else if (item[
                                                                      'logoname'] ==
                                                                  'NORMAG') {
                                                                tabIndex = 1;
                                                              } else if (item[
                                                                      'logoname'] ==
                                                                  'CINC Inc.') {
                                                                tabIndex = 2;
                                                              } else {
                                                                tabIndex =
                                                                    0; // 기본값으로 설정할 인덱스 (필요시)
                                                              }
                                                              widget
                                                                  .onProductNavigate(
                                                                      tabIndex);
                                                            },
                                                            child: MouseRegion(
                                                              onEnter: (_) =>
                                                                  setState(() =>
                                                                      isHovered =
                                                                          true),
                                                              onExit: (_) =>
                                                                  setState(() =>
                                                                      isHovered =
                                                                          false),
                                                              child: Container(
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: isHovered
                                                                          ? Color(
                                                                              0xff5695F0)
                                                                          : Colors
                                                                              .white,
                                                                      width: width *
                                                                          0.001),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              61),
                                                                ),
                                                                child: Text(
                                                                  item[
                                                                      'logoname']!,
                                                                  style:
                                                                      TextStyle(
                                                                    color: isHovered
                                                                        ? Color(
                                                                            0xff5695F0)
                                                                        : Colors
                                                                            .white,
                                                                    fontSize:
                                                                        width *
                                                                            0.0125,
                                                                    fontFamily:
                                                                        'Pretendard',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w600,
                                                                  ),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                            height: width < 1600
                                                                ? height * 0.02
                                                                : height *
                                                                    0.042),
                                                        // 추가된 productImages와 productName을 위한 Row

                                                        Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            ...List.generate(
                                                              item['productImages']
                                                                  .length,
                                                              (index) {
                                                                String
                                                                    productImage =
                                                                    item['productImages']
                                                                        [index];
                                                                String
                                                                    productName =
                                                                    item['productName']
                                                                        [index];
                                                                return Padding(
                                                                  padding: EdgeInsets.symmetric(
                                                                      horizontal: height *
                                                                          (isMobile
                                                                              ? 0.005
                                                                              : 0.0074)),
                                                                  child:
                                                                      Container(
                                                                    width: item['productImages'].length ==
                                                                            1
                                                                        ? width *
                                                                            (isMobile
                                                                                ? 0.35
                                                                                : 0.415)
                                                                        : width *
                                                                            (isMobile
                                                                                ? 0.22
                                                                                : 0.2479),
                                                                    height: height *
                                                                        (width <
                                                                                1600
                                                                            ? 0.26
                                                                            : 0.4407),
                                                                    decoration:
                                                                        ShapeDecoration(
                                                                      color: Colors
                                                                          .white
                                                                          .withOpacity(
                                                                              0.65),
                                                                      shape:
                                                                          RoundedRectangleBorder(
                                                                        side: BorderSide(
                                                                            width: width *
                                                                                0.001,
                                                                            color:
                                                                                Colors.transparent),
                                                                        borderRadius:
                                                                            BorderRadius.circular(8),
                                                                      ),
                                                                    ),
                                                                    child:
                                                                        Column(
                                                                      children: [
                                                                        SizedBox(
                                                                            height:
                                                                                height * (isMobile ? 0.02 : 0.0303)),
                                                                        Image
                                                                            .asset(
                                                                          item[
                                                                              'logo'],
                                                                          width:
                                                                              width * (isMobile ? 0.02 : 0.036),
                                                                          height:
                                                                              height * (isMobile ? 0.01 : 0.0129),
                                                                          fit: BoxFit
                                                                              .fill,
                                                                        ),
                                                                        Text(
                                                                          productName,
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.black,
                                                                            fontSize:
                                                                                width * (isMobile ? 0.012 : 0.015),
                                                                            fontFamily:
                                                                                'Pretendard',
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                            height:
                                                                                height * (isMobile ? 0.0015 : 0.0011),
                                                                          ),
                                                                        ),
                                                                        SizedBox(
                                                                            height:
                                                                                height * (isMobile ? 0.01 : 0.0148)),
                                                                        Image
                                                                            .asset(
                                                                          productImage,
                                                                          width:
                                                                              width * (isMobile ? 0.15 : 0.2),
                                                                          height:
                                                                              height * (width < 1600 ? 0.1 : 0.2879),
                                                                          fit: BoxFit
                                                                              .contain,
                                                                        ),
                                                                        SizedBox(
                                                                            height: width < 1600
                                                                                ? height * 0.002
                                                                                : height * 0.00690),
                                                                        Text(
                                                                          'NewChem',
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Color(0xFF729DF6).withOpacity(0.7),
                                                                            fontSize:
                                                                                width * (isMobile ? 0.008 : 0.009),
                                                                            fontFamily:
                                                                                'Pretendard',
                                                                            fontWeight:
                                                                                FontWeight.w500,
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          }).toList(),
                                          options: CarouselOptions(
                                            autoPlay: true,
                                            autoPlayInterval:
                                                Duration(seconds: 8),
                                            // 자동 재생 시간 조절
                                            autoPlayAnimationDuration:
                                                Duration(milliseconds: 1000),
                                            // 전환 속도 조절
                                            enlargeCenterPage: false,
                                            viewportFraction: 1,
                                            scrollPhysics:
                                                BouncingScrollPhysics(),
                                            // 부드러운 스크롤 적용
                                            onPageChanged: (index, reason) {
                                              setState(() {
                                                _current = index;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              SizedBox(
                                                  height: height *
                                                      (isMobile
                                                          ? 0.15
                                                          : 0.2352)),
                                              ...slideImages
                                                  .asMap()
                                                  .entries
                                                  .map((entry) {
                                                return Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: () {
                                                        _controller
                                                            .animateToPage(
                                                                entry.key);
                                                      },
                                                      child: Container(
                                                        width: width *
                                                            (isMobile
                                                                ? 0.012
                                                                : 0.0166),
                                                        height: height *
                                                            (isMobile
                                                                ? 0.02
                                                                : 0.0296),
                                                        margin: EdgeInsets
                                                            .symmetric(
                                                                horizontal:
                                                                    4.0),
                                                        decoration:
                                                            BoxDecoration(
                                                          shape:
                                                              BoxShape.circle,
                                                          color: _current ==
                                                                  entry.key
                                                              ? Colors
                                                                  .transparent
                                                              : Colors
                                                                  .transparent,
                                                          border: Border.all(
                                                            color: _current ==
                                                                    entry.key
                                                                ? Colors.white
                                                                : Colors
                                                                    .transparent,
                                                            width: _current ==
                                                                    entry.key
                                                                ? 1
                                                                : 0, // 선택된 항목에만 테두리를 주기
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: Container(
                                                            width: width *
                                                                (isMobile
                                                                    ? 0.004
                                                                    : 0.0052),
                                                            height: height *
                                                                (isMobile
                                                                    ? 0.006
                                                                    : 0.0092),
                                                            decoration:
                                                                BoxDecoration(
                                                                    shape: BoxShape
                                                                        .circle,
                                                                    color: Colors
                                                                        .white),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    SizedBox(
                                                        height: height *
                                                            (isMobile
                                                                ? 0.02
                                                                : 0.02549)),

                                                    // 원 사이의 간격 설정
                                                  ],
                                                );
                                              }).toList(),
                                              SizedBox(
                                                  height: height *
                                                      (isMobile
                                                          ? 0.25
                                                          : 0.3450)),
                                              Transform(
                                                transform: Matrix4.identity()
                                                  ..translate(10, 12)
                                                  ..rotateZ(-1.57),
                                                child: Text(
                                                  'Scroll',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width *
                                                        (isMobile
                                                            ? 0.007
                                                            : 0.0083),
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                  height: height *
                                                      (isMobile
                                                          ? 0.004
                                                          : 0.0050)),
                                              Image.asset(
                                                  'assets/arrow_down.png'),
                                            ],
                                          ),
                                          SizedBox(
                                              width: width *
                                                  (isMobile ? 0.015 : 0.02239)),
                                        ],
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                      //carusel slider 부분
                      Container(
                          color: Colors.white,
                          height: height * (isMobile ? 0.15 : 0.7870),
                          child: Stack(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        width:
                                            width * (isMobile ? 0.6 : 0.7125),
                                        height:
                                            height * (isMobile ? 0.2 : 0.3129),
                                        child: Image.asset(
                                          'assets/bg-gradation00.png',
                                          fit: BoxFit.contain,
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Spacer(),
                                  Column(
                                    children: [
                                      SizedBox(
                                          height:
                                              height * (isMobile ? 0 : 0.1388)),
                                      Text(
                                        'Contacts Us',
                                        style: TextStyle(
                                          color: Color(0xFF191919),
                                          fontSize: width *
                                              (isMobile
                                                  ? 0.022
                                                  : isTablet
                                                      ? 0.025
                                                      : 0.0291),
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w700,
                                          height: height *
                                              (isMobile ? 0.0015 : 0.0010),
                                        ),
                                      ),
                                      Text(
                                        '전문가에게 맡겨주세요 ',
                                        style: TextStyle(
                                          color: Color(0xFF191919),
                                          fontSize: width *
                                              (isMobile ? 0.012 : 0.0145),
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      SizedBox(
                                          height: height *
                                              (isMobile ? 0.01 : 0.0444)),
                                      SelectableText(
                                        '문의 및 상담 내용을 작성해서 접수하시면',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF191919),
                                          fontSize: width *
                                              (isMobile ? 0.008 : 0.0104),
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          height: height *
                                              (isMobile ? 0.0012 : 0.0010),
                                        ),
                                      ),
                                      SelectableText(
                                        '전문가들이 24시간 이내에 빠르고 성실하게 답변 드리겠습니다.',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Color(0xFF191919),
                                          fontSize: width *
                                              (isMobile ? 0.008 : 0.0104),
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                      // 진행 단계 표시 Row 추가
                                      SizedBox(
                                          height: isMobile
                                              ? height * 0.02
                                              : height * 0.1600),
                                      Visibility(
                                        child: Container(
                                          width: width * 0.625,
                                          height: height * 0.07592,
                                          child: Image.asset(
                                            'assets/progressbar.png',
                                            fit: BoxFit.contain,
                                          ),
                                        ),
                                        visible: !isMobile,
                                      ),

                                      SizedBox(
                                          height: isMobile
                                              ? height * 0.04
                                              : height * 0.0900),
                                      Container(
                                        width:
                                            width * (isMobile ? 0.16 : 0.1682),
                                        height:
                                            height * (isMobile ? 0.02 : 0.0574),
                                        child: ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              widget.onNavigate(3);
                                            });
                                          },
                                          child: Text(
                                            '문의하기',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width *
                                                  (isMobile ? 0.010 : 0.0125),
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Color(0xff5695F0),
                                            foregroundColor: Colors.white,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ],
                          )),
                      //contact us 부분
                      Container(
                          height: height * (isMobile ? 0.19 : 0.612),
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/main-background00.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center(
                            child: Column(
                              children: [
                                Spacer(),
                                Text(
                                  'NEWCHEM',
                                  style: TextStyle(
                                    color: Color(0xFF6194F9),
                                    fontSize: width * 0.01041,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(
                                  height: isMobile
                                      ? height * 0.0022
                                      : height * 0.0055,
                                ),
                                Text(
                                  'Welcome',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF191919),
                                    fontSize:
                                        width * (isMobile ? 0.025 : 0.02916),
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  height: isMobile
                                      ? height * 0.02
                                      : height * 0.06111,
                                ),
                                Text(
                                  '(주) 뉴켐은 실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지\n합성 실험에 필요한 모든 솔루션을 제공하는 회사입니다.\n지난 20년간 화학 및 의약 연구 분야에서 수많은 제품과 시스템을 공급하며,\n고객이 신뢰할 수 있는 회사로 자리매김해 왔습니다.\n앞으로도 지속적인 성원 부탁드립니다.\n저희 뉴켐은 언제나 고객과 함께 하겠습니다.',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Color(0xFF191919),
                                    fontSize: width * 0.01041,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: height * 0.0017,
                                  ),
                                ),
                                SizedBox(
                                  height: isMobile
                                      ? height * 0.02
                                      : height * 0.0416,
                                ),
                                InkWell(
                                  onTap: () {
                                    widget.onNavigate(1);
                                  },
                                  child: Container(
                                    // width: width * (isMobile ? 0.16 : 0.1682),
                                    // height:
                                    // height * (isMobile ? 0.02 : 0.0574),
                                    width: isMobile
                                        ? width * 0.16
                                        : width * 0.08645,
                                    height: isMobile
                                        ? height * 0.02
                                        : height * 0.0388,
                                    decoration: ShapeDecoration(
                                      color: Colors.white.withOpacity(0),
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            width: 1, color: Color(0xFF6194F9)),
                                        borderRadius: BorderRadius.circular(70),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'more view',
                                          style: TextStyle(
                                            color: Color(0xFF6194F9),
                                            fontSize: width * 0.01041,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.0052,
                                        ),
                                        Container(
                                          width: width * 0.0049,
                                          height: height * 0.0069,
                                          child: Image.asset(
                                            'assets/arrow_right.png',
                                            fit: BoxFit.contain,
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                          )),
                      Container(
                        height: height * (isMobile ? 0.35 : 0.6300),
                        color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: width * (isMobile ? 0.1 : 0.1820),
                            ),
                            Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height:
                                        height * (isMobile ? 0.005 : 0.1900),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Downloads',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          color: Color(0xFF191919),
                                          fontSize: width *
                                              (isMobile ? 0.025 : 0.02916),
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      SizedBox(
                                        width:
                                            width * (isMobile ? 0.03 : 0.0442),
                                      ),
                                      Transform.translate(
                                        offset: Offset(
                                            0,
                                            height *
                                                (isMobile ? 0.007 : 0.009)),
                                        child: InkWell(
                                          onTap: () {
                                            widget.onNavigate(4);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Text(
                                                'more view',
                                                style: TextStyle(
                                                  color: Color(0xFF6194F9),
                                                  fontSize: width *
                                                      (isMobile
                                                          ? 0.009
                                                          : 0.01119),
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w400,
                                                  height: height *
                                                      (isMobile
                                                          ? 0.00005
                                                          : 0.00006),
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_right,
                                                color: Color(0xFF6194F9),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height:
                                        height * (isMobile ? 0.005 : 0.0074),
                                  ),
                                  Container(
                                    width: width * (isMobile ? 0.2 : 0.26145),
                                    height:
                                        height * (isMobile ? 0.002 : 0.00277),
                                    decoration:
                                        BoxDecoration(color: Color(0xFF6194F9)),
                                  ),
                                  SizedBox(
                                    height:
                                        height * (isMobile ? 0.004 : 0.0055),
                                  ),
                                  Container(
                                    padding: EdgeInsets.zero,
                                    width: width * (isMobile ? 0.22 : 0.2614),
                                    child: Column(
                                      children: [
                                        ...downloadData
                                            .asMap()
                                            .entries
                                            .map((entry) {
                                          int index = entry.key;
                                          var item = entry.value;

                                          return Column(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.fromLTRB(
                                                    0,
                                                    height *
                                                        (isMobile
                                                            ? 0.005
                                                            : 0.0074),
                                                    0,
                                                    0),
                                                child: Table(
                                                  columnWidths: {
                                                    0: FixedColumnWidth(width *
                                                        (isMobile
                                                            ? 0.015
                                                            : 0.01978)),
                                                    1: FixedColumnWidth(width *
                                                        (isMobile
                                                            ? 0.16
                                                            : 0.19790)),
                                                    2: FixedColumnWidth(width *
                                                        (isMobile
                                                            ? 0.04
                                                            : 0.053)),
                                                  },
                                                  children: [
                                                    TableRow(
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  vertical:
                                                                      12.0),
                                                          child: Container(
                                                            width: width *
                                                                (isMobile
                                                                    ? 0.015
                                                                    : 0.01979),
                                                            height: height *
                                                                (isMobile
                                                                    ? 0.025
                                                                    : 0.0351),
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Color(
                                                                  0xFF6394F9),
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          6),
                                                            ),
                                                            padding: EdgeInsets
                                                                .symmetric(
                                                              vertical: width *
                                                                  (isMobile
                                                                      ? 0.002
                                                                      : 0.003),
                                                              horizontal: height *
                                                                  (isMobile
                                                                      ? 0.004
                                                                      : 0.0055),
                                                            ),
                                                            child: Text(
                                                              item["number"]!
                                                                  .padLeft(
                                                                      2, '0'),
                                                              maxLines: 1,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: width *
                                                                    (isMobile
                                                                        ? 0.008
                                                                        : 0.01041),
                                                                fontFamily:
                                                                    'Pretendard',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .left,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding: EdgeInsets.fromLTRB(
                                                              width *
                                                                  (isMobile
                                                                      ? 0.006
                                                                      : 0.0083),
                                                              height *
                                                                  (isMobile
                                                                      ? 0.012
                                                                      : 0.0148),
                                                              0,
                                                              height * 0.0148),
                                                          child:
                                                              GestureDetector(
                                                            onTap: () async {
                                                              final Uri uri =
                                                                  Uri.parse(item[
                                                                      "link"]!);
                                                              if (await canLaunchUrl(
                                                                  uri)) {
                                                                await launchUrl(
                                                                    uri);
                                                              } else {
                                                                throw 'Could not launch ${item["link"]}';
                                                              }
                                                            },
                                                            child: Text(
                                                              item["title"]!,
                                                              style: TextStyle(
                                                                color: Colors
                                                                    .black,
                                                                fontSize: width *
                                                                    (isMobile
                                                                        ? 0.007
                                                                        : 0.009),
                                                                fontFamily:
                                                                    'Pretendard',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w500,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        Container(
                                                          width: width *
                                                              (isMobile
                                                                  ? 0.04
                                                                  : 0.0447),
                                                          padding: EdgeInsets
                                                              .fromLTRB(
                                                                  0,
                                                                  height *
                                                                      (isMobile
                                                                          ? 0.012
                                                                          : 0.0148),
                                                                  width *
                                                                      0.0083,
                                                                  0),
                                                          child: Text(
                                                            item["date"]!,
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color: Color(
                                                                      0xff191919)
                                                                  .withOpacity(
                                                                      0.4),
                                                              fontSize: width *
                                                                  (isMobile
                                                                      ? 0.0075
                                                                      : 0.0093),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400,
                                                              letterSpacing: -1,
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (index <
                                                  downloadData.length - 1)
                                                Column(children: [
                                                  SizedBox(
                                                      height: height *
                                                          (isMobile
                                                              ? 0.01
                                                              : 0.0148)),
                                                  Divider(
                                                      color: Color(0xff191919)
                                                          .withOpacity(0.2),
                                                      thickness: 1,
                                                      height: 1),
                                                ])
                                            ],
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * (isMobile ? 0.06 : 0.0833),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * (isMobile ? 0.04 : 0.0125),
                            ),
                            Container(
                              color: Colors.white,
                              child: Column(children: [
                                SizedBox(
                                  height: height * (isMobile ? 0.02 : 0.2222),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xFFD9D9D9)),
                                      child: IconButton(
                                        onPressed: null,
                                        icon: Icon(Icons.arrow_back_ios_sharp),
                                        color: Color(0xff6194f9),
                                      ),
                                    ),
                                    SizedBox(
                                        width: width * (isMobile ? 0 : 0.004)),
                                    // ListView로 3개 아이템을 한 번에 보여줌
                                    Container(
                                      width: width * (isMobile ? 0.38 : 0.3307),
                                      height:
                                          height * (isMobile ? 0.15 : 0.2935),
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: downloadData.length,
                                        itemBuilder: (context, index) {
                                          final item = downloadData[index];
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: width *
                                                    (isMobile
                                                        ? 0.002
                                                        : 0.0025)),
                                            child: GestureDetector(
                                              onTap: () async {
                                                final Uri uri =
                                                    Uri.parse(item["link"]!);
                                                if (await canLaunchUrl(uri)) {
                                                  await launchUrl(uri);
                                                } else {
                                                  throw 'Could not launch ${item["link"]}';
                                                }
                                              },
                                              child: Container(
                                                width: width *
                                                    (isMobile ? 0.11 : 0.1036),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black
                                                          .withOpacity(0.2),
                                                      blurRadius: 6,
                                                      offset: Offset(
                                                          0,
                                                          height *
                                                              (isMobile
                                                                  ? 0.002
                                                                  : 0.0027)),
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: [
                                                    SizedBox(
                                                      height: height *
                                                          (isMobile
                                                              ? 0.20
                                                              : 0.2592),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius.vertical(
                                                                top: Radius
                                                                    .circular(
                                                                        10.0)),
                                                        child: Image.asset(
                                                          item["image"]!,
                                                          fit: BoxFit.cover,
                                                          width:
                                                              double.infinity,
                                                        ),
                                                      ),
                                                    ),
                                                    Container(
                                                      width: double.infinity,
                                                      height: height *
                                                          (isMobile
                                                              ? 0.015
                                                              : 0.034),
                                                      padding:
                                                          EdgeInsets.fromLTRB(
                                                        width *
                                                            (isMobile
                                                                ? 0.003
                                                                : 0.0041),
                                                        height *
                                                            (isMobile
                                                                ? 0.005
                                                                : 0.0074),
                                                        width *
                                                            (isMobile
                                                                ? 0.003
                                                                : 0.0041),
                                                        height *
                                                            (isMobile
                                                                ? 0.004
                                                                : 0.0054),
                                                      ),
                                                      color: Color(0xFF6394F9)
                                                          .withOpacity(0.2),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            item["number"]!
                                                                .padLeft(
                                                                    2, '0'),
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color: Color(
                                                                  0xFF6194F9),
                                                              fontSize: width *
                                                                  (isMobile
                                                                      ? 0.006
                                                                      : 0.0072),
                                                              fontFamily:
                                                                  'Pretendard',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                          SizedBox(
                                                              width: width *
                                                                  0.004),
                                                          Text(
                                                            item["title"]!,
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.black,
                                                              fontSize: width *
                                                                  (isMobile
                                                                      ? 0.006
                                                                      : 0.0072),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w600,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),

                                    Container(
                                      decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: Color(0xff6194f9)
                                              .withOpacity(0.3)),
                                      child: IconButton(
                                        onPressed: _previousPage,
                                        icon:
                                            Icon(Icons.arrow_forward_ios_sharp),
                                        color: Color(
                                            0xff6194f9), // 아이콘 색상을 흰색으로 변경
                                      ),
                                    ),
                                  ],
                                ),
                              ]),
                            )
                          ],
                        ),
                      ),
                      //Download 부분
                      Container(
                        height: height * (isMobile ? 0.5 : 0.9),
                        color: Colors.white,
                        alignment: Alignment.topLeft,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: width * (isMobile ? 0.1 : 0.1875),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: height * (isMobile ? 0.09 : 0.20),
                                    ),
                                    Container(
                                      width: width * (isMobile ? 0.1 : 0.125),
                                      height:
                                          height * (isMobile ? 0.04 : 0.0630),
                                      child: Text(
                                        'Direction',
                                        style: TextStyle(
                                          color: Color(0xFF191919),
                                          fontSize: width *
                                              (isMobile ? 0.02 : 0.0291),
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: isMobile
                                            ? height * 0.005
                                            : height * 0.0657),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: width * 0.3,
                                          height: height * 0.4500,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: width * 0.3,
                                                height: height * 0.0435,
                                                decoration: ShapeDecoration(
                                                  color: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x26000000),
                                                      blurRadius: 30,
                                                      offset: Offset(0, 0),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width * 0.0089,
                                                      height: height * 0.0203,
                                                      child: Image.asset(
                                                        'assets/direction.png',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.005,
                                                    ),
                                                    SelectableText(
                                                      '경기사무소',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF96b9ff),
                                                        fontSize:
                                                            width * 0.0114,
                                                        fontFamily:
                                                            'Pretendard',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0.06,
                                                        letterSpacing: 0.66,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.0083,
                                              ),
                                              Container(
                                                width: width *
                                                    (isMobile ? 0.4 : 0.3),
                                                height: height *
                                                    (isMobile ? 0.3 : 0.32),
                                                child: _iframeWidget1,
                                              ),
                                              SizedBox(
                                                height: height * 0.0083,
                                              ),
                                              SelectableText(
                                                '(18021) 경기 평택시 도시지원로 121 고덕지식공작소아이타워 510호',
                                                style: TextStyle(
                                                  color: Color(0xFF191919),
                                                  fontSize: width * 0.009,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.54,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: width * 0.0239,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: height * (isMobile ? 0.09 : 0.20),
                                    ),
                                    Container(
                                      width: width * (isMobile ? 0.1 : 0.125),
                                      height:
                                          height * (isMobile ? 0.04 : 0.0630),
                                      child: Text(
                                        '',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width *
                                              (isMobile ? 0.02 : 0.0291),
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -1,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                        height: isMobile
                                            ? height * 0.005
                                            : height * 0.0657),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: width * 0.3,
                                          height: height * 0.4500,
                                          child: Column(
                                            children: [
                                              Container(
                                                width: width * 0.3,
                                                height: height * 0.0435,
                                                decoration: ShapeDecoration(
                                                  color: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              6)),
                                                  shadows: [
                                                    BoxShadow(
                                                      color: Color(0x26000000),
                                                      blurRadius: 30,
                                                      offset: Offset(0, 0),
                                                      spreadRadius: 0,
                                                    )
                                                  ],
                                                ),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                      width: width * 0.0089,
                                                      height: height * 0.0203,
                                                      child: Image.asset(
                                                        'assets/direction.png',
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: width * 0.005,
                                                    ),
                                                    SelectableText(
                                                      '대전사무소',
                                                      style: TextStyle(
                                                        color:
                                                            Color(0xFF96b9ff),
                                                        fontSize:
                                                            width * 0.0114,
                                                        fontFamily:
                                                            'Pretendard',
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        height: 0.06,
                                                        letterSpacing: 0.66,
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              SizedBox(
                                                height: height * 0.0083,
                                              ),
                                              Container(
                                                width: width *
                                                    (isMobile ? 0.4 : 0.3),
                                                height: height *
                                                    (isMobile ? 0.3 : 0.32),
                                                child: _iframeWidget2,
                                              ),
                                              SizedBox(
                                                height: height * 0.0083,
                                              ),
                                              SelectableText(
                                                '(34816) 대전광역시 중구 목동로 42 302호(목동복합빌딩)',
                                                style: TextStyle(
                                                  color: Color(0xFF191919),
                                                  fontSize: width * 0.009,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w500,
                                                  letterSpacing: 0.54,
                                                ),
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: width * (isMobile ? 0.02 : 0.0260),
                                ),
                              ],
                            ),
                            // 우측 하단 고정 버튼
                            Positioned(
                              bottom: height * (isMobile ? 0.08 : 0.1296),
                              right: width * (isMobile ? 0.02 : 0.0333),
                              child: InkWell(
                                onTap: () {
                                  _scrollController.animateTo(
                                    0,
                                    duration: Duration(seconds: 1),
                                    curve: Curves.easeInOut,
                                  );
                                },
                                child: Image.asset(
                                  'assets/scroll_up.png',
                                  width: width * (isMobile ? 0.02 : 0.0328),
                                  height: height * (isMobile ? 0.04 : 0.05833),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Direction 부분
                      Container(
                        height: height * (isMobile ? 0.2 : 0.3657),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/gradient_background.png"),
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),
                      //그라디언트 백그라운드
                      Container(
                        height: height * (isMobile ? 0.25 : 0.4500),
                        color: Colors.black,
                        child: Column(
                          children: [
                            SizedBox(
                              height: height * (isMobile ? 0.01 : 0.0666),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width * (isMobile ? 0.1 : 0.1703),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    buildTextButton2(
                                        "HOME",
                                        0,
                                        width * (isMobile ? 0.012 : 0.00729),
                                        width * (isMobile ? 0.14 : 0.065),
                                        height * (isMobile ? 0.04 : 0.0425),
                                        onItemTapped),
                                    buildTextButton2(
                                        "COMPANY",
                                        1,
                                        width * (isMobile ? 0.012 : 0.00729),
                                        width * (isMobile ? 0.14 : 0.065),
                                        height * (isMobile ? 0.04 : 0.0425),
                                        onItemTapped),
                                    buildTextButton2(
                                        "PRODUCTS",
                                        2,
                                        width * (isMobile ? 0.012 : 0.00729),
                                        width * (isMobile ? 0.14 : 0.065),
                                        height * (isMobile ? 0.04 : 0.0425),
                                        onItemTapped),
                                    buildTextButton2(
                                        "CONTACT US",
                                        3,
                                        width * (isMobile ? 0.012 : 0.00729),
                                        width * (isMobile ? 0.14 : 0.065),
                                        height * (isMobile ? 0.04 : 0.0425),
                                        onItemTapped),
                                    buildTextButton2(
                                        "DOWNLOADS",
                                        4,
                                        width * (isMobile ? 0.012 : 0.00729),
                                        width * (isMobile ? 0.14 : 0.065),
                                        height * (isMobile ? 0.04 : 0.0425),
                                        onItemTapped),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(
                              height: height * (isMobile ? 0.005 : 0.025),
                            ),
                            Container(
                              width: width * (isMobile ? 0.9 : 0.625),
                              child: Divider(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: height * (isMobile ? 0.005 : 0.0416),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(
                                  width: width * (isMobile ? 0.12 : 0.1875),
                                ),
                                Container(
                                  width: width * (isMobile ? 0.7 : 0.3156),
                                  height: height * (isMobile ? 0.05 : 0.0472),
                                  child: SelectableText(
                                    '대전사무소 | (34816) 대전광역시 중구 목동로 42 302호(목동복합빌딩)\n경기사무소 | (18021) 경기 평택시 도시지원로 121 고덕지식공작소아이타워 510호',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize:
                                          width * (isMobile ? 0.012 : 0.0093),
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 0.54,
                                    ),
                                  ),
                                )
                              ],
                            ),
                            SizedBox(
                              height: height * (isMobile ? 0 : 0.042),
                            ),
                            Container(
                              height: height * 0.0680,
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: isMobile
                                          ? width * 0.12
                                          : width * 0.18),
                                  Transform.translate(
                                    offset: Offset(0, -height * 0.01388),
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                      size: isMobile ? 8 : 18,
                                    ),
                                  ),
                                  SizedBox(width: width * 0.0041),
                                  Container(
                                    width: isMobile
                                        ? width * 0.095
                                        : width * 0.0807,
                                    height: height * 0.0462,
                                    child: SelectableText(
                                      '070-8098-7424',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.0093,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.54,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.0083),
                                  Transform.translate(
                                    offset: Offset(0, -height * 0.0111),
                                    child: Icon(
                                      Icons.print,
                                      color: Colors.white,
                                      size: isMobile ? 8 : 18,
                                    ),
                                  ),
                                  SizedBox(width: width * 0.0041),
                                  Container(
                                    width: isMobile
                                        ? width * 0.095
                                        : width * 0.08333,
                                    height: height * 0.0462,
                                    child: SelectableText(
                                      '042-367-7427',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.009,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.54,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.004),
                                  Transform.translate(
                                    offset: Offset(0, -height * 0.0111),
                                    child: Icon(
                                      Icons.local_post_office,
                                      color: Colors.white,
                                      size: isMobile ? 8 : 18,
                                    ),
                                  ),
                                  SizedBox(width: width * 0.004),
                                  Container(
                                    width: isMobile
                                        ? width * 0.15
                                        : width * 0.1458,
                                    height: height * 0.0462,
                                    child: SelectableText(
                                      'cmkim@new-chem.co.kr',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: width * 0.0093,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.54,
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: width * 0.125),
                                  Transform.translate(
                                    offset: Offset(0, -height * 0.0111),
                                    child: Container(
                                      width: width * 0.1468,
                                      child:
                                          Image.asset('assets/logo-white.png'),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: height * (isMobile ? 0 : 0.04351),
                            ),
                            Row(
                              children: [
                                SizedBox(
                                    width: width * (isMobile ? 0.12 : 0.1979)),
                                Text(
                                  'COPYRIGHT ⓒ NewChem (뉴켐) All rights reserved',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.3),
                                    fontSize:
                                        width * (isMobile ? 0.011 : 0.0093),
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.54,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      // 회사 주소, 연락처
                    ],
                  )),
            ),
          );
        }),
      ),
    );
  }

// Widget for brand buttons
  BrandButton(
      String brandName, String imagePath, double width, double height) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        final width = size.width;
        final height = size.height;
        final isMobile = width < 600 && height < 916;

        return Padding(
          padding: EdgeInsets.symmetric(
              horizontal: height * (isMobile ? 0.01 : 0.0078)),
          child: Column(
            children: [
              Image.asset(
                imagePath,
                width: isMobile ? width * 0.3 : width,
                height: isMobile ? height * 0.3 : height,
              ),
              if (!isMobile)
                Text(
                  brandName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: isMobile ? width * 0.03 : width * 0.0072,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }

// Widget for product card
  Widget buildProductCard(String title, String imagePath, String content,
      BuildContext context, double width, double height) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      final isMobile = width < 600 && height < 916;
      return Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
            ),
            child: Transform.scale(
              scale: isMobile ? 0.75 : 1.0,
              child: Image.asset(
                imagePath,
                width: width,
                height: height,
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              ),
            ),
            width: width * 1.01,
            child: Center(
              child: Text(
                title,
                style: TextStyle(
                  fontSize: isMobile ? 10 : 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      );
    });
  }

// 링크 셀 빌더
  Widget _buildLinkCell(
      String title, String url, double fontSize, double letterSpacing) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isMobile = width < 600 && height < 916;

    return Padding(
      padding: EdgeInsets.fromLTRB(
        width * (isMobile ? 0.006 : 0.0041),
        height * (isMobile ? 0.01 : 0.0074),
        width * (isMobile ? 0.006 : 0.0041),
        height * (isMobile ? 0.01 : 0.0074),
      ),
      child: GestureDetector(
        onTap: () async {
          final Uri uri = Uri.parse(url);
          if (await canLaunchUrl(uri)) {
            await launchUrl(uri);
          } else {
            throw 'Could not launch $url';
          }
        },
        child: Text(
          title,
          style: TextStyle(
            color: Colors.blue,
            decoration: TextDecoration.underline,
            fontSize: isMobile ? fontSize * 1.2 : fontSize,
            letterSpacing: letterSpacing,
          ),
        ),
      ),
    );
  }

// Product Card Widget
  Widget _buildProductCard(
      String name, String imagePath, String content, BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // 텍스트를 이미지 중앙 정렬
        children: [
          GestureDetector(
            onTap: () {
              _dialogBuilder(context, name, imagePath, content);
            },
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              width: 300,
              height: 300,
            ),
          ),
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Future<void> _dialogBuilder(
      BuildContext context, String name, String image, String content) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        final size = MediaQuery.of(context).size;
        final width = size.width;
        final height = size.height;
        final isMobile = width < 600 && height < 916;

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          title: Row(
            children: [
              Text(name),
              Spacer(),
              IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(Icons.close),
              ),
            ],
          ),
          content: Container(
            height: isMobile ? height * 0.4 : height * 0.4629,
            child: Column(
              children: [
                Image.asset(
                  image,
                  fit: BoxFit.contain,
                  width: isMobile ? width * 0.2 : width * 0.1562,
                  height: isMobile ? height * 0.2 : height * 0.2777,
                ),
                Text(content),
              ],
            ),
          ),
        );
      },
    );
  }
}

// 전역에서 사용 가능한 `buildTextButton` 함수 정의
Container buildTextButton2(String label, int index, double buttonFontSize,
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
        ),
      ),
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        overlayColor: Colors.transparent, // 눌렀을 때 생기는 그림자 제거
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero,
        ),
      ),
    ),
  );
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}
