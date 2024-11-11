import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'dart:html' as html; // Web용 dart:html 패키지 사å용
import 'dart:ui_web' as ui;
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'popup.dart';
import 'dart:html' as html;
import 'package:newchem_flutter_website/main.dart';

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
  final CarouselSliderController _controller = CarouselSliderController();
  final ScrollController _scrollController = ScrollController();
  bool isHovered = false;

  final List<String> _backgroundImages = [
    'assets/main-background2.png',
    'assets/main-background4.png',
    'assets/main-background6.png',
  ];
  String url =
      'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d669.6223690480622!2d127.01586977089258!3d37.02699966322705!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b3d001631c641%3A0x2cd353d15ed8488b!2z6rOg642V7KeA7Iud6rO17J6R7IaM7JWE7J207YOA7JuMIOyngOyLneyCsOyXheyEvO2EsA!5e0!3m2!1sko!2skr!4v1717727526433!5m2!1sko!2skr" width="400" height="350" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade';
  int _currentStep = 1; // 현재 단계 설정
  double _lineOpacity = 0.2; // 선의 초기 불투명도
  final Widget _iframeWidget = HtmlElementView(
    viewType: 'iframeElement',
    key: UniqueKey(),
  );

  final List<Map<String, String>> productData = [
    {
      "id": "1",
      "title": "Hei-VAP Series (탁상형 농축기)",
      "image": "assets/products/Hei-VAP_Series.png",
      "content": "제품에 대한 설명"
    },
    {
      "id": "2",
      "title": "Magnetic Stirrer (자력 교반기)",
      "image": "assets/products/Magnetic_stirrer.png",
      "content": "제품에 대한 설명"
    },
    {
      "id": "3",
      "title": "오버헤드 교반기",
      "image": "assets/products/Overhead_stirrer.png",
      "content": "제품에 대한 설명"
    },
    {
      "id": "4",
      "title": "Lab Fast Pro",
      "image": "assets/products/Lab_Fast_Pro.png",
      "content": "제품에 대한 설명"
    },
    {
      "id": "5",
      "title": "Pilot Compact Reactor (10 ~ 30L)",
      "image": "assets/products/Pilot_compact_reactor.png",
      "content": "제품에 대한 설명"
    },
    {
      "id": "6",
      "title": "CINC Industry",
      "image": "assets/products/Cinc_Industry_Product.png",
      "content": "제품에 대한 설명"
    },
  ];

  final List<Map<String, dynamic>> slideImages = [
    {
      'image': 'assets/sliderbackground01.png',
      'name': 'Rotary Evaporator',
      'logo': 'assets/heidolph_logo.png',
      'route': '0',
      'description':
          '뉴켐은 실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지 합성 실험에 필요한\n모든 솔루션을 제공하는 회사입니다.(제품에 대한 간단한 설명)',
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
      'route': '0',
      'description':
          '뉴켐은 실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지 합성 실험에 필요한\n모든 솔루션을 제공하는 회사입니다.(제품에 대한 간단한 설명)',
      'productImages': [
        'assets/products/Magnetic_stirrer.png',
        'assets/products/Overhead_stirrer.png'
      ],
      'productName': ['Magnetic stirrer', '오버헤드 교반기']
    },
    {
      'image': 'assets/sliderbackground03.png',
      'name': 'Automation',
      'logo': 'assets/heidolph_logo.png',
      'route': '0',
      'description':
          '뉴켐은 실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지 합성 실험에 필요한\n모든 솔루션을 제공하는 회사입니다.(제품에 대한 간단한 설명)',
      'productImages': [
        'assets/products/Hei-Process_Cloud_Core.png',
      ],
      'productName': [
        'Hei-Process Cloud Core',
      ]
    },
    {
      'image': 'assets/sliderbackground04.png',
      'name': 'Voltex & Shaking',
      'logo': 'assets/heidolph_logo.png',
      'route': '0',
      'description':
          '뉴켐은 실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지 합성 실험에 필요한\n모든 솔루션을 제공하는 회사입니다.(제품에 대한 간단한 설명)',
      'productImages': [
        'assets/products/Platform_shakers.png',
        'assets/products/Vortexer.png',
        'assets/products/Overhead_stirrer.png'
      ],
      'productName': ['Platform shakers', 'Vortexer', '오버헤드 쉐이커']
    },
    {
      'image': 'assets/sliderbackground05.png',
      'name': 'Liquid handling',
      'logo': 'assets/heidolph_logo.png',
      'route': '0',
      'description':
          '뉴켐은 실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지 합성 실험에 필요한\n모든 솔루션을 제공하는 회사입니다.(제품에 대한 간단한 설명)',
      'productImages': [
        'assets/products/Liquid_handling.png',
      ],
      'productName': ['Liquid handling']
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
    super.dispose();
  }

  String getStepLabel(int index) {
    switch (index) {
      case 0:
        return '문의 작성';
      case 1:
        return '답변 중';
      case 2:
        return '답변 완료';
      default:
        return '';
    }
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
    final isM = width < 600;
    // width와 height 모두를 고려한 반응형 조건 설정
    final isMobile = width < 600 && height < 800;
    final isTablet = width >= 600 && width < 1024 && height < 1200;
    final isDesktop = width >= 1024 && height >= 1200;

    final html.IFrameElement _iFrameElement = html.IFrameElement();

    _iFrameElement.style.height = isM ? '150%' : '120%';
    _iFrameElement.style.width = isM ? '100' : '80%';
    _iFrameElement.src = '${url}';
    _iFrameElement.style.border = 'none';
// ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iFrameElement,
    );

//내 컴퓨터 환경 2560 * 1440
    return MaterialApp(
      home: LayoutBuilder(builder: (context, constraints) {
        return Scaffold(
          backgroundColor: Color(0xffd4e2f5).withOpacity(0.9),
          body: SingleChildScrollView(
            controller: _scrollController,
            child: Container(
                width: width,
                height: height * 4.665, //뭔가 항목 늘릴때 사용해라.
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.zero,
                      width: width,
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Column의 높이를 자식 크기에 맞춤
                        children: [
                          Stack(
                            children: [
                              CarouselSlider(
                                carouselController: _controller,
                                items: slideImages.map((item) {
                                  return GestureDetector(
                                    onTap: () {
                                      widget.onProductNavigate(
                                          int.parse(item['route']!));
                                    },
                                    child: Container(
                                      width: width,
                                      height: height * 1.111,
                                      child: Stack(
                                        children: [
                                          Image.asset(
                                            item['image']!,
                                            fit: BoxFit.fill,
                                            width: width,
                                            height: height * 1.111,
                                          ),
                                          Center(
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                    height: height * 0.2129),
                                                Text(
                                                  item['name']!,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.0281,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: height * 0.0296),
                                                Text(
                                                  item['description']!,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: width * 0.0101,
                                                    fontFamily: 'Pretendard',
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: 0.60,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: height * 0.0694),
                                                Container(
                                                  width: width * 0.0968,
                                                  height: height * 0.05,
                                                  color: Colors.transparent,
                                                  child: InkWell(
                                                    onTap: () {
                                                      widget.onNavigate(1);
                                                    },
                                                    child: MouseRegion(
                                                      onEnter: (_) => setState(() => isHovered = true),
                                                      onExit: (_) => setState(() => isHovered = false),
                                                      child: Container(
                                                        alignment:
                                                        Alignment.center,
                                                        decoration: BoxDecoration(
                                                          border: Border.all(
                                                              color:  isHovered ?  Color(0xff5695F0) : Colors.white,
                                                              width:
                                                              width * 0.001),
                                                          borderRadius:
                                                          BorderRadius
                                                              .circular(61),
                                                        ),
                                                        child: Text(
                                                          'company',
                                                          style: TextStyle(
                                                            color: isHovered ? Color(0xff5695F0) : Colors.white,
                                                            fontSize:
                                                            width * 0.0125,
                                                            fontFamily:
                                                            'Pretendard',
                                                            fontWeight:
                                                            FontWeight.w600,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: height * 0.042),
                                                // 추가된 productImages와 productName을 위한 Row

                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ...List.generate(
                                                      item['productImages']
                                                          .length,
                                                      (index) {
                                                        String productImage =
                                                            item['productImages']
                                                                [index];
                                                        String productName =
                                                            item['productName']
                                                                [index];
                                                        return Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .symmetric(
                                                                  horizontal:
                                                                      8.0),
                                                          child: Container(
                                                            width: width * 0.2479,
                                                            height: height * 0.4407,
                                                            decoration:
                                                                ShapeDecoration(
                                                              color: Colors
                                                                  .white
                                                                  .withOpacity(
                                                                      0.65),
                                                              shape:
                                                                  RoundedRectangleBorder(
                                                                side: BorderSide(
                                                                    width: width * 0.001,
                                                                    color: Colors
                                                                        .white),
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            8),
                                                              ),
                                                            ),
                                                            child: Column(
                                                              children: [
                                                                SizedBox(
                                                                    height: height * 0.0303),
                                                                Image.asset(
                                                                  item['logo'],
                                                                  width: width * 0.036,
                                                                  // 로고 이미지의 크기 조정
                                                                  height: height * 0.0129,
                                                                  fit: BoxFit
                                                                      .fitWidth,
                                                                ),
                                                                Text(
                                                                  productName,
                                                                  style:
                                                                      TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        width * 0.015,
                                                                    fontFamily:
                                                                        'Pretendard',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                    height: height * 0.0011,
                                                                  ),
                                                                ),
                                                                SizedBox(
                                                                    height: 16),
                                                                Image.asset(
                                                                  productImage,
                                                                  width: width *
                                                                      0.2,
                                                                  height: height * 0.2879,
                                                                  fit: BoxFit
                                                                      .contain,
                                                                ),
                                                                SizedBox(
                                                                  height: height * 0.00690,
                                                                ),
                                                                Text(
                                                                  'NewChem',
                                                                  style:
                                                                      TextStyle(
                                                                    color: Color(
                                                                            0xFF729DF6)
                                                                        .withOpacity(
                                                                            0.7),
                                                                    fontSize:
                                                                        width * 0.009,
                                                                    fontFamily:
                                                                        'Pretendard',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .w500,
                                                                  ),
                                                                ),
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
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }).toList(),
                                options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 1,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  },
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(height: height * 0.2352),
                                      ...slideImages
                                          .asMap()
                                          .entries
                                          .map((entry) {
                                        return Column(
                                          children: [
                                            GestureDetector(
                                              onTap: () {
                                                _controller
                                                    .animateToPage(entry.key);
                                              },
                                              child: Container(
                                                width: width * 0.0166,
                                                // 바깥쪽 원의 크기를 좀 더 크게 설정
                                                height: height * 0.0296,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 4.0),
                                                decoration: BoxDecoration(
                                                  shape: BoxShape.circle,
                                                  color: _current == entry.key
                                                      ? Colors.transparent
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                    color: _current == entry.key
                                                        ? Colors.white
                                                        : Colors.transparent,
                                                    width: _current == entry.key
                                                        ? 1
                                                        : 0, // 선택된 항목에만 테두리를 주기
                                                  ),
                                                ),
                                                child: Center(
                                                  child: Container(
                                                    width: width * 0.0052,
                                                    // 선택된 항목일 때 작은 원을 표시
                                                    height: height * 0.0092,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        color: Colors.white),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(height: height * 0.02549),

                                            // 원 사이의 간격 설정
                                          ],
                                        );
                                      }).toList(),
                                      SizedBox(
                                        height: height * 0.3450,
                                      ),
                                      Transform(
                                        transform: Matrix4.identity()
                                          ..translate(10, 12)
                                          ..rotateZ(-1.57),
                                        child: Text(
                                          'Scroll',
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.0083,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w500,
                                            height: 0,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: height * 0.0050,
                                      ),
                                      Image.asset('assets/arrow_down.png'),
                                    ],
                                  ),
                                  SizedBox(
                                    width: width * 0.02239,
                                  ),
                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      color: Colors.white,
                      height: height * 0.8352,
                      child: Column(
                        children: [
                          SizedBox(height: height * 0.1388),
                          Text(
                            'Contacts Us',
                            style: TextStyle(
                              color: Color(0xFF191919),
                              fontSize: width * 0.0291,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w700,
                              height: 0,
                            ),
                          ),
                          SizedBox(height: height * 0.011),
                          Text(
                            '전문가에게 맡겨주세요 ',
                            style: TextStyle(
                              color: Color(0xFF191919),
                              fontSize: width * 0.0145,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          SizedBox(height: height * 0.0444),
                          SelectableText(
                            '문의 및 상담 내용을 작성해서 접수하시면',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF191919),
                              fontSize: width * 0.0104,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SelectableText(
                            '전문가들이 24시간 이내에 빠르고 성실하게 답변 드리겠습니다.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF191919),
                              fontSize: width * 0.0104,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          // 진행 단계 표시 Row 추가
                          SizedBox(height: height * 0.1421),
                          // Step Progress Indicator
                          Container(
                            padding: EdgeInsets.symmetric(vertical: width * 0.0083),
                            // child: Row(
                            //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                            //   children: List.generate(5, (index) {
                            //     if (index.isOdd) {
                            //       // 선 표시
                            //       return AnimatedContainer(
                            //         duration: Duration(milliseconds: 800),
                            //         width: width * 0.0260,
                            //         height: height * 0.0018,
                            //         color: Colors.blue.withOpacity(
                            //           index <= _currentStep * 2 ? 1.0 : 0.2,
                            //         ),
                            //       );
                            //     } else {
                            //       // 원 표시
                            //       int stepIndex = index ~/ 2;
                            //       bool isActive = stepIndex == _currentStep;
                            //       return Column(
                            //         children: [
                            //           CircleAvatar(
                            //             radius: isActive ? 12 : 10,
                            //             backgroundColor: isActive
                            //                 ? Colors.blue
                            //                 : Colors.grey,
                            //           ),
                            //           SizedBox(height: height * 0.0074),
                            //           Text(
                            //             getStepLabel(stepIndex),
                            //             style: TextStyle(
                            //               color: isActive
                            //                   ? Colors.blue
                            //                   : Colors.grey,
                            //               fontWeight: isActive
                            //                   ? FontWeight.bold
                            //                   : FontWeight.normal,
                            //             ),
                            //           ),
                            //         ],
                            //       );
                            //     }
                            //   }),
                            // ),
                          ),
                          SizedBox(height: height * 0.0740),

                          Container(
                            width: width * 0.1682,
                            height: height * 0.0574,
                            child: ElevatedButton(
                              onPressed: () {
                                widget.onNavigate(3);
                              },
                              child: Text(
                                '문의하기',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.0125,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w600,
                                  height: 0,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: Color(0xff5695F0),
                                  foregroundColor: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.5787,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/main-background00.png"),
                          fit: BoxFit.cover, // 이미지를 전체 배경에 맞게 채움
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * 0.1875,
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.2129,
                                ),
                                Text(
                                  'Welcome',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    color: Color(0xFF191919),
                                    fontSize: width * 0.02916,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w700,
                                    height: 0,
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.007,
                                ),
                                Container(
                                  width: width * 0.2906,
                                  height: height * 0.006,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      begin: Alignment(1.00, 0.00),
                                      end: Alignment(-1, 0),
                                      colors: [
                                        Color(0xFF6194F9),
                                        Color(0xFF82ACFF)
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.0833,
                                ),
                                InkWell(
                                  onTap: () {
                                    widget.onNavigate(1);
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        'more view',
                                        style: TextStyle(
                                          color: Color(0xFF6194F9),
                                          fontSize: width * 0.0112,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w400,
                                          height: height * 0.00006,
                                        ),
                                      ),
                                      Icon(
                                        Icons.arrow_right,
                                        color: Color(0xFF6194F9),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                          SizedBox(width: width * 0.03177),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.1851,
                                ),
                                Text(
                                  '(주) 뉴켐은 실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지\n합성 실험에 필요한 모든 솔루션을 제공하는 회사입니다.\n지난 20년간 화학 및 의약 연구 분야에서 수많은 제품과 시스템을 공급하며,\n고객이 신뢰할 수 있는 회사로 자리 매김해 왔습니다.\n앞으로도 지속적인 성원 부탁드립니다.\n저희 뉴켐은 언제나 고객과 함께 하겠습니다.',
                                  style: TextStyle(
                                    color: Color(0xFF191919),
                                    fontSize: width * 0.0104,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: height * 0.0020,
                                  ),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      height: height * 0.6018,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: width * 0.1875,
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: height * 0.2037,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Downloads',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        color: Color(0xFF191919),
                                        fontSize: width * 0.02916,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w700,
                                        height: 0,
                                      ),
                                    ),
                                    SizedBox(
                                      width: width * 0.0442,
                                    ),
                                    Transform.translate(
                                      offset: Offset(0, height * 0.009),
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
                                                fontSize: width * 0.01119,
                                                fontFamily: 'Pretendard',
                                                fontWeight: FontWeight.w400,
                                                height: height * 0.00006,
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
                                  height: height * 0.0074,
                                ),
                                Container(
                                  width: width * 0.26145,
                                  height: height * 0.00277,
                                  decoration:
                                      BoxDecoration(color: Color(0xFF6194F9)),
                                ),
                                SizedBox(
                                  height: height * 0.0055,
                                ),
                                Container(
                                  padding: EdgeInsets.zero,
                                  width: width * 0.2614,
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
                                                  0, height * 0.0074, 0, 0),
                                              child: Table(
                                                columnWidths: {
                                                  0: FixedColumnWidth(
                                                      width * 0.01978),
                                                  1: FixedColumnWidth(
                                                      width * 0.19790),
                                                  2: FixedColumnWidth(
                                                      width * 0.053),
                                                },
                                                children: [
                                                  TableRow(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 12.0),
                                                        child: Container(
                                                          width:
                                                              width * 0.01979,
                                                          height:
                                                              height * 0.0351,
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
                                                                  vertical: 6.0,
                                                                  horizontal:
                                                                      6.0),
                                                          child: Text(
                                                            item["number"]!
                                                                .padLeft(
                                                                    2, '0'),
                                                            maxLines: 1,
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: width *
                                                                  0.01041,
                                                              fontFamily:
                                                                  'Pretendard',
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w500,
                                                            ),
                                                            textAlign:
                                                                TextAlign.left,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                16, 16, 0, 16),
                                                        child: GestureDetector(
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
                                                              color:
                                                                  Colors.black,
                                                              fontSize:
                                                                  width * 0.009,
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
                                                        width: width * 0.0447,
                                                        padding:
                                                            const EdgeInsets
                                                                .fromLTRB(
                                                                0, 16, 16, 0),
                                                        child: Text(
                                                          item["date"]!,
                                                          maxLines: 1,
                                                          style: TextStyle(
                                                            color: Color(
                                                                    0xff191919)
                                                                .withOpacity(
                                                                    0.4),
                                                            fontSize:
                                                                width * 0.0093,
                                                            fontWeight:
                                                                FontWeight.w400,
                                                            letterSpacing: -1,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                            // 마지막 항목이 아닌 경우에만 `Divider` 추가
                                            if (index < downloadData.length - 1)
                                              Column(children: [
                                                SizedBox(
                                                  height: height * 0.0148,
                                                ),
                                                Divider(
                                                  color: Color(0xff191919)
                                                      .withOpacity(0.2),
                                                  thickness: 1,
                                                  height: 1,
                                                ),
                                              ])
                                          ],
                                        );
                                      }).toList(),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: height * 0.0833,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: width * 0.0125,
                          ),
                          Container(
                            color: Colors.white,
                            child: Column(children: [
                              SizedBox(
                                height: height * 0.2222,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // 왼쪽 화살표 아이콘
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        // color:
                                        //     Color(0xff6194f9).withOpacity(0.3)),
                                      color: Color(0xFFD9D9D9)),
                                    child: IconButton(
                                      //onPressed: _previousPage,
                                      onPressed: null,
                                      icon: Icon(Icons.arrow_back_ios_sharp),
                                      color:
                                          Color(0xff6194f9), // 아이콘 색상을 흰색으로 변경
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.004,
                                  ),
                                  // ListView로 3개 아이템을 한 번에 보여줌
                                  Container(
                                    width: width * 0.3307,
                                    // 3개 항목이 보이도록 전체 컨테이너 너비 설정
                                    height: height * 0.2935,
                                    // 슬라이드 높이
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemCount: downloadData.length,
                                      itemBuilder: (context, index) {
                                        final item = downloadData[index];
                                        return GestureDetector(
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
                                            width: width * 0.1036,
                                            // 개별 아이템 너비를 줄여서 3개가 보이게 함
                                            margin: EdgeInsets.symmetric(
                                                horizontal: 5.0),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withOpacity(0.2),
                                                  blurRadius: 6,
                                                  offset: Offset(0, 3),
                                                ),
                                              ],
                                            ),
                                            child: Column(
                                              children: [
                                                // 이미지 크기 줄이기
                                                SizedBox(
                                                  height: height * 0.2592,
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.vertical(
                                                            top:
                                                                Radius.circular(
                                                                    10.0)),
                                                    child: Image.asset(
                                                      item["image"]!,
                                                      fit: BoxFit.cover,
                                                      width: double.infinity,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  width: double.infinity,
                                                  padding: EdgeInsets.all(8.0),
                                                  color: Color(0xFF6394F9)
                                                      .withOpacity(0.2),
                                                  child: Text(
                                                    item["title"]!,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: width * 0.0072,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  // 오른쪽 화살표 아이콘
                                  Container(
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color(0xff6194f9).withOpacity(0.3)),
                                    child: IconButton(
                                      onPressed: _previousPage,
                                      icon: Icon(Icons.arrow_forward_ios_sharp),
                                      color:
                                          Color(0xff6194f9), // 아이콘 색상을 흰색으로 변경
                                    ),
                                  ),
                                ],
                              ),
                            ]),
                          )
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.18,),

                    Container(
                        height: height * 0.5462,
                        alignment: Alignment.topLeft,
                        color: Colors.white,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.1875,
                                ),
                                Column(
                                  children: [
                                    Container(
                                      width: width * 0.125,
                                      height: height * 0.0630,
                                      child: Text(
                                        'Direction',
                                        style: TextStyle(
                                          color: Color(0xFF191919),
                                          fontSize: width * 0.0291,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: -1,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  width: width * 0.0578,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: width * 0.554,
                                      height: height * 0.4166,
                                      child: _iframeWidget,
                                    ),
                                    SizedBox(
                                      height: height * 0.0925,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: width * 0.010,
                                          height: height * 0.025,
                                          child: Image.asset(
                                            'assets/direction.png',
                                          ),
                                        ),
                                        SizedBox(
                                          width: width * 0.0072,
                                        ),
                                        Text(
                                          '경기사무소 | (18021) 경기 평택시 도시지원로 121 고덕지식공작소아이타워 501호',
                                          style: TextStyle(
                                            color: Color(0xFF191919),
                                            fontSize: width * 0.0114,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.66,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: width * 0.0260,
                                ),
                              ],
                            ),
                            // 우측 하단 고정 버튼
                            Positioned(
                              bottom: height * 0.1296, // 하단 여백 설정
                              right: width * 0.0333, // 우측 여백 설정
                              child: InkWell(
                                onTap: () {
                                  _scrollController.animateTo(
                                    0, // 맨 위로 스크롤
                                    duration: Duration(seconds: 1),
                                    // 스크롤 애니메이션 시간
                                    curve: Curves.easeInOut, // 애니메이션 곡선
                                  );
                                },
                                child: Image.asset(
                                  'assets/scroll_up.png',
                                  width: width * 0.0328, // 버튼의 너비 (필요에 맞게 조절)
                                  height:
                                      height * 0.05833, // 버튼의 높이 (필요에 맞게 조절)
                                ),
                              ),
                            ),
                          ],
                        )),
                    Container(
                      height: height * 0.3657,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/bg-gradation01.png"),
                          fit: BoxFit.fill, // 이미지를 전체 배경에 맞게 채움
                        ),
                      ),
                    ),
                    Container(
                      height: height * 0.4500,
                      color: Colors.black,
                      child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.0666,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width * 0.1703,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  buildTextButton2(
                                      "HOME", 0, width * 0.00729, onItemTapped),
                                  SizedBox(
                                    width: width * 0.0020,
                                  ),
                                  buildTextButton2("COMPANY", 1,
                                      width * 0.00729, onItemTapped),
                                  SizedBox(
                                    width: width * 0.0020,
                                  ),
                                  buildTextButton2("PRODUCTS", 2,
                                      width * 0.00729, onItemTapped),
                                  SizedBox(
                                    width: width * 0.0020,
                                  ),
                                  buildTextButton2("CONTACT US", 3,
                                      width * 0.00729, onItemTapped),
                                  SizedBox(
                                    width: width * 0.0020,
                                  ),
                                  buildTextButton2("DOWNLOADS", 4,
                                      width * 0.00729, onItemTapped),
                                ],
                              ),

                            ],
                          ),
                          SizedBox(
                            height: height * 0.025,
                          ),
                          Container(
                            width: width * 0.625,
                            child: Divider(
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: height * 0.0416,
                          ),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: width * 0.1875,
                              ),
                              Container(
                                width: width * 0.3156,
                                height: height * 0.0462,
                                child: Text(
                                  '대전사무소 | (34816) 대전광역시 중구 목동로 42 302호(목동복합빌딩)\n경기사무소 | (18021) 경기 평택시 도시지원로 121 고덕지식공작소아이타워 501호',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.0093,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.54,
                                  ),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: height * 0.04351,
                          ),
                          Container(
                            height: height * 0.0680,
                            child: Row(
                              children: [
                                SizedBox(
                                  width: width * 0.1875,
                                ),
                                Transform.translate(
                                  offset: Offset(0, -height * 0.01388),
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.0041,
                                ),
                                Container(
                                  width: width * 0.0807,
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
                                SizedBox(
                                  width: width * 0.0083,
                                ),
                                Transform.translate(
                                  offset: Offset(0, -height * 0.0111),
                                  child: Icon(
                                    Icons.print,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.0041,
                                ),
                                Container(
                                  width: width * 0.08333,
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
                                SizedBox(
                                  width: width * 0.004,
                                ),
                                Transform.translate(
                                  offset: Offset(0, -height * 0.0111),
                                  child: Icon(
                                    Icons.local_post_office,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                SizedBox(
                                  width: width * 0.004,
                                ),
                                Container(
                                  width: width * 0.1458,
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
                                    )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: height * 0.04351,
                          ),
                          Row(
                            children: [
                              SizedBox(
                                width: width * 0.1979,
                              ),
                              Text(
                                'COPYRIGHT ⓒ NewChem (뉴켐) All rights reserved',
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.3),
                                  fontSize: width * 0.0093,
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

                  ],
                )),
          ),
        );
      }),
    );
  }

// Widget for brand buttons
  Widget buildBrandButton(
      String brandName, String imagePath, double width, double height) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        final width = size.width;
        final height = size.height;
        final isMobile = width < 600 && height < 800;
        final isTablet = width >= 600 && width < 1024 && height < 1200;
        final isDesktop = width >= 1024 && height >= 1200;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Image.asset(imagePath, width: width, height: height),
              if (!isMobile) // isMobile일 때 Text를 숨김
                Text(
                  brandName,
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w400,
                    fontSize: width * 0.0072, // isTablet이나 PC일 경우만 글씨 크기 설정
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
      final isMobile = width < 600 && height < 800;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;
      return Column(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: Colors.white, // 배경 색상
                  border: Border.all(
                    color: Colors.grey, // 테두리 색상
                    width: 1.0, // 테두리 두께
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  )),
              child: Transform.scale(
                scale: isMobile ? 0.8 : 0.98,
                child: Image.asset(imagePath, width: width, height: height),
              )),
          Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              width: width * 1.01,
              child: Center(
                child: Text(title,
                    style: TextStyle(
                        // fontSize: isMobile
                        //     ? 8
                        //     : isTablet
                        //         ? 20
                        //         : 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              )),
        ],
      );
    });
  }

  // 링크 셀 빌더
  Widget _buildLinkCell(
      String title, String url, double fontSize, double letterSpacing) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
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
              fontSize: fontSize,
              letterSpacing: letterSpacing),
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

        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          title: Row(
            children: [
              Text('${name}'),
              Spacer(),
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.close)),
            ],
          ),
          content: Container(
            height: height * 0.4629,
            child: Column(children: [
              Image.asset(
                image,
                fit: BoxFit.contain,
                width: width * 0.1562,
                height: height * 0.2777,
              ),
              Text('${content}'),
            ]),
          ),
        );
      },
    );
  }
}

// 전역에서 사용 가능한 `buildTextButton` 함수 정의
Container buildTextButton2(String label, int index, double buttonFontSize,
    Function(int) onItemTapped) {
  return Container(
    width: 115,
    height: 46,
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.zero, // 직사각형으로 설정
        ),
      ),
    ),
  );
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}
