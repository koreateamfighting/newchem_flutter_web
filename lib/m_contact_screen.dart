import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'terms_screen.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:emailjs/emailjs.dart' as emailjs;
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MContactScreen extends StatefulWidget {
  @override
  _MContactScreenState createState() => _MContactScreenState();
}

class _MContactScreenState extends State<MContactScreen> {
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
  final String serviceId = 'service_oe5e5f1';
  final String templateId = 'template_c89dfx6';
  final String userId = '7f380iYy4BdLodvzb';

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

    return ScreenUtilInit(
      designSize: Size(412, 915),
      child: MaterialApp(
        home: LayoutBuilder(builder: (context, constraints) {
          // width와 height 모두를 고려한 반응형 조건 설정
          final isMobile = width < 600 && height < 916;
          final isTablet = width >= 600 && width < 1024 && height < 1200;
          final isDesktop = width >= 1024 && height >= 1200;

          return Scaffold(
            backgroundColor: Colors.white,
            body: SingleChildScrollView(
              child: Container(
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: width,
                      height: 280.h,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/contact_us_background.png'),
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
                            'CONTACT US',
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

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Form(
                          key: _formKey,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            // 중앙 정렬
                            mainAxisAlignment: MainAxisAlignment.start,
                            // 세로 중앙 정렬
                            children: [
                              SizedBox(height: 60.h),
                              Text(
                                'CONTACT US',
                                style: TextStyle(
                                  color: Color(0xFF6194F9),
                                  fontSize: 20.sp,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 60.h),
                              Text(
                                '안녕하세요, 고객님 뉴켐에게 맡겨주세요!',
                                style: TextStyle(
                                  color: Color(0xFF191919),
                                  fontSize: 16.sp,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w700,
                                  height: 0,
                                ),
                              ),
                              SizedBox(height: 40.h),
                              Text(
                                '아래 내용을 작성해서 접수해주시면, 담당자가 24시간 이내에\n빠르고 성실하게 답변 드리겠습니다.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: Color(0xFF5C5C5C),
                                  fontSize: 12.sp,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              SizedBox(height: 40.h),
                              newTextField('업체명을 입력해주세요.', '업체명',
                                  _companyController),
                              newTextField(
                                  '이름을 입력해주세요.', '이름', _nameController),
                              newTextField('전화번호를 입력해주세요.', '전화번호',
                                  _phoneController),
                              newTextField(
                                  '이메일을 입력해주세요.', '이메일', _emailController),


                              _buildDropdownField(
                                "지역",
                                _selectedRegion,
                                _handleRegionChange,
                              ),
                              SizedBox(height: 20.h),

                              newTextField2(
                                  '문의사항 제목을 입력해주세요.', '제목', _titleController),

                              newTextField3(
                                  '문의사항 내용을 입력해주세요.', '내용', _contentController),
                              Row(
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
                                          activeColor: Color(0xff6194f9)),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _agree = !_agree;
                                          });
                                        },
                                        child: Text(
                                          '개인정보 수집 및 이용목적에 동의합니다.',
                                          style: TextStyle(
                                            color: Color(0xFF414141),
                                            fontSize: 12.sp,
                                            fontFamily: 'Pretendard',
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                TermsScreen()), // 약관 보기 화면으로 이동
                                      );
                                    },
                                    child: Text(
                                      '약관보기',
                                      style: TextStyle(
                                        color: Color(0xFF6194F9),
                                        fontSize: 12.sp,
                                        fontFamily: 'Pretendard',
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),

                                ],
                              ),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 120.w,
                                    height: 40.h,
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xff6194f9),
                                        foregroundColor: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                      ),
                                      onPressed: () {
                                        if (_formKey.currentState!.validate()) {
                                          if (_agree) {
                                            _sendEmail();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        "개인정보 수집 및 이용목적에 동의해주세요.")));
                                          }
                                        }
                                      },
                                      child: Text(
                                        '보내기',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 12.sp,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
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
                                            '대전사무소 | (34816) 대전광역시 중구 목동로 42 302호(목동복합빌딩)\n경기사무소 |(18468) 경기 화성시 동탄순환대로 830 동탄SKV1센터 1215호',
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
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          );
        }),
      ),
    );
  }

  // 텍스트 필드 빌더
  Widget _buildTextField(
    String label,
    TextEditingController controller,
    double width,
    double height, {
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: width * 0.0041),
      child: TextFormField(
        controller: controller,
        style: TextStyle(
            fontSize: width * 0.009,
            color: Colors.black,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500),
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: label,
          hintStyle: TextStyle(
              color: Color(0xff191919),
              fontSize: width * 0.009,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500),
          // 라벨 텍스트 색상
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xff6194f9), width: 1.50), // 선택 시 테두리 색상 변경
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.grey, width: 1.0), // 비선택 시 테두리 색상
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8), // 기본 테두리 둥글게
          ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '지역을 선택해주세요.',
          style: TextStyle(
            color: Color(0xFF191919),
            fontSize: 10.sp,
            fontFamily: 'Pretendard',
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 16.h,
        ),
        Container(
          width: 315.w,

          child: DropdownButtonFormField<String>(
            value: value,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey, width: 1.5), // 비선택 시 테두리 색상
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: Color(0xff6194f9), width: 1.5), // 선택 시 테두리 색상
              ),
            ),
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
                child: Text(
                  region,
                  style: TextStyle(fontSize: 10.sp,color: Color(0xff5c5c5c)),
                ),
              );
            }).toList(),
            onChanged: onChanged,
          ),
        )
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

  Container newTextField(
      String title, String hintText, TextEditingController controller) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      width: 313.w,
      height: 90.h,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF191919),
              fontSize: 10.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Container(
            width: 313.w,
            height: 60.h,
            child: TextFormField(
              controller: controller,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500),
              maxLines: 1,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                    color: Color(0xff191919).withOpacity(0.3),
                    fontSize: 10.sp,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500),
                // 라벨 텍스트 색상
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xff6194f9), width: 1.50), // 선택 시 테두리 색상 변경
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey, width: 1.0), // 비선택 시 테두리 색상
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // 기본 테두리 둥글게
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container newTextField2(
      String title, String hintText, TextEditingController controller) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      width: 313.w,
      height: 90.h,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF191919),
              fontSize: 10.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Container(
            width: 313.w,
            height: 60.h,
            child: TextFormField(
              controller: controller,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500),
              maxLines: 1,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                    color: Color(0xff191919).withOpacity(0.3),
                    fontSize: 10.sp,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500),
                // 라벨 텍스트 색상
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xff6194f9), width: 1.50), // 선택 시 테두리 색상 변경
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey, width: 1.0), // 비선택 시 테두리 색상
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // 기본 테두리 둥글게
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Container newTextField3(
      String title, String hintText, TextEditingController controller) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Container(
      width: 313.w,
      height: 250.h,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: Color(0xFF191919),
              fontSize: 10.sp,
              fontFamily: 'Pretendard',
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(
            height: 16.h,
          ),
          Container(
            width: 313.w,
            height: 200.h,
            child: TextFormField(
              controller: controller,
              style: TextStyle(
                  fontSize: 10.sp,
                  color: Colors.black,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500),
              maxLines: 20,
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                    color: Color(0xff191919).withOpacity(0.3),
                    fontSize: 10.sp,
                    fontFamily: 'Pretendard',
                    fontWeight: FontWeight.w500),
                // 라벨 텍스트 색상
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Color(0xff6194f9), width: 1.50), // 선택 시 테두리 색상 변경
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.grey, width: 1.0), // 비선택 시 테두리 색상
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8), // 기본 테두리 둥글게
                ),
              ),
            ),
          )
        ],
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
