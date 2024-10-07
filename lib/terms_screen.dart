import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("개인정보 수집 및 이용 목적"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "▶ 개인정보의 수집 및 이용목적",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "- 서비스 이용에 따른 본인식별, 실명확인, 가입의사 확인, 연령제한 서비스 이용\n"
                  "- 고지사항 전달, 불만처리 의사소통 경로 확보, 물품배송 시 정확한 배송지 정보 확보\n"
                  "- 신규 서비스 등 최신정보 안내 및 개인맞춤서비스 제공을 위한 자료\n"
                  "- 기타 원활한 양질의 서비스 제공 등",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "▶ 수집하는 개인정보의 항목",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "- 이름, 이메일, 주민등록번호, 주소, 연락처, 핸드폰번호, 그 외 선택항목",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              "▶ 개인정보의 보유 및 이용기간",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              "- 원칙적으로 개인정보의 수집 또는 제공받은 목적 달성 시 지체 없이 파기합니다.\n"
                  "- 다만, 원활한 서비스의 상담을 위해 내용을 전자상거래에서의 소비자보호에 관한 법률 등 "
                  "타법률에 의거하여 최대 5년간 보존할 수 있습니다.",
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
