import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'dart:html' as html; // Web용 dart:html 패키지 사용
import 'dart:ui_web' as ui;
import 'dart:async';

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
  final List<String> _backgroundImages = [
    'assets/main-background2.png',
    'assets/main-background4.png',
    'assets/main-background6.png',
  ];
  String url =
      'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d669.6223690480622!2d127.01586977089258!3d37.02699966322705!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b3d001631c641%3A0x2cd353d15ed8488b!2z6rOg642V7KeA7Iud6rO17J6R7IaM7JWE7J207YOA7JuMIOyngOyLneyCsOyXheyEvO2EsA!5e0!3m2!1sko!2skr!4v1717727526433!5m2!1sko!2skr" width="400" height="350" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade';

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

  final List<String> slideImages = [
    'assets/sample1.png',
    'assets/sample2.png',
    'assets/sample3.png',
    'assets/sample4.png',
  ];

  final List<Map<String, String>> downloadData = [
    {
      "number": "3",
      "title": "준비중",
      "link":
          "https://drive.google.com/file/d/1yhI9hVqEQVRXpuR2u0bmN-c0yvwTUNd9/view?usp=sharing",
      "author": "관리자",
      "date": "2024-00-00"
    },
    {
      "number": "2",
      "title": "[NORMAG]카달로그.pdf",
      "link":
          "https://drive.google.com/file/d/1yhI9hVqEQVRXpuR2u0bmN-c0yvwTUNd9/view?usp=sharing",
      "author": "관리자",
      "date": "2024-10-16"
    },
    {
      "number": "1",
      "title": "[하이돌프] 종합 카달로그 _2024.pdf",
      "link":
          "https://drive.google.com/file/d/1Ols-r9GJcyZiHQMKNkxA7Ysaj51_fQa7/view?usp=sharing",
      "author": "관리자",
      "date": "2024-10-16"
    },
  ];
  String? _selectedName;
  String? _selectedImage;
  String? _selectedContent;

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
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isM = width < 600;
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

    return MaterialApp(
      home: LayoutBuilder(builder: (context, constraints) {
        // width와 height 모두를 고려한 반응형 조건 설정
        final isMobile = width < 600 && height < 800;
        final isTablet = width >= 600 && width < 1024 && height < 1200;
        final isDesktop = width >= 1024 && height >= 1200;

        return Scaffold(
          backgroundColor: Colors.white,
          body: SingleChildScrollView(
            child: Column(
              // Column 전체를 SingleChildScrollView로 감싸서 스크롤 가능하게 만듦
              children: [
                // Main section
                Container(
                    width: width,
                    height: isMobile ? height * 0.2000 : height * 0.3369,
                    child: Stack(
                      children: [
                        AnimatedSwitcher(
                          duration: Duration(seconds: 8),
                          child: Image.asset(
                            _backgroundImages[_currentImageIndex],
                            key: ValueKey<String>(
                                _backgroundImages[_currentImageIndex]),
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Spacer(),
                            // Image.asset(
                            //   'assets/logo-white.png',
                            //   width: isMobile ? width * 0.3000 : width * 0.1564,
                            //   height:
                            //       isMobile ? height * 0.1500 : height * 0.1000,
                            // ),
                            Text(
                              "Welcome To New-Chem Home Page.",
                              style: TextStyle(color: Colors.white, fontSize : isMobile?18:48,fontFamily: 'Pretendard',fontStyle: FontStyle.italic),
                            ),
                            Spacer(),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    widget.onProductNavigate(
                                        0); // Heidolph 탭으로 이동
                                  },
                                  child: buildBrandButton(
                                    "Heidolph",
                                    "assets/heidolph_logo.png",
                                    isMobile ? width * 0.1200 : width * 0.1200,
                                    isMobile
                                        ? height * 0.0400
                                        : height * 0.0400,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget
                                        .onProductNavigate(1); // NORMAG 탭으로 이동
                                  },
                                  child: buildBrandButton(
                                    "NORMAG",
                                    "assets/normag_logo.png",
                                    width * 0.1200,
                                    height * 0.0400,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    widget.onProductNavigate(
                                        2); // CINC Industry 탭으로 이동
                                  },
                                  child: buildBrandButton(
                                    "CINC Industry",
                                    "assets/CINCIndustry.png",
                                    width * 0.1200,
                                    height * 0.0400,
                                  ),
                                ),
                              ],
                            ),
                            Spacer(),
                          ],
                        ),
                      ],
                    )),
                // Product section
                Container(
                  padding: const EdgeInsets.all(8.0),
                  color: Color(0xfff3f3f3),
                  child: Column(
                    children: [
                      SizedBox(height: isMobile ? height * 0.0200 : 30),
                      Text("PRODUCT",
                          style: TextStyle(
                              fontSize: isMobile ? 8 : 15,
                              color: Colors.red,
                              fontWeight: FontWeight.bold)),
                      SizedBox(
                        height: isMobile ? 7 : 12,
                      ),
                      Text("대표 제품",
                          style: TextStyle(
                              fontSize: isMobile ? 16 : 35,
                              color: Colors.black)),
                      SizedBox(height: isMobile ? 8 : height * 0.0347),
                      Container(
                        width: isMobile ? width * 0.9 : width * 0.6,
                        height: isMobile ? 1000 : 1296,
                        child: GridView.builder(
                          shrinkWrap: true,
                          // GridView가 스크롤되도록 설정
                          physics: NeverScrollableScrollPhysics(),
                          // GridView 자체는 스크롤되지 않게 함
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: width > 572 ? 3 : 2,
                            // 화면 크기에 따라 2개 또는 3개로 설정
                            crossAxisSpacing: isMobile ? 36 : 4,
                            // 좌우 간격을 줄임
                            mainAxisSpacing: isMobile ? 100 : 0,
                            // 상하 간격을 줄임
                            childAspectRatio: 1.2, // 가로세로 비율을 줄여서 세로로 더 길어지게 설정
                          ),
                          itemCount: productData.length,
                          // 데이터 길이에 따라 자동 생성
                          itemBuilder: (context, index) {
                            return buildProductCard(
                                productData[index]['title']!,
                                productData[index]['image']!,
                                productData[index]['content']!,
                                context,
                                isMobile ? width * 0.7000 : width * 0.1200,
                                isMobile ? height * 0.1500 : height * 0.2000);
                          },
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        height: height * 0.2777,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/main-background3.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Row(
                          children: [
                            // 왼쪽 텍스트
                            Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Spacer(),
                                Transform.translate(
                                  offset: Offset(-15, 0),
                                  child: Image.asset('assets/logo-white.png',
                                      width: isMobile ? 120 : 200),
                                ),
                                SizedBox(height: isMobile ? 2 : 10),
                                Text(
                                  "안녕하세요, (주)뉴켐을 소개합니다.",
                                  style: TextStyle(
                                    fontSize: isMobile ? 10 : 24,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: height * 0.0138),
                                Container(
                                  width: isMobile
                                      ? width * 0.3200
                                      : width * 0.1564,
                                  child: Text(
                                    "뉴켐은 실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지, "
                                    "합성 실험에 필요한 모든 솔루션을 제공하는 회사입니다.\n\n"
                                    "지난 20년간 화학 및 의약 연구 분야에서 수많은 제품과 시스템을 공급하며 "
                                    "고객이 신뢰할 수 있는 회사로 자리매김해 왔습니다. 앞으로도 지속적인 성원 부탁드립니다. "
                                    "저희 뉴켐은 언제나 고객과 함께 하겠습니다.",
                                    style: TextStyle(
                                      fontSize: isMobile ? 8 : 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                Spacer(),
                              ],
                            ),
                            Spacer(),
                            Container(
                              width: isMobile ? width * 0.4 : width * 0.2,
                              height: isMobile ? width * 0.28 : height * 0.3,
                              color: Colors.white.withOpacity(0.2),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: CarouselSlider.builder(
                                    itemCount:
                                        slideImages.length, // 슬라이드 이미지 개수
                                    itemBuilder: (context, index, realIndex) {
                                      return Container(
                                        child: Image.asset(
                                          slideImages[index], // 각 슬라이드 이미지
                                          fit: BoxFit.fill,
                                        ),
                                      );
                                    },
                                    options: CarouselOptions(
                                      autoPlay: true, // 자동 슬라이드
                                      enlargeCenterPage: true, // 중앙 슬라이드 확대
                                      aspectRatio: 2.0, // 슬라이드 비율 조정
                                      viewportFraction: 1.0, // 슬라이드 크기 조정
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                      Container(
                        color: Colors.white,
                        padding: EdgeInsets.only(top: 20),
                        height: height * 0.2900,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                width: isMobile ? width * 0.30 : width * 0.15,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          isMobile ? "\tDownload" : "Download",
                                          style: TextStyle(
                                              fontSize: isMobile
                                                  ? width * 0.02
                                                  : width * 0.01,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              widget.onNavigate(4);
                                            },
                                            icon: Icon(
                                                Icons.arrow_forward_ios_sharp),
                                            iconSize: isMobile ? 10 : 24),
                                      ],
                                    ),
                                    SizedBox(height: height * 0.01),
                                    Table(
                                      columnWidths: {
                                        0: FixedColumnWidth(
                                            MediaQuery.of(context).size.width *
                                                0.5), // 화면 크기에 따라 셀 크기 조정
                                      },
                                      children: [
                                        ...downloadData.map((item) {
                                          return TableRow(
                                            children: [
                                              _buildLinkCell(
                                                  item["title"]!,
                                                  item["link"]!,
                                                  isMobile ? 7 : 16,
                                                  isMobile ? -0.95 : 0),
                                            ],
                                          );
                                        }).toList(),
                                      ],
                                    ),
                                  ],
                                ),
                              ),

                              // 두 번째 위젯 - Contact Us 정보
                              Container(
                                width: isMobile ? width * 0.30 : width * 0.30,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          isMobile
                                              ? "\tContact Us"
                                              : "Contact Us",
                                          style: TextStyle(
                                              fontSize: isMobile
                                                  ? width * 0.02
                                                  : width * 0.01,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              widget.onNavigate(
                                                  3); // ContactScreen으로 이동
                                            },
                                            icon: Icon(
                                                Icons.arrow_forward_ios_sharp),
                                            iconSize: isMobile ? 10 : 24),
                                      ],
                                    ),
                                    SizedBox(
                                        height: isMobile
                                            ? height * 0.02
                                            : height * 0.02),
                                    Text(
                                      isMobile?"전문가에게 맡겨주세요!":"\t\t전문가에게 맡겨주세요!",
                                      style: TextStyle(
                                        fontSize: isMobile
                                            ? width * 0.030
                                            : width * 0.015,
                                        color: Colors.blueAccent,
                                        fontWeight: FontWeight.w400,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                    SizedBox(
                                      height: isMobile ? 0 : 40,
                                    ),
                                    Text(
                                      isMobile
                                          ? "문의 및 상담 내용을 작성해서 접수하시면,\n전문가들이 24시간 이내에 빠르고 성실하게\n답변 드리겠습니다."
                                          : "문의 및 상담 내용을 작성해서 접수하시면, 전문가들이 24시간 이내에 빠르고 성실하게 답변 드리겠습니다.",
                                      style: TextStyle(
                                          fontSize: isMobile
                                              ? width * 0.0150
                                              : width * 0.006),
                                    ),
                                  ],
                                ),
                              ),

                              // 세 번째 위젯 - 오시는 길 (지도 이미지)
                              Container(
                                width: width * 0.30,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          isMobile ? "\t오시는 길" : "오시는 길",
                                          style: TextStyle(
                                              fontSize: isMobile
                                                  ? width * 0.02
                                                  : width * 0.01,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        IconButton(
                                            onPressed: () {
                                              widget.onCompanyNavigate(
                                                  2); // "오시는 길" 탭으로 이동 (인덱스 2)
                                            },
                                            icon: Icon(
                                                Icons.arrow_forward_ios_sharp),
                                            iconSize: isMobile ? 10 : 24),
                                      ],
                                    ),
                                    SizedBox(
                                        height: isMobile ? 0 : height * 0.01),
                                    Container(
                                      width: width * 0.40,
                                      height: height * 0.15,
                                      child: _iframeWidget,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                          height: isMobile ? height * 0.1500 : height * 0.2000,
                          color: Colors.black,
                          padding: EdgeInsets.symmetric(
                              vertical: isMobile ? 0 : 20, horizontal: 20),
                          child: Center(
                            child: Column(
                              children: [
                                Divider(
                                    color: Colors.white,
                                    thickness: isMobile ? 0.5 : 1), // 구분선
                                SizedBox(height: isMobile ? 0 : 10),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "(주) NewChem",
                                          style: TextStyle(
                                            fontSize: isMobile
                                                ? width * 0.02
                                                : width * 0.01,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        SizedBox(height: isMobile ? 10 : 10),
                                        Text(
                                          "▶  대전사무소 | (34816) 대전광역시 중구 목동로 42 302호(목동복합빌딩)\n"
                                          "▶  경기사무소 | (18021) 경기 평택시 도시지원로 121 고덕지식공작소아이타워 501호",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: isMobile
                                                ? width * 0.007
                                                : width * 0.005,
                                          ),
                                        ),
                                        SizedBox(height: 10),
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                              size: isMobile ? 9 : 20,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "070-8098-7424",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: isMobile
                                                    ? width * 0.007
                                                    : width * 0.005,
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Icon(
                                              Icons.phone,
                                              color: Colors.white,
                                              size: isMobile ? 9 : 20,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "042-367-7427",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: isMobile
                                                    ? width * 0.007
                                                    : width * 0.005,
                                              ),
                                            ),
                                            SizedBox(width: 20),
                                            Icon(
                                              Icons.email,
                                              color: Colors.white,
                                              size: isMobile ? 9 : 20,
                                            ),
                                            SizedBox(width: 10),
                                            Text(
                                              "cmkim@new-chem.co.kr",
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: isMobile
                                                    ? width * 0.007
                                                    : width * 0.005,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          'assets/logo-white.png',
                                          width: isMobile
                                              ? width * 0.15
                                              : width * 0.10,
                                        ),
                                        SizedBox(height: isMobile ? 10 : 20),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.transparent,
                                            side:
                                                BorderSide(color: Colors.white),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            padding: EdgeInsets.symmetric(
                                              vertical: isMobile ? 6 : 15,
                                              horizontal: isMobile ? 20 : 40,
                                            ),
                                          ),
                                          onPressed: () {
                                            // ContactScreen으로 이동
                                            widget.onNavigate(
                                                3); // ContactScreen으로 이동
                                          },
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                "Contact Us",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.010,
                                                ),
                                              ),
                                              SizedBox(width: 10),
                                              Icon(
                                                Icons.arrow_forward,
                                                color: Colors.white,
                                                size: width * 0.005,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Spacer(),
                                  ],
                                ),
                                SizedBox(height: isMobile ? 0 : 5),
                                Divider(
                                    color: Colors.white,
                                    thickness: isMobile ? 0.5 : 1), // 구분선
                                SizedBox(height: isMobile ? 0 : 5),
                                Text(
                                  "COPYRIGHT © NewChem (뉴켐) All rights reserved | Designed by Aichemist",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: isMobile
                                        ? width * 0.004
                                        : width * 0.005,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ],
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
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
                    fontSize: 14, // isTablet이나 PC일 경우만 글씨 크기 설정
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
            height: 500,
            child: Column(children: [
              Image.asset(
                image,
                fit: BoxFit.contain,
                width: 300,
                height: 300,
              ),
              Text('${content}'),
            ]),
          ),
        );
      },
    );
  }
}

class MyWidgetFactory extends WidgetFactory with WebViewFactory {}
