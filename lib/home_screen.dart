import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'dart:html' as html; // Web용 dart:html 패키지 사용
import 'dart:ui_web' as ui;
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

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

  final List<Map<String, String>> slideImages = [
    {
      'image': 'assets/products/Hei-VAP_Series_bg.png',
      'name': 'Hei-VAP Series',
      'logo': 'assets/heidolph_logo.png',
      'route': '0',
      'koreaname': '제품의 부제 기재',
      'description': '간단한 1~2줄의 설명을 기재',
    },
    {
      'image': 'assets/products/Magnetic_stirrer_bg.png',
      'name': 'Magnetic Stirrer',
      'logo': 'assets/heidolph_logo.png',
      'route': '0',
      'koreaname': '제품의 부제 기재',
      'description': '간단한 1~2줄의 설명을 기재',
    },
    {
      'image': 'assets/products/Overhead_stirrer_bg.png',
      'name': 'Overhead Stirrer',
      'logo': 'assets/heidolph_logo.png',
      'route': '0',
      'koreaname': '제품의 부제 기재',
      'description': '간단한 1~2줄의 설명을 기재',
    },
    {
      'image': 'assets/products/Lab_Fast_Pro_bg.png',
      'name': 'Lab Fast Pro',
      'logo': 'assets/normag_logo.png',
      'route': '1',
      'koreaname': '제품의 부제 기재',
      'description': '간단한 1~2줄의 설명을 기재',
    },
    {
      'image': 'assets/products/Pilot_compact_reactor_bg.png',
      'name': 'Pilot Compact Reactor',
      'logo': 'assets/normag_logo.png',
      'route': '1',
      'koreaname': '제품의 부제 기재',
      'description': '간단한 1~2줄의 설명을 기재',
    },
    {
      'image': 'assets/products/Cinc_Industry_Product_bg.png',
      'name': 'Cinc Industry Product',
      'logo': 'assets/CINCIndustry.png',
      'route': '2',
      'koreaname': '제품의 부제 기재',
      'description': '간단한 1~2줄의 설명을 기재',
    },
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
            child: Container(
                height: height * 2.18, //뭔가 항목 늘릴때 사용해라.
                color: Colors.white70,
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: height * 0.65,
                      child: Column(
                        children: [
                          Expanded(
                            child: CarouselSlider(
                              carouselController: _controller,
                              items: slideImages
                                  .map((item) => Container(
                                        width: width * 0.9,
                                        height: height * 0.65,
                                        child: Container(
                                          child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(5.0)),
                                              child: Stack(
                                                children: <Widget>[
                                                  Column(
                                                    children: [
                                                      // Container(
                                                      //   child: Image.asset(
                                                      //     item['logo']!,
                                                      //     fit: BoxFit.fill,
                                                      //     height: 40,
                                                      //   ),
                                                      // ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          widget.onProductNavigate(
                                                              int.parse(item[
                                                                  'route']!));
                                                        },
                                                        child: Container(
                                                            width: width,
                                                            color: Colors.white,
                                                            child: Stack(
                                                              children: [
                                                                Image.asset(
                                                                    item[
                                                                        'image']!,
                                                                    fit: BoxFit
                                                                        .fill,
                                                                    width: double
                                                                        .infinity,
                                                                    height:
                                                                        height *
                                                                            0.50),
                                                                Container(
                                                                  width: width *
                                                                      0.46,
                                                                  height:
                                                                      height *
                                                                          0.555,
                                                                  child: Column(
                                                                    children: [
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.1388,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                width * 0.078,
                                                                          ),
                                                                          Container(
                                                                              width: width * 0.109,
                                                                              height: height * 0.062,
                                                                              decoration: BoxDecoration(
                                                                                border: Border.all(
                                                                                  color: Colors.black,
                                                                                  // 테두리 색상
                                                                                  width: 2, // 테두리 두께
                                                                                ),
                                                                              ),
                                                                              child: Image.asset(
                                                                                item['logo']!,
                                                                                fit: BoxFit.fill,
                                                                                height: height * 0.0277,
                                                                              ))
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.0277,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                width * 0.078,
                                                                          ),
                                                                          SelectableText(
                                                                              "${item['name']}",
                                                                              style: GoogleFonts.openSans(textStyle: TextStyle(fontSize: width * 0.018, fontWeight: FontWeight.bold))),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height: height *
                                                                            0.0277,
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            width:
                                                                                width * 0.078,
                                                                          ),
                                                                          SelectableText(
                                                                              "${item['description']}",
                                                                              style: GoogleFonts.nanumGothic(textStyle: TextStyle(fontSize: width * 0.010, color: Colors.grey, fontWeight: FontWeight.bold))),
                                                                        ],
                                                                      ),
                                                                    ],
                                                                  ),
                                                                )
                                                              ],
                                                            )),
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ))
                                  .toList(),
                              options: CarouselOptions(
                                  autoPlay: true,
                                  enlargeCenterPage: true,
                                  viewportFraction: 1,
                                  aspectRatio: 2,
                                  onPageChanged: (index, reason) {
                                    setState(() {
                                      _current = index;
                                    });
                                  }),
                            ),
                          ),
                          Container(
                            height: height * 0.030,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children:
                                  slideImages.asMap().entries.map((entry) {
                                return GestureDetector(
                                  onTap: () {
                                    _controller.animateToPage(entry.key);
                                  },
                                  child: Container(
                                    width: 12.0,
                                    height: 12.0,
                                    margin: EdgeInsets.symmetric(
                                        vertical: 8.0, horizontal: 4.0),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: (Theme.of(context).brightness ==
                                                    Brightness.dark
                                                ? Colors.white
                                                : Colors.blue)
                                            .withOpacity(_current == entry.key
                                                ? 0.9
                                                : 0.4)),
                                  ),
                                );
                              }).toList(),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(height: height * 0.01,color:Colors.grey),
                    Container(
                      width: width,
                      height: height * 0.3,
                      color: Colors.white,
                      child: Row(
                        children: [
                          SizedBox(width: width * 0.15),
                          Container(
                              child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.035,
                              ),
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Container(
                                width: width * 0.35,
                                child: SelectableText(
                                    '\t(주) 뉴켐은 실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.nanumGothic(
                                        textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * 0.010,
                                    ))),
                              ),
                              SizedBox(
                                height: height * 0.008,
                              ),
                              Container(
                                width: width * 0.35,
                                child: SelectableText(
                                    '합성 실험에 필요한 모든 솔루션을 제공하는 회사입니다.',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.nanumGothic(
                                        textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * 0.010,
                                    ))),
                              ),
                              SizedBox(
                                height: height * 0.008,
                              ),
                              Container(
                                width: width * 0.35,
                                child: SelectableText(
                                    '지난 20년간 화학 및 의약 연구 분야에서 수많은 제품과 시스템을 공급하며,',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.nanumGothic(
                                        textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * 0.010,
                                    ))),
                              ),
                              SizedBox(
                                height: height * 0.008,
                              ),
                              Container(
                                width: width * 0.35,
                                child: SelectableText(
                                    '고객이 신뢰할 수 있는 회사로 자리 매김해 왔습니다.',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.nanumGothic(
                                        textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * 0.010,
                                    ))),
                              ),
                              SizedBox(
                                height: height * 0.008,
                              ),
                              Container(
                                width: width * 0.35,
                                child: SelectableText('앞으로도 지속적인 성원 부탁드립니다.',
                                    textAlign: TextAlign.left,
                                    style: GoogleFonts.nanumGothic(
                                        textStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: width * 0.010,
                                    ))),
                              ),
                              SizedBox(
                                height: height * 0.008,
                              ),
                              Container(
                                width: width * 0.35,
                                child:
                                    SelectableText('저희 뉴켐은 언제나 고객과 함께 하겠습니다.',
                                        textAlign: TextAlign.left,
                                        style: GoogleFonts.nanumGothic(
                                            textStyle: TextStyle(
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                          fontSize: width * 0.010,
                                        ))),
                              ),
                            ],
                          )),
                          SizedBox(width: width * 0.18),
                          Container(
                            child: Text("Welcome!",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: width * 0.025,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blueAccent),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(height: height * 0.01,color:Colors.grey),
                    Container(
                        width: width,
                        height: height * 0.3,
                        color: Colors.white,
                        child: GestureDetector(
                          onTap: () {
                            widget.onNavigate(3);
                          },
                          child: Row(
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: height * 0.08,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.15,
                                      ),
                                      Container(
                                        child: Text("Contact Us",
                                            style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  fontSize: width * 0.025,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.redAccent),
                                            )),
                                      ),
                                      SizedBox(
                                        width: width * 0.20,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Text('전문가에게 맡겨주세요!',
                                              style: GoogleFonts.nanumGothic(
                                                  textStyle: TextStyle(
                                                      fontSize: width * 0.015,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          SizedBox(
                                            height: height * 0.04,
                                          ),
                                          Text('문의 및 상담 내용을 작성해서 접수하시면',
                                              style: GoogleFonts.nanumMyeongjo(
                                                  textStyle: TextStyle(
                                                      fontSize: width * 0.012,
                                                      color:
                                                          Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                          Text(
                                              '전문가들이 24시간 이내에 빠르고 성실하게 답변 드리겠습니다.',
                                              style: GoogleFonts.nanumMyeongjo(
                                                  textStyle: TextStyle(
                                                      fontSize: width * 0.012,
                                                      color:
                                                          Colors.black,
                                                      fontWeight:
                                                          FontWeight.bold))),
                                        ],
                                      )

                                      // IconButton(
                                      //     onPressed: () {
                                      //       widget.onNavigate(3); // ContactScreen으로 이동
                                      //     },
                                      //     icon: Icon(Icons.arrow_forward_ios_sharp),
                                      //     iconSize: isMobile ? 10 : 24,
                                      //     color: Colors.white),
                                    ],
                                  ),
                                  Divider(),
                                  SizedBox(
                                      height: isMobile
                                          ? height * 0.02
                                          : height * 0.02),
                                  // Text(
                                  //   isMobile ? "전문가에게 맡겨주세요!" : "전문가에게 맡겨주세요!",
                                  //   style: TextStyle(
                                  //     fontSize: isMobile
                                  //         ? width * 0.030
                                  //         : width * 0.012,
                                  //     color: Colors.blueAccent,
                                  //     fontWeight: FontWeight.w400,
                                  //   ),
                                  //   textAlign: TextAlign.center,
                                  // ),
                                  // SizedBox(
                                  //   height: isMobile ? 0 : 20,
                                  // ),
                                  // Text(
                                  //   isMobile
                                  //       ? "문의 및 상담 내용을 작성해서 접수하시면,\n전문가들이 24시간 이내에 빠르고 성실하게\n답변 드리겠습니다."
                                  //       : "문의 및 상담 내용을 작성해서 접수하시면, 전문가들이 24시간 이내에 빠르고 성실하게 답변 드리겠습니다.",
                                  //   style: TextStyle(
                                  //       fontSize: isMobile
                                  //           ? width * 0.0150
                                  //           : width * 0.006,
                                  //       color: Colors.white),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        )),
                    Container(height: height * 0.01,color:Colors.grey),
                    Container(
                      width: width,
                      height: height * 0.3,
                      color: Colors.white,
                      child: Row(
                        children: [
                          SizedBox(width: width * 0.15),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.035,
                              ),

                              // Table(
                              //   columnWidths: {
                              //     0: FixedColumnWidth(
                              //         MediaQuery.of(context).size.width *
                              //             0.5), // 화면 크기에 따라 셀 크기 조정
                              //   },
                              //   children: [
                              //     ...downloadData.map((item) {
                              //       return TableRow(
                              //         children: [
                              //           Padding(
                              //             padding: const EdgeInsets.all(8.0),
                              //             child: GestureDetector(
                              //               onTap: () async {
                              //                 final Uri uri =
                              //                     Uri.parse(item["link"]!);
                              //                 if (await canLaunchUrl(uri)) {
                              //                   await launchUrl(uri);
                              //                 } else {
                              //                   throw 'Could not launch ${item["link"]}';
                              //                 }
                              //               },
                              //               child: Text(
                              //                 item["title"]!,
                              //                 style: TextStyle(
                              //                   color: Colors.blue,
                              //                   decoration:
                              //                       TextDecoration.underline,
                              //                   // 파란색 언더라인
                              //                   decorationColor: Colors.blue,
                              //                   fontSize: isMobile ? 8 : 32,
                              //                 ),
                              //               ),
                              //             ),
                              //           ),
                              //         ],
                              //       );
                              //     }).toList(),
                              //   ],
                              // ),
                              Container(
                                color: Colors.transparent,
                                width: width * 0.42,
                                height: height * 0.20,
                                child: Row(
                                  children: [
                                    Container(
                                        width: width * 0.114,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black, width: 1)),
                                        child: Column(children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final Uri uri = Uri.parse(
                                                  'https://drive.google.com/file/d/1yhI9hVqEQVRXpuR2u0bmN-c0yvwTUNd9/view?usp=sharing');
                                              if (await canLaunchUrl(uri)) {
                                                await launchUrl(uri);
                                              } else {
                                                throw 'Could not launch url';
                                              }
                                            },
                                            child: Image.asset(
                                              'assets/download_image_01.png',
                                              width: width * 0.114,
                                              height: height * 0.18,
                                            ),
                                          ),
                                          Text(
                                            "[NORMAG]카달로그.pdf",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ])),
                                    Spacer(),
                                    Container(
                                        width: width * 0.114,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black, width: 1)),
                                        child: Column(children: [
                                          GestureDetector(
                                            onTap: () async {
                                              final Uri uri = Uri.parse(
                                                  'https://drive.google.com/file/d/1yhI9hVqEQVRXpuR2u0bmN-c0yvwTUNd9/view?usp=sharing');
                                              if (await canLaunchUrl(uri)) {
                                                await launchUrl(uri);
                                              } else {
                                                throw 'Could not launch url';
                                              }
                                            },
                                            child: Image.asset(
                                              'assets/download_image_02.png',
                                              width: width * 0.115,
                                              height: height * 0.18,
                                            ),
                                          ),
                                          Text(
                                            "[하이돌프] 종합 카달로그 _2024.pdf",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ])),
                                    Spacer(),
                                    Container(
                                        width: width * 0.114,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                color: Colors.black, width: 1)),
                                        child: Column(children: [
                                          // Image.asset(
                                          //     'assets/download_image_01.png',
                                          //   width:  width * 0.115,
                                          //   height: height* 0.18,),
                                          Container(
                                              width: width * 0.115,
                                              height: height * 0.18,
                                              color: Colors.grey),
                                          Text(
                                            "준비중",
                                            style: TextStyle(
                                                fontSize: 10,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ])),
                                  ],
                                ),
                              ),
                              Divider(),
                              SizedBox(
                                  height:
                                      isMobile ? height * 0.02 : height * 0.04),
                            ],
                          ),
                          SizedBox(width: width * 0.10),
                          Container(
                            child: Text("Downloads",
                                style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      fontSize: width * 0.025,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.greenAccent),
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(height: height * 0.01,color:Colors.grey),
                    Container(
                      width: width,
                      height: height * 0.3,
                      color: Colors.white,
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: height * 0.02,
                              ),
                              Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.15,
                                  ),
                                  Container(
                                    child: Text("Direction",
                                        style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              fontSize: width * 0.025,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black),
                                        )),
                                  ),
                                  SizedBox(
                                    width: width * 0.20,
                                  ),
                                  Container(
                                    width: width * 0.40,
                                    height: height * 0.18,
                                    child: _iframeWidget,
                                  ),
                                ],
                              ),
                              Divider(),
                              SizedBox(
                                  height:
                                      isMobile ? height * 0.02 : height * 0.02),

                              // Text(
                              //   isMobile ? "전문가에게 맡겨주세요!" : "전문가에게 맡겨주세요!",
                              //   style: TextStyle(
                              //     fontSize: isMobile
                              //         ? width * 0.030
                              //         : width * 0.012,
                              //     color: Colors.blueAccent,
                              //     fontWeight: FontWeight.w400,
                              //   ),
                              //   textAlign: TextAlign.center,
                              // ),
                              // SizedBox(
                              //   height: isMobile ? 0 : 20,
                              // ),
                              // Text(
                              //   isMobile
                              //       ? "문의 및 상담 내용을 작성해서 접수하시면,\n전문가들이 24시간 이내에 빠르고 성실하게\n답변 드리겠습니다."
                              //       : "문의 및 상담 내용을 작성해서 접수하시면, 전문가들이 24시간 이내에 빠르고 성실하게 답변 드리겠습니다.",
                              //   style: TextStyle(
                              //       fontSize: isMobile
                              //           ? width * 0.0150
                              //           : width * 0.006,
                              //       color: Colors.white),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                        height: isMobile ? height * 0.1500 : height * 0.25,
                        color: Colors.black,
                        padding: EdgeInsets.symmetric(
                            vertical: height * 0.0138,
                            horizontal: width * 0.007),
                        child: Center(
                          child: Column(
                            children: [
                              Divider(
                                  color: Colors.white,
                                  thickness: isMobile ? 0.5 : 1), // 구분선
                              SizedBox(height: height * 0.007),
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
                                      SizedBox(
                                        height: height * 0.02,
                                      ),
                                      Text(
                                        "(주) NewChem",
                                        style: TextStyle(
                                          fontSize: width * 0.013,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(height: height * 0.0007),
                                      Text(
                                        "▶  대전사무소 | (34816) 대전광역시 중구 목동로 42 302호(목동복합빌딩)\n"
                                        "▶  경기사무소 | (18021) 경기 평택시 도시지원로 121 고덕지식공작소아이타워 501호",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: width * 0.006),
                                      ),
                                      SizedBox(height: height * 0.007),
                                      Row(
                                        children: [
                                          Icon(Icons.phone,
                                              color: Colors.white,
                                              size: width * 0.0078),
                                          SizedBox(width: width * 0.004),
                                          Text(
                                            "070-8098-7424",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.005,
                                            ),
                                          ),
                                          SizedBox(width: width * 0.007),
                                          Icon(Icons.phone,
                                              color: Colors.white,
                                              size: width * 0.0078),
                                          SizedBox(width: width * 0.005),
                                          Text(
                                            "042-367-7427",
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.005,
                                            ),
                                          ),
                                          SizedBox(width: width * 0.007),
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
                                  /*        Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Image.asset(
                                        'assets/logo-white.png',
                                        width: isMobile
                                            ? width * 0.15
                                            : width * 0.10,
                                      ),
                                      SizedBox(height: isMobile ? 10 : 20),
                                    ],
                                  ),*/
                                  Container(
                                    width: width * 0.15,
                                    height: 200,
                                    child: Image.asset(
                                      'assets/logo-white.png',
                                      width: isMobile
                                          ? width * 0.15
                                          : width * 0.10,
                                    ),
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
                                  fontSize:
                                      isMobile ? width * 0.004 : width * 0.005,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        )),
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
