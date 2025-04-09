import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MDownloadScreen extends StatefulWidget {
  @override
  _MDownloadScreenState createState() => _MDownloadScreenState();
}

class _MDownloadScreenState extends State<MDownloadScreen> {
  final List<Map<String, String>> downloadData = [
    {
      "number": "3",
      "title": "연속식 원심분리기",
      "link":
      "https://drive.google.com/file/d/1GID2yrNDxZ4Pe7UnoHdphWFJ2YC8ehsx/view?usp=sharing",
      "author": "관리자",
      "date": "2025.02.06",
      "image": 'assets/download_image_03.png'
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return ScreenUtilInit(
        designSize: Size(412, 915),
        child: MaterialApp(
          home: LayoutBuilder(builder: (context, constraints) {
            final isMobile = width < 600 && height < 916;
            final isTablet = width >= 600 && width < 1024 && height < 1200;
            final isDesktop = width >= 1024 && height >= 1200;
            return Scaffold(
                backgroundColor: Colors.white,
                body: SingleChildScrollView(
                  child: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        Container(
                          width: width,
                          height: 280.h,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image:
                                  AssetImage('assets/download_background.png'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 150.h,
                              ),
                              Text(
                                'DOWNLOADS',
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
                            ],
                          ),
                        ),
                        SizedBox(height: 60.h),
                        Container(
                          width: 280.w,
                          child: Table(
                            columnWidths: {
                              0: FixedColumnWidth(40.w),
                              1: FlexColumnWidth(150.w),
                              2: FixedColumnWidth(40.w),
                              3: FixedColumnWidth(70.w),
                            },
                            children: [
                              TableRow(
                                decoration:
                                    BoxDecoration(color: Colors.grey[200]),
                                children: [
                                  _buildTableHeader(
                                      "번호", 8.sp, 20.h),
                                  _buildTableHeader(
                                      "제목", 8.sp,20.h),
                                  _buildTableHeader(
                                      "글쓴이", 8.sp, 20.h),
                                  _buildTableHeader(
                                      "작성 날짜", 8.sp, 20.h),
                                ],
                              ),
                              ...downloadData.asMap().entries.map((entry) {
                                int index = entry.key;
                                var item = entry.value;

                                // 두 번째 행에만 초록색 배경을 적용
                                Color rowColor = index == 1
                                    ? Color(0xFFC9D2E5).withOpacity(0.2)
                                    : Colors.transparent;

                                return TableRow(
                                  decoration: BoxDecoration(color: rowColor),
                                  children: [
                                    _buildTableCell(item["number"]!,
                                       10.sp, 16.h),
                                    _buildLinkCell(
                                      item["title"]!,
                                      item["link"]!,
                                      9.sp,
                                      1.w,
                                      5.h,
                                     34.h,
                                    ),
                                    _buildTableCell(item["author"]!,
                                        1.w, 16.h),
                                    _buildTableCell(item["date"]!,
                                        1.w, 16.h),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ),
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
                  ),
                ));
          }),
        ));
  }

  // 테이블 헤더 빌더
  Widget _buildTableHeader(String title, double fontSize, double headerHeight) {
    return Container(
      height: headerHeight,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(
            color: Colors.black,
            width: 1.5,
          ),
        ),
      ),
      child: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w400,
          color: Color(0xff191919),
          fontFamily: 'Pretendard',
          fontSize: fontSize,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // 테이블 셀 빌더
  Widget _buildTableCell(String content, double cellWidth, double cellHeight) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      padding:
          EdgeInsets.fromLTRB(cellWidth, cellHeight, cellWidth, cellHeight),
      child: Text(
        content,
        style: TextStyle(
          fontSize: 10.sp,
          fontFamily: 'Pretendard',
          fontWeight: FontWeight.w400,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  // 링크 셀 빌더
  Widget _buildLinkCell(
    String title,
    String url,
    double fontSize,
    double edgeWidth,
    double edgeHeight,
    double cellHeight,
  ) {
    return Container(
      height: cellHeight,
      padding:
          EdgeInsets.fromLTRB(edgeWidth, edgeHeight, edgeWidth, edgeHeight),
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
            color: Color(0xFF191919),
            fontSize: fontSize,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
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
