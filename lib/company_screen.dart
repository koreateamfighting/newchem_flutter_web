import 'package:flutter/material.dart';
import 'dart:html' as html; // Web용 dart:html 패키지 사용
import 'dart:ui' as ui;

class CompanyPage extends StatefulWidget {
  final int selectedTabIndex; // 선택된 탭 인덱스를 전달받기 위한 변수
  final Function(int) onTabChanged; // 탭이 변경될 때 호출되는 콜백 함수

  CompanyPage({this.selectedTabIndex = 0, required this.onTabChanged});

  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  int _selectedTabIndex = 0;
  String url =
      'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d669.6223690480622!2d127.01586977089258!3d37.02699966322705!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b3d001631c641%3A0x2cd353d15ed8488b!2z6rOg642V7KeA7Iud6rO17J6R7IaM7JWE7J207YOA7JuMIOyngOyLneyCsOyXheyEvO2EsA!5e0!3m2!1sko!2skr!4v1717727526433!5m2!1sko!2skr" width="400" height="350" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade';
  final Widget _iframeWidget = HtmlElementView(
    viewType: 'iframeElement',
    key: UniqueKey(),
  );

  void initState() {
    super.initState();
    _selectedTabIndex = widget.selectedTabIndex;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery
        .of(context)
        .size;
    final width = size.width;
    final height = size.height;
    final isM = width < 600;
    final html.IFrameElement _iFrameElement = html.IFrameElement();

    _iFrameElement.style.height = '120%';
    _iFrameElement.style.width = isM? '100':'60%';
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
              children: [
                Container(
                  width: width,
                  height: isMobile
                ? height * 0.2000

                    : height * 0.3369,
                  // 높이를 반응형으로 조정
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/main-background7.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      Text(
                        "Company",
                        style: TextStyle(color: Colors.white, fontSize: isMobile? 30:60),
                      ),
                      Spacer(),
                    ],
                  ),
                ),

                Container(

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Spacer(),
                      _buildTabButton("기업 소개", 0),
                      _buildTabButton("기업 연혁", 1),
                      _buildTabButton("오시는 길", 2),
                      Spacer(),
                    ],
                  ),
                ),
                Divider(),

               _buildTabContent(),

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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
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
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    'assets/logo-white.png',
                                    width:
                                    isMobile ? width * 0.15 : width * 0.10,
                                  ),
                                  SizedBox(height: isMobile ? 10 : 20),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      side: BorderSide(color: Colors.white),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: isMobile ? 6 : 15,
                                        horizontal: isMobile ? 20 : 40,
                                      ),
                                    ),
                                    onPressed: () {
                                      // ContactScreen으로 이동
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
                              fontSize:
                              isMobile ? width * 0.004 : width * 0.005,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ))
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildTabButton(String title, int index) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      // width와 height 모두를 고려한 반응형 조건 설정
      final isMobile = width < 600 && height < 800;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;
      return Container(
        // color:  Color(0xffd4e2f5).withOpacity(0.9),// TabBar 배경색 설정
        color:Colors.indigoAccent.shade100,
        width: isMobile? width * 0.20:width * 0.08,
        height: 50,
        padding: EdgeInsets.zero,
        child: TextButton(
          onPressed: () {
            setState(() {
              _selectedTabIndex = index;
              widget.onTabChanged(index); // 탭 변경 시 부모에 알림
            });
          },
          child: Text(
            title,
            style: TextStyle(
                fontSize: 18,
                fontWeight: _selectedTabIndex == index
                    ? FontWeight.bold
                    : FontWeight.bold,
                color:
                _selectedTabIndex == index ? Colors.black : Colors.white,
                decoration: _selectedTabIndex == index
                    ? TextDecoration.underline
                    : TextDecoration.none,
                // 언더라인 추가
                decorationColor: Colors.black),
          ),
        ),
      );
    }
    );
  }

  Widget _buildTabContent() {
    switch (_selectedTabIndex) {
      case 0:
        return _buildIntroTab();
      case 1:
        return _buildHistoryTab();
      case 2:
        return _buildLocationTab();
      default:
        return Container();
    }
  }

  Widget _buildIntroTab() {
    return LayoutBuilder(builder: (context, constraints) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      // width와 height 모두를 고려한 반응형 조건 설정
      final isMobile = width < 600 && height < 800;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;
      return Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
            child: Container(
              width:isMobile? width*0.90:width * 0.4,
              height: height * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                  Text(
                    "뉴켐 홈페이지에 오신 것을 환영합니다.",
                    style: TextStyle(fontSize: isMobile?24:40, fontWeight: FontWeight.bold),
                  ),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(height: 40),
                  Text(
                    "뉴켐은 실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지,\n"
                        "합성 실험에 필요한 모든 솔루션을 제공하는 회사입니다. "
                        "\n\n지난 20년간 화학 및 의약 연구 분야에서 수많은 제품과 시스템을 공급하며,"
                        "\n고객이 신뢰할 수 있는 회사로 자리매김해 왔습니다."
                        "\n\n앞으로도 지속적인 성원 부탁드립니다.\n저희 뉴켐은 언제나 고객과 함께 하겠습니다.",
                    style: TextStyle(fontSize: isMobile? 15:20,letterSpacing: isMobile? -0.9:0),
                  ),
                  SizedBox(height: 50),
                  Text(
                    "(주) 뉴켐 대표\n김 천 만",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic),
                    textAlign: TextAlign.end,
                  ),
                ],
              ),
            )),
      );
    }
    );
  }

  Widget _buildHistoryTab() {
    return
      LayoutBuilder(builder: (context, constraints) {
        final size = MediaQuery.of(context).size;
        final width = size.width;
        final height = size.height;
        // width와 height 모두를 고려한 반응형 조건 설정
        final isMobile = width < 600 && height < 800;
        final isTablet = width >= 600 && width < 1024 && height < 1200;
        final isDesktop = width >= 1024 && height >= 1200;

        return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width:isMobile? width*0.90:width * 0.4,
              height: height * 0.6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40,),
                  Text("기업 연혁",
                    style: TextStyle(fontSize: isMobile?24:40, fontWeight: FontWeight.bold),),
                  Divider(
                    color: Colors.grey,
                  ),
                  SizedBox(height: 40),
                  _buildHistoryItem("● 2024년 4월", "설립"),
                  _buildHistoryItem("● 2024년 5월", "Heidolph Korea 대전지역 독점대리점 계약"),
                  _buildHistoryItem("● 2024년 6월", "독일 NORMAG 파트너쉽 체결"),
                  _buildHistoryItem("● 2024년 8월", "미국 CINC사 파트너쉽 체결"),
                  SizedBox(
                    height: isMobile? height * 0.17:height * 0.3,
                  ),
                ],
              ),
            ));
      }
      );
  }

  Widget _buildHistoryItem(String date, String event) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      // width와 height 모두를 고려한 반응형 조건 설정
      final isMobile = width < 600 && height < 800;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              date,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            SizedBox(width: 10),
            Expanded(child: Text(event, style: TextStyle(fontSize: 20))),
          ],
        ),
      );
    }
    );
  }

  Widget _buildLocationTab() {
    return LayoutBuilder(builder: (context, constraints) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      // width와 height 모두를 고려한 반응형 조건 설정
      final isMobile = width < 600 && height < 800;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;
      return
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
              child: Container(
                width:isMobile? width*0.90:width * 0.4,
                height: height * 0.6,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 40,),
                    Text(
                      "오시는 길",
                      style: TextStyle(fontSize: isMobile?24:40, fontWeight: FontWeight.bold),),
                    Divider(
                      color: Colors.grey,
                    ),
                    SizedBox(height: 40),
                    Text(
                      isMobile? "● 주소 : 경기사무소 (18021) 경기 평택시 도시지원로 121\n \t\t\t\t\t\t\t\t\t\t\t\t\t\t고덕지식공작소아이타워 510호":"● 주소 : 경기사무소 (18021) 경기 평택시 도시지원로 121 고덕지식공작소아이타워 510호",
                      style: TextStyle(
                          fontSize: isMobile? 14:20, fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: 50),
                    Container(
                      width: isMobile? width :width * 0.8,
                      height: height * 0.3,
                      child: _iframeWidget,
                    )
                  ],
                ),
              )),
        );
    }
    );
  }
}
