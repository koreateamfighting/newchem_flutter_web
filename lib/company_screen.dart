import 'package:flutter/material.dart';

class CompanyPage extends StatefulWidget {
  @override
  _CompanyPageState createState() => _CompanyPageState();
}

class _CompanyPageState extends State<CompanyPage> {
  int _selectedTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 200,
            color: Colors.grey[300],
            alignment: Alignment.center,
            child: Text(
              'Company',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildTabButton("기업 소개", 0),
                _buildTabButton("기업 연혁", 1),
                _buildTabButton("오시는 길", 2),
              ],
            ),
          ),
          Expanded(
            child: _buildTabContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    return TextButton(
      onPressed: () {
        setState(() {
          _selectedTabIndex = index;
        });
      },
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: _selectedTabIndex == index ? FontWeight.bold : FontWeight.normal,
          color: _selectedTabIndex == index ? Colors.blue : Colors.black,
        ),
      ),
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
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "뉴켐 홈페이지에 오신 것을 환영합니다",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Text(
              "뉴켐은 실험실에서 사용하는 기초장비부터 반응 및 자동화 시스템까지, "
                  "합성 실험에 필요한 모든 솔루션을 제공하는 회사입니다. "
                  "\n\n지난 20년간 화학 및 의약 연구 분야에서 수많은 제품과 시스템을 공급하며 "
                  "고객이 신뢰할 수 있는 회사로 자리매김해 왔습니다. "
                  "\n\n앞으로도 지속적인 성원 부탁드립니다. 저희 뉴켐은 언제나 고객과 함께 하겠습니다.",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Text(
              "(주) 뉴켐 대표\n김 천 만",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHistoryTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("기업 연혁", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          SizedBox(height: 20),
          _buildHistoryItem("2024년 4월", "설립"),
          _buildHistoryItem("2024년 5월", "Heidolph Korea 대전지역 독점대리점 계약"),
          _buildHistoryItem("2024년 6월", "독일 NORMAG 파트너쉽 체결"),
          _buildHistoryItem("2024년 8월", "미국 CINC사 파트너쉽 체결"),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(String date, String event) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            date,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(width: 10),
          Expanded(child: Text(event, style: TextStyle(fontSize: 18))),
        ],
      ),
    );
  }

  Widget _buildLocationTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            "주소: 경기사무소 (18021) 경기 평택시 도시지원로 121 고덕지식공작소아이타워 510호",
            style: TextStyle(fontSize: 18),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          // Expanded(
          //   child: WebView(
          //     initialUrl:
          //     'https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d669.6223690480622!2d127.01586977089258!3d37.02699966322705!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x357b3d001631c641%3A0x2cd353d15ed8488b!2z6rOg642V7KeA7Iud6rO17J6R7IaM7JWE7J207YOA7JuMIOyngOyLneyCsOyXheyEvO2EsA!5e0!3m2!1sko!2skr!4v1717727526433!5m2!1sko!2skr',
          //     javascriptMode: JavascriptMode.unrestricted,
          //   ),
          // ),
        ],
      ),
    );
  }
}
