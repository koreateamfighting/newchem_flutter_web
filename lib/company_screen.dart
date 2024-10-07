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


  void initState(){
    super.initState();
    _selectedTabIndex = widget.selectedTabIndex;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    final html.IFrameElement _iFrameElement = html.IFrameElement(
    );

    _iFrameElement.style.height = '120%';
    _iFrameElement.style.width = '60%';
    _iFrameElement.src = '${url}';
    _iFrameElement.style.border = 'none';

// ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(
      'iframeElement',
      (int viewId) => _iFrameElement,
    );
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
                  "Company",
                  style: TextStyle(color: Colors.white, fontSize: 60),
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildTabButton("기업 소개", 0),
                _buildTabButton("기업 연혁", 1),
                _buildTabButton("오시는 길", 2),
              ],
            ),
          ),
          Column(
            children: [
              Divider(),
              SizedBox(
                height: 60,
              ),
              _buildTabContent(),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildTabButton(String title, int index) {
    return TextButton(
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
                : FontWeight.normal,
            color: _selectedTabIndex == index ? Colors.blueAccent : Colors.black,
            decoration: _selectedTabIndex == index
                ? TextDecoration.underline
                : TextDecoration.none,
            // 언더라인 추가
            decorationColor: Colors.blueAccent),
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
          child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "뉴켐 홈페이지에 오신 것을 환영합니다.",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
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
              style: TextStyle(fontSize: 20),
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

  Widget _buildHistoryTab() {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("기업 연혁",
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
              Divider(
                color: Colors.grey,
              ),
              SizedBox(height: 40),
              _buildHistoryItem("2024년 4월", "설립"),
              _buildHistoryItem("2024년 5월", "Heidolph Korea 대전지역 독점대리점 계약"),
              _buildHistoryItem("2024년 6월", "독일 NORMAG 파트너쉽 체결"),
              _buildHistoryItem("2024년 8월", "미국 CINC사 파트너쉽 체결"),
            ],
          ),
        ));
  }

  Widget _buildHistoryItem(String date, String event) {
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

  Widget _buildLocationTab() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
          child: Container(
        width: MediaQuery.of(context).size.width * 0.4,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "오시는 길",
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
            ),
            Divider(
              color: Colors.grey,
            ),
            SizedBox(height: 40),
            Text(
              "● 주소 : 경기사무소 (18021) 경기 평택시 도시지원로 121 고덕지식공작소아이타워 510호",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            SizedBox(height: 50),
            Container(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.3,
              child: _iframeWidget,
            )
          ],
        ),
      )),
    );
  }
}
