import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher_web/url_launcher_web.dart';

class DownloadScreen extends StatelessWidget {
  final List<Map<String, String>> downloadData = [
    {
      "number": "3",
      "title": "[첨부] 다운로드 자료 타이틀 예 3 (구글드라이브 경로)",
      "link": "https://drive.google.com/file/d/16UjB2PEM6H520jdrzn614uAXFO0WAMsx/view?usp=sharing",
      "author": "관리자",
      "date": "2024-00-00"
    },
    {
      "number": "2",
      "title": "[첨부] 다운로드 자료 타이틀 예 2 (구글드라이브 경로)",
      "link": "https://drive.google.com/file/d/16UjB2PEM6H520jdrzn614uAXFO0WAMsx/view?usp=sharing",
      "author": "관리자",
      "date": "2024-00-00"
    },
    {
      "number": "1",
      "title": "[첨부] 다운로드 자료 타이틀 예 1 (구글드라이브 경로)",
      "link": "https://drive.google.com/file/d/16UjB2PEM6H520jdrzn614uAXFO0WAMsx/view?usp=sharing",
      "author": "관리자",
      "date": "2024-00-00"
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Scaffold(
      backgroundColor: Colors.white,

      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.3,
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
                  "Download",
                  style: TextStyle(color: Colors.white, fontSize: 60),
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(height: 10),
          SingleChildScrollView(

            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Data 링크",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20),
                Table(
                  columnWidths: {
                    0: FixedColumnWidth(MediaQuery.of(context).size.width * 0.1), // 화면 크기에 따라 셀 크기 조정
                    1: FlexColumnWidth(),
                    2: FixedColumnWidth(MediaQuery.of(context).size.width * 0.2),
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
        ],
      ),

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
          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
        ),
      ),
    );
  }
}