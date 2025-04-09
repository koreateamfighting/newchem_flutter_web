import 'package:flutter/material.dart';
import 'dart:html' as html; // Web용 dart:html 패키지 사용
import 'dart:ui_web' as ui;
import 'main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class MCompanyPage extends StatefulWidget {
  final int selectedTabIndex; // 선택된 탭 인덱스를 전달받기 위한 변수
  final Function(int) onTabChanged; // 탭이 변경될 때 호출되는 콜백 함수

  MCompanyPage({this.selectedTabIndex = 0, required this.onTabChanged});

  @override
  _MCompanyPageState createState() => _MCompanyPageState();
}

class _MCompanyPageState extends State<MCompanyPage> {
  int _selectedTabIndex = 0;
  String url =
      'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3177.5785188096725!2d127.09437752670763!3d37.210239294477205!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b45005eb0bb47%3A0xd85f0759e42f3045!2z64-Z7YOEU0tWMeyEvO2EsCDsp4Dsi53sgrDsl4XshLzthLA!5e0!3m2!1sko!2skr!4v1744184171483!5m2!1sko!2skr" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade';

  String url2 =
      'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d3214.0718188284864!2d127.40560918528085!3d36.33480920020751!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x35654939a7b233b1%3A0x1a9c09f4d30f558f!2z64yA7KCE6rSR7Jet7IucIOykkeq1rCDrqqnrj5nroZwgNDI!5e0!3m2!1sko!2skr!4v1731478790160!5m2!1sko!2skr" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade';

  final Widget _iframeWidget1 = HtmlElementView(
    viewType: 'iframeElement1',
    key: UniqueKey(),
  );

  final Widget _iframeWidget2 = HtmlElementView(
    viewType: 'iframeElement2',
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
    final html.IFrameElement _iFrameElement1 = html.IFrameElement();
    final html.IFrameElement _iFrameElement2 = html.IFrameElement();

    _iFrameElement1.style.height = '100%';
    _iFrameElement1.style.width = isM ? '100' : '100%';
    _iFrameElement1.src = '${url}';
    _iFrameElement1.style.border = 'none';

    _iFrameElement2.style.height = '100%';
    _iFrameElement2.style.width = isM ? '100' : '100%';
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

    return ScreenUtilInit(
      designSize: Size(412, 915),
      child:  MaterialApp(
        home: LayoutBuilder(builder: (context, constraints) {
          // width와 height 모두를 고려한 반응형 조건 설정
          final isMobile = width < 600 && height < 916;
          final isTablet = width >= 600 && width < 1024 && height < 1200;
          final isDesktop = width >= 1024 && height >= 1200;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
                child: Container(
                  color: Colors.white70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: width,
                        height: 280.h,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('assets/company_background.png'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        alignment: Alignment.center,
                        child: Column(

                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            SizedBox(
                              height: 150.h,
                            ),
                            Text(
                              'COMPANY',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15.sp,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w600,
                                height: 0,
                                letterSpacing: 2.16,
                              ),
                            ),
                            Spacer(),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 40.h,
                                    width: 120.6.w,
                                    color: Colors.black.withOpacity(0.5),
                                  ),
                                  _buildTabButton("기업 소개", 0),
                                  _buildTabButton("기업 연혁", 1),
                                  _buildTabButton("오시는 길", 2),
                                  Container(
                                    height: 40.h,
                                    width: 98.6.w,
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
                        height: 150.h,
                        child: Image.asset(
                          'assets/bottom_background.png',
                          fit: BoxFit.fill,
                        ),
                      ),
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
                                        width * (isMobile ? 0.14 : 0.0598),
                                        height * (isMobile ? 0.04 : 0.0425),
                                        onItemTapped),
                                    SizedBox(
                                        width: width *
                                            (isMobile ? 0.004 : 0.0020)),
                                    buildTextButton2(
                                        "COMPANY",
                                        1,
                                        width * (isMobile ? 0.012 : 0.00729),
                                        width * (isMobile ? 0.14 : 0.0598),
                                        height * (isMobile ? 0.04 : 0.0425),
                                        onItemTapped),
                                    SizedBox(
                                        width: width *
                                            (isMobile ? 0.004 : 0.0020)),
                                    buildTextButton2(
                                        "PRODUCTS",
                                        2,
                                        width * (isMobile ? 0.012 : 0.00729),
                                        width * (isMobile ? 0.14 : 0.0598),
                                        height * (isMobile ? 0.04 : 0.0425),
                                        onItemTapped),
                                    SizedBox(
                                        width: width *
                                            (isMobile ? 0.004 : 0.0020)),
                                    buildTextButton2(
                                        "CONTACT US",
                                        3,
                                        width * (isMobile ? 0.012 : 0.00729),
                                        width * (isMobile ? 0.14 : 0.0598),
                                        height * (isMobile ? 0.04 : 0.0425),
                                        onItemTapped),
                                    SizedBox(
                                        width: width *
                                            (isMobile ? 0.004 : 0.0020)),
                                    buildTextButton2(
                                        "DOWNLOADS",
                                        4,
                                        width * (isMobile ? 0.012 : 0.00729),
                                        width * (isMobile ? 0.14 : 0.0598),
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
                                    '대전사무소 | (34816) 대전광역시 중구 목동로 42 302호(목동복합빌딩)\n경기사무소 | (18468) 경기 화성시 동탄순환대로 830 동탄SKV1센터 1215호',
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
                              height: isMobile? height * 0.0600:height * 0.0680,
                              child: Row(
                                children: [
                                  SizedBox(
                                      width: isMobile
                                          ? width * 0.12
                                          : width * 0.18),
                                  Transform.translate(
                                    offset: Offset(0, isMobile? -height * 0.02 :-height * 0.01388),
                                    child: Icon(
                                      Icons.phone,
                                      color: Colors.white,
                                      size: isMobile ? 6 : 18,
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
                                    offset: Offset(0,isMobile? -height * 0.02  :-height * 0.0111),
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
                                    offset: Offset(0,isMobile? -height * 0.02  :-height * 0.0111),
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
                                    offset: Offset(0, isMobile? -height * 0.02  :-height * 0.0111),
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
                    ],
                  ),
                )),
          );
        }),
      ),
    )
   ;
  }

  Widget _buildTabButton(String title, int index) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      // width와 height 모두를 고려한 반응형 조건 설정
      final isMobile = width < 600 && height < 916;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;
      return Container(
        // color:  Color(0xffd4e2f5).withOpacity(0.9),// TabBar 배경색 설정
        color: _selectedTabIndex == index
            ? Colors.white.withOpacity(0.6000000238418579)
            : Colors.black.withOpacity(0.5),
        width: 64.w,
        height: 40.h,
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
                fontSize: 10.sp,
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
      final isMobile = width < 600 && height < 916;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;
      return Padding(
        padding: EdgeInsets.fromLTRB(
            16.w, 16.h, 16.w, 16.h),
        child: SingleChildScrollView(
            child: Container(
              width: width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 60.h,
                  ),
                  Text(
                    'COMPANY INTRODUCTION',
                    style: TextStyle(
                      color: Color(0xFF6194F9),
                      fontSize:  15.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  SelectableText(
                    '(주)뉴켐 홈페이지에 오신 것을 환영합니다.',
                    style: TextStyle(
                      color: Color(0xFF191919),
                      fontSize: 12.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  Container(

                    child: SelectableText.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '(주) 뉴켐은 ',
                            style: TextStyle(
                              color: Color(0xFF5C5C5C),
                              fontSize: 10.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text:
                            '실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지 합성 실험에 필요한\n모든 솔루션을 제공하는 회사',
                            style: TextStyle(
                              color: Color(0xFF191919),
                              fontSize:10.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w500,
                              height: 0,
                            ),
                          ),
                          TextSpan(
                            text:
                            '입니다.\n지난 20년간 화학 및 의약 연구 분야에서 수많은 제품과 시스템을 공급하며,\n고객이 신뢰할 수 있는 회사로 자리매김해 왔습니다. 앞으로도 지속적인 성원 부탁드립니다.\n저희 뉴켐은 언제나 고객과 함께 하겠습니다.',
                            style: TextStyle(
                              color: Color(0xFF5C5C5C),
                              fontSize: 10.sp,
                              fontFamily: 'Pretendard',
                              fontWeight: FontWeight.w400,
                              height:0,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  SizedBox(height: 15.h),
                  Container(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectableText(
                          '(주)뉴켐 대표',
                          style: TextStyle(
                            color: Color(0xFF5C5C5C),
                            fontSize:11.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                        SizedBox(
                          width: width * 0.00729,
                        ),
                        SelectableText(
                          '김천만',
                          style: TextStyle(
                            color: Color(0xFF191919),
                            fontSize:11.sp,
                            fontFamily: 'Pretendard',
                            fontWeight: FontWeight.w500,
                            height: 0,
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
      final isMobile = width < 600 && height < 916;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;

      return Padding(
          padding: EdgeInsets.zero,
          child: Container(
            width: width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 60.h,
                ),
                Text(
                  'HISTORY',
                  style: TextStyle(
                    color: Color(0xFF6194F9),
                    fontSize:15.sp,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w400,
                    height: 0,
                  ),
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  '기업 연혁',
                  style: TextStyle(
                    color: Color(0xFF191919),
                    fontSize: 12.sp,
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
      final isMobile = width < 600 && height < 916;
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
      final isMobile = width < 600 && height < 916;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;
      return Padding(
        padding: EdgeInsets.fromLTRB(
            width * 0.0083, height * 0.0148, width * 0.0083, height * 0.0148),
        child: SingleChildScrollView(
            child: Container(
              width: width,

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 60.h),
                  Text(
                    'DIRECTIONS',
                    style: TextStyle(
                      color: Color(0xFF6194F9),
                      fontSize: 15.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w400,
                      height: 0,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  Text(
                    '뉴켐 오시는 길',
                    style: TextStyle(
                      color: Color(0xFF191919),
                      fontSize:12.sp,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: 20.h),


                  Container(

                    height: 40.h,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.w,
                          height: 40.h,
                          decoration: ShapeDecoration(
                            color: Colors.black,
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
                                width: 10.w,
                                height:10.h,
                                child: Image.asset(
                                  'assets/direction.png',
                                ),
                              ),

                              SelectableText(
                                '경기사무소',
                                style: TextStyle(
                                  color: Color(0xFF96b9ff),
                                  fontSize: 9.sp,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.66,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width:8.w),
                        Container(
                          width: 300.w,
                          height: 40.h,
                          padding: EdgeInsets.only(top : 12.h),
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
                          child: SelectableText(
                              '(18468) 경기 화성시 동탄순환대로 830 동탄SKV1센터 1215호',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF191919),
                                fontSize:9.sp,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,

                                letterSpacing: 0.66,
                              ),
                            ),

                        ),
                      ],
                    ),
                  ),

                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Container(
                        width: width * 0.8,
                        height: 180.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // optional: 배경색을 설정하려면 color 속성 추가
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _iframeWidget1,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.0296,
                  ),
                  Container(

                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 60.w,
                          height: 40.h,
                          decoration: ShapeDecoration(
                            color: Colors.black,
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
                                width: 10.w,
                                height:10.h,
                                child: Image.asset(
                                  'assets/direction.png',
                                ),
                              ),

                              SelectableText(
                                '대전사무소',
                                style: TextStyle(
                                  color: Color(0xFF96b9ff),
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  fontSize: 9.sp,
                                  letterSpacing: 0.66,
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(width:8.w),
                        Container(
                          width: 300.w,
                          height: 40.h,
                          padding: EdgeInsets.only(top : 12.h),
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
                          child:  SelectableText(
                              '(34816) 대전광역시 중구 목동로 42 302호(목동복합빌딩)',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Color(0xFF191919),
                                fontSize:9.sp,
                                fontFamily: 'Pretendard',
                                fontWeight: FontWeight.w500,

                                letterSpacing: 0.66,
                              ),
                            ),
                          ),

                      ],
                    ),
                  ),
                  SizedBox(
                    height: height * 0.0296,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [


                      Container(
                        width: width * 0.8,
                        height: 180.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          // optional: 배경색을 설정하려면 color 속성 추가
                          color: Colors.white,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: _iframeWidget2,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )),
      );
    });
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
}
