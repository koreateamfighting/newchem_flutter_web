import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';

class DownloadScreen extends StatelessWidget {
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
        // width와 height 모두를 고려한 반응형 조건 설정
        final isMobile = width < 600 && height < 800;
        final isTablet = width >= 600 && width < 1024 && height < 1200;
        final isDesktop = width >= 1024 && height >= 1200;

        return Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                width: double.infinity,
                height: isMobile? height * 0.2000:height * 0.3,
                // 높이를 반응형으로 조정
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/main-background2.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Spacer(),
                    Text(
                      "Downloads",
                      style :GoogleFonts.poppins(textStyle:TextStyle(color: Colors.white, fontSize: isMobile? 30:60), )
                    ),
                    Spacer(),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      SizedBox(height: 20),
                      Table(
                        columnWidths: {
                          0: FixedColumnWidth(
                              MediaQuery.of(context).size.width *
                                  0.1), // 화면 크기에 따라 셀 크기 조정
                          1: FlexColumnWidth(),
                          2: FixedColumnWidth(
                              MediaQuery.of(context).size.width * 0.2),
                        },
                        children: [
                          TableRow(
                            decoration: BoxDecoration(color: Colors.grey[200]),
                            children: [
                              _buildTableHeader("번호"),
                              _buildTableHeader("제목"),
                              _buildTableHeader("글쓴이"),
                              _buildTableHeader("작성 날짜"),
                            ],
                          ),
                          ...downloadData.map((item) {
                            return TableRow(
                              children: [
                                _buildTableCell(item["number"]!),
                                _buildLinkCell(item["title"]!, item["link"]!),
                                _buildTableCell(item["author"]!),
                                _buildTableCell(item["date"]!),
                              ],
                            );
                          }).toList(),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  // 테이블 헤더 빌더
  Widget _buildTableHeader(String title) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
    );
  }

  // 테이블 셀 빌더
  Widget _buildTableCell(String content) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        content,
        textAlign: TextAlign.center,
      ),
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
}
