import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'terms_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:emailjs/emailjs.dart' as emailjs;

class ContactScreen extends StatefulWidget {
  @override
  _ContactScreenState createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  String _selectedRegion = '서울특별시';
  bool _agree = false;

  // EmailJS API 정보 (이곳에 EmailJS에서 받은 정보 입력)
  final String serviceId = 'service_x0mf4q7';
  final String templateId = 'template_17ndb0d';
  final String userId = 'Yv6T8xyIhoMANZBCW';

  Future<void> _sendEmail() async {
    if (!_formKey.currentState!.validate() || !_agree) {
      return;
    }

    // 이메일 전송 데이터를 EmailJS에 맞게 설정
    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final Map<String, dynamic> emailData = {
      'service_id': serviceId,
      'template_id': templateId,
      'user_id': userId,
      'template_params': {
        'company': _companyController.text,
        'name': _nameController.text,
        'phone': _phoneController.text,
        'email': _emailController.text,
        'region': _selectedRegion,
        'title': _titleController.text,
        'message': _contentController.text,
      },
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: json.encode(emailData),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('이메일이 성공적으로 전송되었습니다.')));
        _companyController.clear();
        _nameController.clear();
        _phoneController.clear();
        _emailController.clear();

        _titleController.clear();
        _contentController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('이메일 전송에 실패했습니다. 상태 코드: ${response.statusCode}')));
      }
    } catch (error) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('이메일 전송에 실패했습니다: $error')));
    }
  }

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
                  "Contact Us",
                  style: TextStyle(color: Colors.white, fontSize: 60),
                ),
                Spacer(),
              ],
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center, // 중앙 정렬
                      mainAxisAlignment: MainAxisAlignment.center, // 세로 중앙 정렬
                      children: [
                        Text(
                          "안녕하세요, 고객님.\n전문가에게 맡겨주세요!",
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        Text(
                          "아래 내용을 작성해서 접수하시면, 전문가가 24시간 이내에 빠르고 성실하게 답변 드리겠습니다.",
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        _buildTextField("업체명", _companyController),
                        _buildTextField("성명", _nameController),
                        _buildTextField("전화번호", _phoneController),
                        _buildTextField("E-mail", _emailController,
                            validator: _emailValidator),
                        _buildDropdownField(
                            "지역", _selectedRegion, _handleRegionChange),
                        _buildTextField("제목", _titleController),
                        _buildTextField("내용", _contentController, maxLines: 12),
                        _buildAgreementCheckbox(),
                        SizedBox(height: 20),
                        Center(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Color(0xff28225b),
                                foregroundColor: Colors.white),
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                if (_agree) {
                                  _sendEmail();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content:
                                              Text("개인정보 수집 및 이용목적에 동의해주세요.")));
                                }
                              }
                            },
                            child: Text("보내기"),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 텍스트 필드 빌더
  Widget _buildTextField(String label, TextEditingController controller,
      {int maxLines = 1, String? Function(String?)? validator}) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      width: width * 0.87,
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: Color(0xff28225b)),
          // 라벨 텍스트 색상
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xff28225b)!, width: 2.0), // 선택 시 테두리 색상 변경
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey, width: 1.0), // 비선택 시 테두리 색상
          ),

          border: OutlineInputBorder(),
        ),
        validator: validator,
      ),
    );
  }

  // 지역 선택 드롭다운 빌더
  Widget _buildDropdownField(
      String label, String value, ValueChanged<String?> onChanged) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      width: width * 0.87,

      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: value,
        decoration:
            InputDecoration(labelText: label, border: OutlineInputBorder()),
        dropdownColor: Colors.white,
        items: [
          '서울특별시',
          '경기도',
          '인천광역시',
          '강원도',
          '충청남도',
          '충청북도',
          '세종특별자치시',
          '대전광역시',
          '경상북도',
          '경상남도',
          '대구광역시',
          '울산광역시',
          '부산광역시',
          '전라북도',
          '전라남도',
          '광주광역시',
          '제주특별자치도'
        ].map((region) {
          return DropdownMenuItem<String>(
            value: region,
            child: Text(region),
          );
        }).toList(),
        onChanged: onChanged,
      ),
    );
  }

  // 동의 체크박스와 약관 보기 버튼
  Widget _buildAgreementCheckbox() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          children: [
            Checkbox(
              value: _agree,
              onChanged: (value) {
                setState(() {
                  _agree = value ?? false;
                });
              },
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  _agree = !_agree;
                });
              },
              child: Text("개인정보 수집 및 이용목적에 동의합니다."),
            ),
          ],
        ),
        TextButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => TermsScreen()), // 약관 보기 화면으로 이동
            );
          },
          child: Text(
            "약관 보기",
            style: TextStyle(
                color: Colors.blue, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  // 이메일 유효성 검증 함수
  String? _emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "이메일을 입력해주세요.";
    }
    final emailPattern = r'^[^@]+@[^@]+\.[^@]+';
    if (!RegExp(emailPattern).hasMatch(value)) {
      return "유효한 이메일 주소를 입력해주세요.";
    }
    return null;
  }

  // 지역 선택 함수
  void _handleRegionChange(String? newValue) {
    setState(() {
      _selectedRegion = newValue ?? '서울특별시';
    });
  }
}
