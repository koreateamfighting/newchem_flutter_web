import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';

class DownloadScreen extends StatefulWidget {
  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
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

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return MaterialApp(
      home: LayoutBuilder(builder: (context, constraints) {
        final isMobile = width < 600 && height < 916;
        final isTablet = width >= 600 && width < 1024 && height < 1200;
        final isDesktop = width >= 1024 && height >= 1200;
        return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                height: height * 1.93,
                color: Colors.white,
                child: Column(
                  children: [
                    Container(
                      width: width,
                      height: height * 0.5230,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/download_background.png'),
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
                            'DOWNLOADS',
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
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.097),
                    Container(
                      width: width * 0.625,
                      child: Table(
                        columnWidths: {
                          0: FixedColumnWidth(width * 0.05),
                          1: FlexColumnWidth(width * 2.2),
                          2: FixedColumnWidth(width * 0.07),
                          3: FixedColumnWidth(width * 0.140),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            children: [
                              _buildTableHeader(
                                  "번호", width * 0.009, height * 0.0370),
                              _buildTableHeader(
                                  "제목", width * 0.009, height * 0.0370),
                              _buildTableHeader(
                                  "글쓴이", width * 0.009, height * 0.0370),
                              _buildTableHeader(
                                  "작성 날짜", width * 0.009, height * 0.0370),
                            ],
                          ),
                          ...downloadData.asMap().entries.map((entry) {
                            int index = entry.key;
                            var item = entry.value;

                            // 두 번째 행에만 초록색 배경을 적용
                            Color rowColor = index == 1 ? Color(0xFFC9D2E5).withOpacity(0.2) : Colors.transparent;

                            return TableRow(
                              decoration: BoxDecoration(color: rowColor),
                              children: [
                                _buildTableCell(item["number"]!, width * 0.0041, height * 0.0074),
                                _buildLinkCell(
                                  item["title"]!,
                                  item["link"]!,
                                  width * 0.009,
                                  width * 0.0041,
                                  height * 0.0074,
                                  height * 0.0500,
                                ),
                                _buildTableCell(item["author"]!, width * 0.0041, height * 0.0074),
                                _buildTableCell(item["date"]!, width * 0.0041, height * 0.0074),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ),
                    SizedBox(height: height * 0.3000),
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
                                  SizedBox(width: width * 0.0020),
                                  buildTextButton2("COMPANY", 1,
                                      width * 0.00729, onItemTapped),
                                  SizedBox(width: width * 0.0020),
                                  buildTextButton2("PRODUCTS", 2,
                                      width * 0.00729, onItemTapped),
                                  SizedBox(width: width * 0.0020),
                                  buildTextButton2("CONTACT US", 3,
                                      width * 0.00729, onItemTapped),
                                  SizedBox(width: width * 0.0020),
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
                              SizedBox(width: width * 0.1875),
                              Container(
                                width: width * 0.3156,
                                height: height * 0.0470,
                                child: Text(
                                  '대전사무소 | (34816) 대전광역시 중구 목동로 42 302호(목동복합빌딩)\n경기사무소 | (18021) 경기 평택시 도시지원로 121 고덕지식공작소아이타워 510호',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: width * 0.0093,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    letterSpacing: 0.54,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: height * 0.04351,
                          ),
                          Container(
                            height: height * 0.0680,
                            child: Row(
                              children: [
                                SizedBox(width: width * 0.1875),
                                Transform.translate(
                                  offset: Offset(0, -height * 0.01388),
                                  child: Icon(
                                    Icons.phone,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                SizedBox(width: width * 0.0041),
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
                                SizedBox(width: width * 0.0083),
                                Transform.translate(
                                  offset: Offset(0, -height * 0.0111),
                                  child: Icon(
                                    Icons.print,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                SizedBox(width: width * 0.0041),
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
                                SizedBox(width: width * 0.004),
                                Transform.translate(
                                  offset: Offset(0, -height * 0.0111),
                                  child: Icon(
                                    Icons.local_post_office,
                                    color: Colors.white,
                                    size: 18,
                                  ),
                                ),
                                SizedBox(width: width * 0.004),
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
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: height * 0.04351),
                          Row(
                            children: [
                              SizedBox(width: width * 0.1979),
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ));
      }),
    );
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
          fontSize: width * 0.009,
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
          overlayColor: Colors.transparent, // 눌렀을 때 생기는 그림자 제거
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero, // 직사각형으로 설정
          ),
        ),
      ),
    );
  }
}
