import 'package:flutter/material.dart';
import 'dart:html' as html; // Web용 dart:html 패키지 사용
import 'dart:ui' as ui;
import 'main.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final isM = width < 600;
    final html.IFrameElement _iFrameElement = html.IFrameElement();

    _iFrameElement.style.height = '120%';
    _iFrameElement.style.width = isM ? '100' : '60%';
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
              child: Container(
            height: _selectedTabIndex == 0 ? height * 1.958 :_selectedTabIndex == 1? height * 2.446 : height * 2.476,
            color: Colors.white70,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: width,
                  height: height * 0.5230,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/company_background.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * 0.260,
                      ),
                      Text(
                        'COMPANY',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: width * 0.028,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w600,
                          height: 0,
                          letterSpacing: 2.16,
                        ),
                      ),
                      Spacer(),
                      Container(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              height: height * 0.060,
                              width: width * 0.322,
                              color: Colors.black.withOpacity(0.5),
                            ),
                            _buildTabButton("기업 소개", 0),
                            _buildTabButton("기업 연혁", 1),
                            _buildTabButton("오시는 길", 2),
                            Container(
                              height: height * 0.060,
                              width: width * 0.328,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                _buildTabContent(),
                //SizedBox(height: 75,),
                Container(
                  height: height * 0.3722,
                  child: Image.asset(
                    'assets/bottom_background.png',
                    width: width,
                    height: height * 0.3900,
                    fit: BoxFit.fitWidth,
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
                              buildTextButton2("COMPANY", 1, width * 0.00729,
                                  onItemTapped),
                              SizedBox(
                                width: width * 0.0020,
                              ),
                              buildTextButton2("PRODUCTS", 2, width * 0.00729,
                                  onItemTapped),
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
                                  child: Image.asset('assets/logo-white.png'),
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
            ),
          )),
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
        color: _selectedTabIndex == index
            ? Colors.white.withOpacity(0.6000000238418579)
            : Colors.black.withOpacity(0.5),
        width: width * 0.1166,
        height: height * 0.060,
        padding: EdgeInsets.zero,
        child: TextButton(
          onPressed: () {
            setState(() {
              _selectedTabIndex = index;
              widget.onTabChanged(index); // 탭 변경 시 부모에 알림
            });
          },
          style: TextButton.styleFrom(
            backgroundColor: Colors.transparent, // 버튼 배경 투명 설정
            padding: EdgeInsets.zero, // 버튼의 기본 여백을 없애려면 사용
            tapTargetSize: MaterialTapTargetSize.shrinkWrap, // 버튼의 크기를 최소화
            splashFactory: NoSplash.splashFactory, // 리플 효과 제거
          ),
          child: Text(
            title,
            style: TextStyle(
                fontFamily: 'Pretendard',
                fontSize: width * 0.0104,
                fontWeight: FontWeight.w600,
                color: _selectedTabIndex == index ? Colors.black : Colors.white,
                decorationColor: Colors.black),
          ),
        ),
      );
    });
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
        padding:  EdgeInsets.fromLTRB(width * 0.0083, height * 0.0148, width * 0.0083, height * 0.0148),
        child: SingleChildScrollView(
            child: Container(
          width: width,
          height: height * 0.5800,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.0796),
              Text(
                'COMPANY INTRODUCTION',
                style: TextStyle(
                  color: Color(0xFF6194F9),
                  fontSize: width * 0.0104,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              SizedBox(height: height * 0.024),
              SelectableText(
                '(주)뉴켐 홈페이지에 오신 것을 환영합니다.',
                style: TextStyle(
                  color: Color(0xFF191919),
                  fontSize: width * 0.0208,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: height * 0.05),
              SizedBox(
                width: width * 0.4640,
                child: SelectableText.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: '(주) 뉴켐은 ',
                        style: TextStyle(
                          color: Color(0xFF5C5C5C),
                          fontSize: width * 0.0104,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          height: height * 0.0018,
                        ),
                      ),
                      TextSpan(
                        text:
                            '실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지 합성 실험에 필요한            모든 솔루션을 제공하는 회사',
                        style: TextStyle(
                          color: Color(0xFF191919),
                          fontSize: width * 0.0104,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w500,
                          height: height * 0.0018,
                        ),
                      ),
                      TextSpan(
                        text:
                            '입니다.\n지난 20년간 화학 및 의약 연구 분야에서 수많은 제품과 시스템을 공급하며, 고객이 신뢰할 수 있는            회사로 자리 매김해 왔습니다. 앞으로도 지속적인 성원 부탁드립니다.\n저희 뉴켐은 언제나 고객과 함께 하겠습니다.',
                        style: TextStyle(
                          color: Color(0xFF5C5C5C),
                          fontSize: width * 0.0104,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                          height: height * 0.0018,
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: height * 0.05),
              Container(
                height: height * 0.0185,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SelectableText(
                      '(주)뉴켐 대표',
                      style: TextStyle(
                        color: Color(0xFF5C5C5C),
                        fontSize: width * 0.0083,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w400,
                        height: 0.16,
                      ),
                    ),
                    SizedBox(
                      width: width *0.00729,
                    ),
                    SelectableText(
                      '김천만',
                      style: TextStyle(
                        color: Color(0xFF191919),
                        fontSize: width * 0.0104,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 0.10,
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        )),
      );
    });
  }

  Widget _buildHistoryTab() {
    return LayoutBuilder(builder: (context, constraints) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      // width와 height 모두를 고려한 반응형 조건 설정
      final isMobile = width < 600 && height < 800;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;

      return Padding(
          padding: EdgeInsets.zero,
          child: Container(
            width: width,
            height: height * 1.1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: height * 0.0796),
                Text(
                  'HISTORY',
                  style: TextStyle(
                    color: Color(0xFF6194F9),
                    fontSize: width * 0.0104,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                SizedBox(height: height * 0.024),
                Text(
                  '기업 연혁',
                  style: TextStyle(
                    color: Color(0xFF191919),
                    fontSize: width * 0.0208,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: height * 0.065),
                Image.asset('assets/company_history.png'),
              ],
            ),
          ));
    });
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
        padding: EdgeInsets.symmetric(vertical: width * 0.0041),
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
    });
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
      return Padding(
        padding:  EdgeInsets.fromLTRB(width * 0.0083, height * 0.0148, width * 0.0083, height * 0.0148),
        child: SingleChildScrollView(
            child: Container(
          width: width,
          height: height * 1.1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.0796),
              Text(
                'DIRECTIONS',
                style: TextStyle(
                  color: Color(0xFF6194F9),
                  fontSize: width * 0.0104,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w400,
                  height: 0,
                ),
              ),
              SizedBox(height: height * 0.024),
              Text(
                '뉴켐 오시는 길',
                style: TextStyle(
                  color: Color(0xFF191919),
                  fontSize: width * 0.0208,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w700,
                ),
              ),
              SizedBox(height: height * 0.0843),
              Container(
                width: width * 0.4817,
                height: height * 0.0712,
                decoration: ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6)),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: width * 0.010,
                      height: height * 0.025,
                      child: Image.asset(
                        'assets/direction.png',
                      ),
                    ),
                    SizedBox(
                      width: width * 0.011,
                    ),
                    SelectableText(
                      '경기사무소 | (18021) 경기 평택시 도시지원로 121 고덕지식공작소아이타워 501호',
                      style: TextStyle(
                        color: Color(0xFF191919),
                        fontSize: width * 0.0114,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500,
                        height: 0.06,
                        letterSpacing: 0.66,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.0296,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(width: width * 0.25,),
                  Container(
                    width: width * 0.8000,
                    height: height * 0.45,
                    child: _iframeWidget,
                  ),

                ],
              )


            ],
          ),
        )),
      );
    });
  }

  // 전역에서 사용 가능한 `buildTextButton` 함수 정의
  Container buildTextButton2(String label, int index, double buttonFontSize,
      Function(int) onItemTapped) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      width: width * 0.0598,
      height: height * 0.0425,
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
}
