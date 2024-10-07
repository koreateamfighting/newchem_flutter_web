import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:fwfh_webview/fwfh_webview.dart';
import 'dart:html' as html; // Web용 dart:html 패키지 사용
import 'dart:ui' as ui;
// Home 페이지 (기존의 Main 페이지)
class HomePage extends StatelessWidget {
  final Function(int) onNavigate;
  String url = 'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d669.6223690480622!2d127.01586977089258!3d37.02699966322705!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b3d001631c641%3A0x2cd353d15ed8488b!2z6rOg642V7KeA7Iud6rO17J6R7IaM7JWE7J207YOA7JuMIOyngOyLneyCsOyXheyEvO2EsA!5e0!3m2!1sko!2skr!4v1717727526433!5m2!1sko!2skr" width="400" height="350" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade';
  final Widget _iframeWidget = HtmlElementView(
    viewType: 'iframeElement',
    key: UniqueKey(),
  );

  HomePage({required this.onNavigate});

  final List<Map<String, String>> productData = [
    {
      "title": "Hei-VAP Series (탁상형 농축기)",
      "image": "assets/products/Hei-VAP_Series.png",
      "content": "제품에 대한 설명"
    },
    {
      "title": "Magnetic Stirrer (자력 교반기)",
      "image": "assets/products/Magnetic_stirrer.png",
      "content": "제품에 대한 설명"
    },
    {"title": "오버헤드 교반기", "image": "assets/products/Overhead_stirrer.png",
      "content": "제품에 대한 설명"},
    {"title": "Lab Fast Pro", "image": "assets/products/Lab_Fast_Pro.png",
      "content": "제품에 대한 설명"},
    {
      "title": "Pilot Compact Reactor (10 ~ 30L)",
      "image": "assets/products/Pilot_compact_reactor.png",
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
      "title": "[첨부] 다운로드 자료 타이틀 예 3 (구글드라이브 경로)",
      "link":
          "https://drive.google.com/file/d/16UjB2PEM6H520jdrzn614uAXFO0WAMsx/view?usp=sharing",
      "author": "관리자",
      "date": "2024-00-00"
    },
    {
      "number": "2",
      "title": "[첨부] 다운로드 자료 타이틀 예 2 (구글드라이브 경로)",
      "link":
          "https://drive.google.com/file/d/16UjB2PEM6H520jdrzn614uAXFO0WAMsx/view?usp=sharing",
      "author": "관리자",
      "date": "2024-00-00"
    },
    {
      "number": "1",
      "title": "[첨부] 다운로드 자료 타이틀 예 1 (구글드라이브 경로)",
      "link":
          "https://drive.google.com/file/d/16UjB2PEM6H520jdrzn614uAXFO0WAMsx/view?usp=sharing",
      "author": "관리자",
      "date": "2024-00-00"
    },
  ];
  String? _selectedName;
  String? _selectedImage;
  String? _selectedContent;
  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final html.IFrameElement _iFrameElement = html.IFrameElement(
    );

    _iFrameElement.style.height = '120%';
    _iFrameElement.style.width = '80%';
    _iFrameElement.src = '${url}';
    _iFrameElement.style.border = 'none';

// ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
          (int viewId) => _iFrameElement,
    );

    return SingleChildScrollView(
      child: Column(
        // Column 전체를 SingleChildScrollView로 감싸서 스크롤 가능하게 만듦
        children: [
          // Main section
          Container(
            width: width,
            height: height * 0.3369,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/main-background2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(),
                Image.asset('assets/logo-white.png', width: width * 0.1564),

   Spacer(),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildBrandButton("Heidolph", "assets/heidolph_logo.png",
                        width * 0.0978, height * 0.0277),
                    buildBrandButton("NORMAG", "assets/normag_logo.png",
                        width * 0.0978, height * 0.0277),
                    buildBrandButton("CINC_Industry", "assets/CINCIndustry.png",
                        width * 0.0978, height * 0.0277),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
          // Product section
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text("PRODUCT",
                    style: TextStyle(
                        fontSize: 15,
                        color: Colors.red,
                        fontWeight: FontWeight.bold)),
                Text("대표 제품", style: TextStyle(fontSize: 35)),
                SizedBox(height: height * 0.0347),
                Container(
                  width: width * 0.6,
                  child: Center(
                    child: GridView.builder(
                      shrinkWrap: true,
                      // GridView가 스크롤되도록 설정
                      physics: NeverScrollableScrollPhysics(),
                      // GridView 자체는 스크롤되지 않게 함
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: width > width * 0.2347
                            ? 3
                            : 2, // 화면 크기에 따라 2개 또는 3개로 설정
                        crossAxisSpacing: 4, // 좌우 간격을 줄임
                        mainAxisSpacing: 0, // 상하 간격을 줄임
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
                            width * 0.0586,
                            height * 0.1041);
                      },
                    ),
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
                                width: 200),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "안녕하세요, (주)뉴켐을 소개합니다.",
                            style: TextStyle(
                              fontSize: 24,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: height * 0.0138),
                          Container(
                            width: width * 0.1564,
                            child: Text(
                              "뉴켐은 실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지, "
                              "합성 실험에 필요한 모든 솔루션을 제공하는 회사입니다.\n\n"
                              "지난 20년간 화학 및 의약 연구 분야에서 수많은 제품과 시스템을 공급하며 "
                              "고객이 신뢰할 수 있는 회사로 자리매김해 왔습니다. 앞으로도 지속적인 성원 부탁드립니다. "
                              "저희 뉴켐은 언제나 고객과 함께 하겠습니다.",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          Spacer(),
                        ],
                      ),
                      Spacer(),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.20,
                        height: MediaQuery.of(context).size.height * 0.30,
                        color: Colors.white.withOpacity(0.2),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: CarouselSlider.builder(
                              itemCount: slideImages.length, // 슬라이드 이미지 개수
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
                  padding: EdgeInsets.only(top:20),
                  height: height * 0.2900,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Container(
                          width: width * 0.15,

                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Download",
                                    style: TextStyle(
                                        fontSize: width * 0.01,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Spacer(),
                                  IconButton(
                                      onPressed: () {
                                        onNavigate(4);
                                      },
                                      icon:
                                          Icon(Icons.arrow_forward_ios_sharp)),
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
                                            item["title"]!, item["link"]!),
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

                          height: width * 0.15,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Contact Us",
                                    style: TextStyle(
                                        fontSize: width * 0.01,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: width* 0.08),
                                  IconButton(
                                      onPressed: () {
                                        onNavigate(3); // ContactScreen으로 이동
                                      },
                                      icon:
                                      Icon(Icons.arrow_forward_ios_sharp)),
                                ],
                              ),
                              SizedBox(height: height * 0.02),

                               Text(
                                  "전문가에게 맡겨주세요!",
                                  style: TextStyle(
                                      fontSize: width * 0.008,
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w400,),
                                 textAlign: TextAlign.center,

                                ),


                                Text(
                                  "문의 및 상담 내용을 작성해서 접수하시면,\n전문가들이 24시간 이내에 빠르고 성실하게\n답변 드리겠습니다.",
                                  style: TextStyle(fontSize: width * 0.006),
                                ),




                            ],
                          ),
                        ),

                        // 세 번째 위젯 - 오시는 길 (지도 이미지)
                        Container(

                          width: width * 0.300,
                          height: height * 0.35,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                            [
                                Row(
                                  children: [
                                    Text(
                                      "오시는 길",
                                      style: TextStyle(
                                          fontSize: width * 0.01,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: width* 0.19),
                                    IconButton(
                                        onPressed: () {
                                          onNavigate(1); // ContactScreen으로 이동
                                        },
                                        icon:
                                        Icon(Icons.arrow_forward_ios_sharp)),
                                  ],
                                ),


                              SizedBox(height: height * 0.01),
                              // 지도 예시 이미지
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
                    height: height * 0.2000,
                    color: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    child: Center(
                      child: Column(
                        children: [
                          Divider(color: Colors.white, thickness: 1), // 구분선
                          SizedBox(height: 10),
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "(주) NewChem",
                                    style: TextStyle(
                                      fontSize: width * 0.01,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    "대전사무소 | (34816) 대전광역시 중구 목동로 42 302호(목동복합빌딩)\n"
                                    "경기사무소 | (18021) 경기 평택시 도시지원로 121 고덕지식공작소아이타워 501호",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: width * 0.005,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Row(
                                    children: [
                                      Icon(Icons.phone, color: Colors.white),
                                      SizedBox(width: 10),
                                      Text(
                                        "070-8098-7424",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.005,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Icon(Icons.phone, color: Colors.white),
                                      SizedBox(width: 10),
                                      Text(
                                        "042-367-7427",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.005,
                                        ),
                                      ),
                                      SizedBox(width: 20),
                                      Icon(Icons.email, color: Colors.white),
                                      SizedBox(width: 10),
                                      Text(
                                        "cmkim@new-chem.co.kr",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: width * 0.005,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/logo-white.png',
                                    width: width * 0.10,
                                  ),
                                  SizedBox(height: 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      side: BorderSide(color: Colors.white),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 15,
                                        horizontal: 30,
                                      ),
                                    ),
                                    onPressed: () {
                                      // ContactScreen으로 이동
                                      onNavigate(3); // ContactScreen으로 이동
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
                          SizedBox(height: 5),
                          Divider(color: Colors.white, thickness: 1), // 구분선
                          SizedBox(height: 5),
                          Text(
                            "COPYRIGHT © NewChem (뉴켐) All rights reserved | Designed by Aichemist",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: width * 0.005,
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
    );
  }

  // Widget for brand buttons
  Widget buildBrandButton(
      String brandName, String imagePath, double width, double height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Image.asset(imagePath, width: width, height: height),
          Text(brandName,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Widget for product card
  Widget buildProductCard(
      String title, String imagePath, String content, BuildContext context,double width, double height) {
    return Column(
      children: [
        Image.asset(imagePath, width: width, height: height),
        Text(title,
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.blue)),
        Text("제품에 대한 설명을 여기에 넣을 수 있습니다.", textAlign: TextAlign.center),
      ],
    );
  }

  // 링크 셀 빌더
  Widget _buildLinkCell(String title, String url) {
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
              color: Colors.blue, decoration: TextDecoration.underline),
        ),
      ),
    );
  }
// Product Card Widget
  Widget _buildProductCard(String name, String imagePath, String content, BuildContext context) {
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




  Future<void> _dialogBuilder(BuildContext context, String name , String image , String content) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.zero
          ),
          title: Row(
            children: [
              Text('${name}'),
              Spacer(),
              IconButton(onPressed: (){
                Navigator.of(context).pop();
              }, icon: Icon(Icons.close)),
            ],
          ),
          content:  Container(
            height: 500,
            child: Column(
                children: [
                  Image.asset(
                    image,
                    fit: BoxFit.contain,
                    width: 300,
                    height: 300,
                  ),
                  Text(
                      '${content}'
                  ),
                ]

            ),
          ),


        );
      },
    );
  }
}
class MyWidgetFactory extends WidgetFactory with WebViewFactory {}