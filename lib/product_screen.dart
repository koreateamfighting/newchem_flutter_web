import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main.dart';
import 'package:dotted_border/dotted_border.dart';
class ProductScreen extends StatefulWidget {
  final int initialTabIndex; // 초기 탭 인덱스를 받을 변수 추가
  final Function(int) onTabChanged;

  ProductScreen(
      {this.initialTabIndex = 0, required this.onTabChanged}); // 기본값 0으로 설정

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  int _selectedTabIndex = 0;
  String? _selectedName;
  String? _selectedImage;
  String? _selectedContent;
  late TabController _mainTabController; // 메인 탭 컨트롤러
  late TabController _heidolphTabController; // Heidolph 하위 탭 컨트롤러
  late TabController _normagTabController; // NORMAG 하위 탭 컨트롤러
  late TabController _cincTabController;

  final Map<int, bool> _isHovered = {};



  @override
  void initState() {

    super.initState();
    _selectedTabIndex = widget.initialTabIndex;
    print("탭 이동 번호 : ${widget.initialTabIndex}");
    // TabController에 초기 인덱스를 설정
    _mainTabController = TabController(
        length: 3, vsync: this, initialIndex: widget.initialTabIndex);


    // 메인 탭이 변경될 때 URL 업데이트
    _mainTabController.addListener(() {
      if (_mainTabController.indexIsChanging) {
        widget.onTabChanged(_mainTabController.index);
      }
    });
    _heidolphTabController =
        TabController(length: 5, vsync: this); // Heidolph 하위 탭
    _normagTabController = TabController(length: 3, vsync: this); // NORMAG 하위 탭
    _cincTabController = TabController(length: 5, vsync: this);
  }

  @override
  void didUpdateWidget(ProductScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    // 초기 탭 인덱스가 변경되었을 때 메인 탭을 업데이트
    if (oldWidget.initialTabIndex != widget.initialTabIndex) {
      _mainTabController.animateTo(widget.initialTabIndex);
    }
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _heidolphTabController.dispose();
    _normagTabController.dispose();
    _cincTabController.dispose();
    super.dispose();
  }

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
          body: SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                      height: height * 0.5230,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/product_background.png'),
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
                            'PRODUCTS',
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
                          Container(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Container(
                                  height: height * 0.060,
                                  width: width * 0.322,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                                _buildTabButton("Heidolph", 0),
                                _buildTabButton("NORMAG", 1),
                                _buildTabButton("CINC Industry", 2),
                                Container(
                                  height: height * 0.060,
                                  width: width * 0.328,
                                  color: Colors.black.withOpacity(0.5),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )),
                  Container(
                    height: height * 1.45,
                    padding: EdgeInsets.only(top: height * 0.0370),
                    child: _buildTabContent(),
                  ),
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
                                SizedBox(
                                  width: width * 0.0020,
                                ),
                                buildTextButton2("COMPANY", 1, width * 0.00729,
                                    onItemTapped),
                                SizedBox(
                                  width: width * 0.0020,
                                ),
                                buildTextButton2("PRODUCTS", 2, width * 0.00729,
                                    onItemTapped),
                                SizedBox(
                                  width: width * 0.0020,
                                ),
                                buildTextButton2("CONTACT US", 3,
                                    width * 0.00729, onItemTapped),
                                SizedBox(
                                  width: width * 0.0020,
                                ),
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
                            SizedBox(
                              width: width * 0.1875,
                            ),
                            Container(
                              width: width * 0.3156,
                              height: height * 0.0462,
                              child: Text(
                                '대전사무소 | (34816) 대전광역시 중구 목동로 42 302호(목동복합빌딩)\n경기사무소 | (18021) 경기 평택시 도시지원로 121 고덕지식공작소아이타워 501호',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: width * 0.0093,
                                  fontFamily: 'Pretendard',
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.54,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: height * 0.04351,
                        ),
                        Container(
                          height: height * 0.0680,
                          child: Row(
                            children: [
                              SizedBox(
                                width: width * 0.1875,
                              ),
                              Transform.translate(
                                offset: Offset(0, -height * 0.01388),
                                child: Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.0041,
                              ),
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
                              SizedBox(
                                width: width * 0.0083,
                              ),
                              Transform.translate(
                                offset: Offset(0, -height * 0.0111),
                                child: Icon(
                                  Icons.print,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.0041,
                              ),
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
                              SizedBox(
                                width: width * 0.004,
                              ),
                              Transform.translate(
                                offset: Offset(0, -height * 0.0111),
                                child: Icon(
                                  Icons.local_post_office,
                                  color: Colors.white,
                                  size: 18,
                                ),
                              ),
                              SizedBox(
                                width: width * 0.004,
                              ),
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
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: height * 0.04351,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: width * 0.1979,
                            ),
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
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }

  // Heidolph 대분류 탭
  Widget _buildHeidolphTab() {
    return LayoutBuilder(builder: (context, constraints) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      // width와 height 모두를 고려한 반응형 조건 설정
      final isMobile = width < 600 && height < 800;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;

      return Column(
        children: [
          Container(
            // padding: EdgeInsets.fromLTRB(
            //     isMobile ? 0 : 400, 0, isMobile ? 0 : 400, 0),
            width: width * 0.471875,
            child: TabBar(
              controller: _heidolphTabController,
              labelColor: Colors.black,
              indicatorColor: Color(0xff6194f9),
              dividerColor: Colors.transparent,
              unselectedLabelStyle: TextStyle(
                  fontSize: width * 0.0093,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              tabs: [
                Container(
                  width: width * 0.1130,
                  height: height * 0.037037,
                  // 각 탭에 일정 간격 설정
                  child: Text(
                    "Rotary Evaporator",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width * 0.0093,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ), // 텍스트 크기를 18로 설정
                  ),
                ),
                Container(
                  width: width * 0.0666,
                  height: height * 0.037037,
                  // 각 탭에 일정 간격 설정
                  child: Text(
                    "Stirring",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: width * 0.0093,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500), // 텍스트 크기를 18로 설정
                  ),
                ),
                Container(
                  width: width * 0.0848,
                  height: height * 0.037037,
                  // 각 탭에 일정 간격 설정
                  child: Text(
                    "Automation",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: width * 0.0093,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500), // 텍스트 크기를 18로 설정
                  ),
                ),
                Container(
                  width: width * 0.1067,
                  height: height * 0.037037,
                  // 각 탭에 일정 간격 설정
                  child: Text(
                    "Voltex & Shaking",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: width * 0.0093,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500), // 텍스트 크기를 18로 설정
                  ),
                ),
                Container(
                  width: width * 0.1005,
                  height: height * 0.037037,
                  // 각 탭에 일정 간격 설정
                  child: Text(
                    "Liquid handling",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: width * 0.0093,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500), // 텍스트 크기를 18로 설정
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _heidolphTabController,
              children: [
                _buildProductList([
                  {
                    "brand": "HEIDOLPH",
                    "name": "Hei-VAP Series",
                    "image": "assets/products/Hei-VAP_Series.png",
                    "content": """
• 5“ 터치 디스플레이의 중앙 제어 패널
• G1/G3 사선 글래스웨어의 핸드/모터 리프트 모델
• 전체 값에 대한 명확한 디스플레이(베이직 및 어드밴스 모드)
• 타이머, 최대 온도 제한, 다국어 메뉴 및 오류 메시지의 텍스트 디스플레이
• 회전 및 가열용 별도 노브와 의도하지 않은 설정변경을 방지하는 잠금 기능
• 멀리에서도 설정 조건을 표시하는 LED 링 라이트 및 픽토그램
• 외부 진공 컨트롤러에서 필요한 진공압 조절을 위한 통합 용매 라이브러리
• USB 및 마이크로 SD 인터페이스
• 증기 온도 디스플레이(옵션)
• 진공 및 냉각기 컨트롤 포함, 가능한 경우 Hei-VAP Expert Control로 차후 업그레이드
"""
                  },
                  {
                    "brand": "HEIDOLPH",
                    "name": "Hei-VAP Industrial",
                    "image": "assets/products/Hei-VAP_Industrial.png",
                    "content": """
• 고강도 투명 PMMA 도어로 탁월한 사용자 안전 보장
• 김 서림 방지 안전유리 및 금속 프레임 가드 후드가 탁월한 사용자 보호 기능 제공
• 작동 시 농축용 플라스크에 표시가 됨
• 물과 기타 수조 용액을 모두 사용할 수 있는 일반 가열 수조로, 최고 180°C까지 온도 설정 가능
• 회수 카세트 및 추가 PMMA 도어 하우징이 글래스웨어 파손 위험으로부터 보호
• 통합 재충진 용수 시스템, 넘침 방지 기능 및 하단의 배출 밸브가 스탠다드로 제공
• 옵션인 베이스 카트는 진공 펌프, 글래스웨어, 용매 혹은 부속품을 보관하는 용도로 분리가 가능한 패널로 사용 가능
• 이 모델에 대해 이용 가능한 GMP에 따른 인증: 설치 검증(IQ) 및 운영 자격인증(OQ)
• 모든 공정의 설정 조건을 포함하는 조명 디스플레이의 대형 터치 스크린 제어 패널, 프로그래밍할 수 있는 램프
                    """
                  },
                  {
                    "brand": "HEIDOLPH",
                    "name": "Automatic Distillation",
                    "image": "assets/products/Automatic_Distillation.png",
                    "content": """
• 탈부착 가능한 7“ 터치스크린 컨트롤 패널을 이용해 회전 플라스크의 센서 및 시간 제어 충진을 위한
  샘플의 설정 조건을 입력할 수 있습니다. 
• 농축물 냉각(약 1L) 코팅 콜렉터 베셀 및 압축기를 통한 회전 플라스크 잔여물 배출 시간도 프로그래밍할 수 있습니다.
• 또한 자동 세척 모드 및 수동 모드로 작동 가능합니다.
• Hei-VOLUME Distimatic 24/7의 통합 콤프레셔가 설치된 타워는 제공된  브래킷을 사용해
  Hei-VAP Industrial 시리즈 탁상형 / 대용량 농축기의 모든 부품에 바로 설치할 수 있습니다. 
• 전용 농축기 시스템과 함께 Hei-VOLUME Distimatic Pro 24/7 자동 모듈은  모든 범주의 실험에서
  효율적인 무인 가동이 가능합니다. 
• 최고 수준의 안전성과 다양한 실험을 실현하기 위해 제공되는 튜빙 등 샘플과 접촉하는 모든 부품은 
  내화학성 재료로 제작됐습니다."""
                  },
                  {
                    "brand": "HEIDOLPH",
                    "name": "Hei Chill Peltier (소형 냉각기)",
                    "image": "assets/products/Hei_Chill_Peltier.png",
                    "content": """
• Hei-CHILL Peltier Thermostat은 600와트의 높은 냉각 용량과 거의 두 배에 달하는 높은 난방 전력을 갖추고 있어
  많은 온도 제어 작업에 적합합니다.
• 온도 조절기는 다양한 인터페이스를 사용하는 Hei-PROCESS  솔루션을 통해 프로세스에 통합될 수 있습니다.
• 또한 장치는 재순환 칠러로서 Hei-VAP Expert Control 또는 Ultimate Control 회전 증발농축기를
  통해 직접 제어하거나 통합 터치 디스플레이를 통해 독립적으로 사용할 수 있습니다.
• 지속적인 부하에도 온도 안정성을 위한 6리터 탱크 부피
• 0.05 ℃ 이하의 정밀한 온도 조절 및 안정성
• 작동 온도 범위 -10 °C ~ 70 °C
• 현대식 2.83인치 터치 디스플레이
• 처리 솔루션 통합을 위한 이더넷, RS 232 및 RS 485 인터페이스
                    """
                  },
                  {
                    "brand": "HEIDOLPH",
                    "name": "Hei Chill Peltier (대형 냉각기)",
                    "image": "assets/products/Hei_Chill_5000.png",
                    "content": """
• 5,000W의 냉각 용량으로 까다로운 냉각 작업에 대해 포괄적인 범위의 냉각이 가능합니다.
• 상단에 용액 충진부, 후방에 배수 탭
• 150개 세그먼트의 통합 프로그래머, 5개 프로그램으로 분할 가능
• 전자 수위 표시기와 저수위 알람
• 자동 압축 컨트롤을 포함해 디지털식 에너지 절약형 냉각 컨트롤을 위한 SmartCool 시스템
• 명확히 배치된 제어 요소, 대형 TFT 디스플레이, 멤브레인 키패드
• USB 인터페이스와 알람 컨택트가 표준 기능으로 통합되어 있음
                    """
                  },
                ]),
                _buildProductList([
                  {
                    "brand": "HEIDOLPH",
                    "name": "Magnetic Stirrer",
                    "image": "assets/products/Magnetic_stirrer.png",
                    "content": """
• Hei-PLATE Mix ‘n’ series는 자력 교반기에서 가장 많이 사용되는 제품입니다. 
  이를 통해 사용자는 최대 1,400rpm까지 부드럽게 교반하고 최대 350°C의  온도까지 높은 정밀도로 가열할 수 있습니다. 
  또한 언제든지 제품을  사용하고 중지할 수 있는  전원버튼 및 놉에 있는 LED링은 정교하고 안전하게 사용 할수 있습니다.
  다이나믹 로터리놉은 회전 속도에 따라 설정값을 빠르게 혹은 느리게 조정 할수 있습니다. 잠금 기능은 값이 우발적으로 변경되는 것을 방지합니다.
  바로 이런 부분이 "Research madeeasy (연구가 쉬워짐)" 을 의미합니다.
• 자력 교반기는 가장 중요한 안전 기능을 갖추고 있습니다. 가열판과  제어판 사이의 안전 거리와 50°C 이상의 온도에서 시각적인 잔열 표시기가 화상을 방지합니다.
• 아노다이징 처리된 알루미늄으로 제작된 특허 받은 Kera-Disk® 풋프린트는 내화학성,  긁힘 방지 기능에 직경이 145mm입니다.
  이 유니크한 사이즈 덕분에 좁은 설치 공간에서 많은 액세서리 및 샘플과 함께 사용하기에 적합하며 제품의 재질 특성으로 빠른 가열 시간을 보장합니다.
• 마그네틱 교반기 Hei-PLATE Mix 'n' Heat Core+는 원하는 온도까지 설정할 수 있는디지털 디스플레이를 제공합니다. 오버슈팅이 없는 이 정밀한 온도는 
  두 가지 선택 가능한 가열 모드(FAST/PRECISE)와 옵션인 외부 온도 센서 Pt1000에 의해 제어됩니다."""
                  },
                  {
                    "brand": "HEIDOLPH",
                    "name": "Overhead Stirrer",
                    "image": "assets/products/Overhead_stirrer.png",
                    "content": """
• Hei-TORQUE 제품군 장치는 Heidolph 고성능 교반기입니다.
• Hei-TORQUE Ultimate 200 실험실 교반기는 점도는 최고 100,000mPas,부피는 최대 50리터(H2O)까지
  강력한 교반에 적합합니다. 넓은 속도 범위(10~2,000rpm)와 200Ncm에 달하는 최대 토크를 자랑합니다.
  뿐만 아니라, Hei-TORQUE Ultimate 200은 프로그래밍, 공정모니터링(타이머 기능, 토크 트렌드 밸류 디스플레이 포함)을 비롯해
  애플리케이션에 실시간으로 실험 상황을 모니터링하며 사용할수 있는 장비입니다.
  여기에는 USB와 RS232의 2개의 인터페이스가 장착되어 있어서, 외부장치나 PC와 연결하여 프로그램화 컨트롤러(PLC)
  또는 LabManager 등과 같은 자동화 시스템으로 연결하여 사용 할수 있습니다. 
  PC를 통한 최대 4개 장치의 원격 조정용 무료 Hei-Control 소프트웨어를 포함합니다.
• 실험실 교반기 Hei-TORQUE Ultimate 200은 최신 엔진 기술 덕분에 모든 교반 작업을 최소한의 소음으로 수행합니다. 
• 안전과 관련된 시작/정지 터치 기능은 의도하지 않은 작동의 위험을 최소화해줍니다.
• 흄 후드 내, 또는 원자로 상부구조용 드라이브로 사용하기에 적합한 HeiTORQUE Ultimate 200에는 지름 10.5mm의 
  퀵 액션 척(안전 링이 포함된 퀵척)이 있어서, 다양한 임펠라와 결합해 최상의 교반 결과를 도출할 수 있습니다."""
                  },
                ]),
                _buildProductList([
                  {
                    "brand": "HEIDOLPH",
                    "name": "Hei-Process Cloud Core",
                    "image": "assets/products/Hei-Process_Cloud_Core.png",
                    "content": """
네트워크화되고 자동화된 실험실 환경을 마련하는 것은 결코 쉬운 일이 아닙니다.
수동 작업 흐름을 완전히 자동화된 프로세스로 전환하는 것은 서로 다른 장치와 소프트웨어 간의 호환성 문제로 인해 종종 장애물에
부딪힙니다. 제한된 솔루션은 수동 개입을 필요로 하며, 작업 흐름 효율성을 방해합니다.

이러한 문제를 인식하고 지원하고자 합니다. Hei-PROCESS는 개별 실험실 장치를 원활하게 통합하고
원격으로 제어하거나 복잡한 프로세스를 완전히 자동화하는 등 고객의 요구에 맞는 맞춤형 솔루션을 제공합니다."""
                  },
                ]),
                _buildProductList([
                  {
                    "brand": "HEIDOLPH",
                    "name": "Platform shakers",
                    "image": "assets/products/Platform_shakers.png",
                    "content": """
Hei-SHAKE 시리즈의 플랫폼 셰이커를 사용하면 다양한 유형의 이동, 하중 무게 및 흔들림 및 혼합을 위한
광범위한 액세서리를 통해 가능한 수많은 응용 프로그램을 얻을 수 있습니다.
올바른 액세서리와 함께 최고 요구 사항을 충족하는 신뢰할 수 있는 플랫폼 셰이커를 가질 수 있으며,
강력한 디자인과 직관적인 작동 덕분에 실험실의 일상적인 요구 사항을 충족합니다."""
                  },
                  {
                    "brand": "HEIDOLPH",
                    "name": "Vortexer",
                    "image": "assets/products/Vortexer.png",
                    "content": """
Vortexer는 모든 실험실에서 핵심적인 역할을 합니다. 사용 편의성과 실험실 연구원으로서 얻을 수 있는 
빠른 결과에 중점을 둡니다. 고체를 용해시키기 위한 것이든, 세포 펠렛을 신선한 배지에 용해시키기 위한 것이든, 
시험관에서 개별 샘플을 단순히 혼합하기 위한 것이든, 이 도구는 항상 실험실 벤치의 한 지점을 찾습니다.

Heidolph Instruments GmbH & Co.KG에는 세 개의 다른 Voltexer가 있으므로, 매일 사용할 수 있는 것이 있습니다.
게다가, 단일 Voltexer는 다양한 액세서리로 확장될 수 있어서, 다른 샘플들이 더 쉽고 빠르게 처리될 수 있습니다."""
                  },
                  {
                    "brand": "HEIDOLPH",
                    "name": "오버헤드 쉐이커",
                    "image": "assets/products/Overhead_shakers.png",
                    "content": """
콤팩트한 오버헤드 셰이커는 다양한 용도에 적합합니다. 특히 페인트 및 바니시 기술에서
 이 도구는 색상 안료를 적절하게 분배하여 원하는 고른 결과를 얻기 위한 중요한 전제 조건을 제공합니다.
  또한 대용량 모델(Reax20)에는 모두 별도의 비상 스위치가 장착되어 있어 무거운 하중과 고회전에도 절대적인 안전성이 보장됩니다."""
                  },
                ]),
                _buildProductList([
                  {
                    "brand": "HEIDOLPH",
                    "name": "Liquid handling",
                    "image": "assets/products/Liquid_handling.png",
                    "content": """
정확한 투여는 제약, 화장품 및 식품 부문에서 특히나 중요합니다.
종합적인 공정 여건은 민감한 샘플의 안전한 운반에 전제 조건입니다.
이는 오차 범위 ±0.5%의 제어 정확성과 정밀한 속도 조절(5~120rpm)로 보장됩니다.
게다가 옵션인 풋 스위치로 폐쇄된 배기 후드에서 펌프가 작동할 수 있습니다.
속도, 회전 방향 및 온오프 기능 등의 매개 변수를 아날로그 또는 디지털 인터페이스를 통해
외부적으로 제어할 수 있습니다.

이 모델에서는, 싱글 채널 또는 멀티 채널 펌프 헤드를 선택할 수 있습니다. 
유량은 펌프 헤드에 따라 달라집니다.싱글 채널 헤드는 분당 0.38~813ml이고,
멀티 채널 헤드는 분당 0.005~364 ml입니다. 공정 중점에 따라 다음 매개 변수를 장치에서 설정할 수 있습니다.
속도, 튜빙 지름, 유량 디스플레이,계량 부피, 투여 간격 및 쉬는 시간. 
펌프는 최적의 투여 결과를 위해 조정됩니다."""
                  },
                ]),
              ],
            ),
          )
        ],
      );
    });
  }

// NORMAG 대분류 탭
  Widget _buildNormagTab() {
    return LayoutBuilder(builder: (context, constraints) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      // width와 height 모두를 고려한 반응형 조건 설정
      final isMobile = width < 600 && height < 800;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;
      return Column(
        children: [
          Container(
            padding: EdgeInsets.fromLTRB(
                isMobile ? 0 : 400, 0, isMobile ? 0 : 400, 0),
            child: Container(
              height: height * 0.0555,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _normagTabController,
              children: [
                _buildProductList([
                  {
                    "brand": "NORMAG",
                    "name": "Lab Fast Pro",
                    "image": "assets/products/Lab_Fast_Pro.png",
                    "content": """
NORMAG LAB reaction, filter, filter reactor 시스템은 별도의 도구 없이도
몇 단계 만에 시스템 완성이 가능하여 공간, 비용, 시간을 절약할수 있습니다. 
트리플 홀더 Basic과 Pro 덕분에 볼과 후드를 독립적으로 변경할수 있습니다. 
구성 요소의 선택 폭이 넓고 연결 옵션을 거의 무제한으로 선택할수 있기
때문에 customization 및 시스템 추가 확장이 쉽게 가능합니다.

Advantages
• 공간, 비용및 시간을 줄여주는 Flexible system
• 3중 홀더로 용기와 후드를 빠르고 독립적으로 변환 가능
• 기존 액세서리를 사용할수 있습니다
• CU Pro2(Control Unit)에 의한 타 실험실 기기와의 연결
• 데이터 저장 및 레시피 관리"""
                  },
                  {
                    "brand": "NORMAG",
                    "name": "Pilot Compact Reactor (10 ~ 30L)",
                    "image": "assets/products/Pilot_compact_reactor.png",
                    "content": """
  - Pilot compact reactor는 공간 활용을 극대화한 시스템입니다
  - 반응기 용량은 10~30L까지 다양하게 구성 가능
  - PFA 코팅된 flat lid로 구성
  - 안전을 위한 Pressure gauge, relief valve, burst disk 장착
  - 온도, 압력 및 각 종 센서 장착을 위한 Spare nozzle 제공
  - 시스템 세척을 위한 리프팅 기능(Option)
  - 다양한 Size의 feed vessel과 receiver vessel 구성 가능
  - Automation 사용을 위한 운영 software 구성 가능(Option) 
  - GMP Documents(IQ/OQ/DQ) 제공(Option)
  - 합리적인 가격"""
                  },
                  {
                    "brand": "NORMAG",
                    "name": "Glass Reaction System",
                    "image": "assets/products/ReactionSystemPilot.png",
                    "content": """
  - NORMAG의 Glass reaction system은 이중 자켓(100L), 삼중관 자켓(50L)까지 구성 가능
  - 특수설계된 Stainless steel의 프레임워크
  - 고객의 요청에 따른 설계 및 제작 가능
  - 안전을 위한 Pressure gauge, relief valve, burst disk 장착
  - pH-센서, 레벨-센서, 전도도-센서 및 기타 모든 옵션 사용 가능
  - 유니크한 Bottom drain valve
  - Automation을 위한 PLC 구성 가능(Option) 
  - GMP Documents(IQ/OQ/DQ) 제공(Option)
  - 합리적인 가격                    
                    """
                  },
                ]),
              ],
            ),
          )
        ],
      );
    });
  }

  // CINC Industry 대분류 탭 (업데이트 예정)
  Widget _buildCINCTab() {
    return LayoutBuilder(builder: (context, constraints) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      // width와 height 모두를 고려한 반응형 조건 설정
      final isMobile = width < 600 && height < 800;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;

      return Column(
        children: [
          Container(
            width: width * 0.471875,
            child: TabBar(
              controller: _cincTabController,
              labelColor: Colors.black,
              indicatorColor: Color(0xff6194f9),
              dividerColor: Colors.transparent,
              unselectedLabelStyle: TextStyle(
                  fontSize: width * 0.0093,
                  fontFamily: 'Pretendard',
                  fontWeight: FontWeight.w500,
                  color: Colors.black),
              tabs: [
                Container(
                  width: width * 0.0875,
                  height: height * 0.037037,
                  // 각 탭에 일정 간격 설정
                  child: Text(
                    "Introduction",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: width * 0.0093,
                      fontFamily: 'Pretendard',
                      fontWeight: FontWeight.w500,
                    ), // 텍스트 크기를 18로 설정
                  ),
                ),
                Container(
                  width: width * 0.0901,
                  height: height * 0.037037,
                  // 각 탭에 일정 간격 설정
                  child: Text(
                    "How to Work",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: width * 0.0093,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500), // 텍스트 크기를 18로 설정
                  ),
                ),
                Container(
                  width: width * 0.1005,
                  height: height * 0.037037,
                  // 각 탭에 일정 간격 설정
                  child: Text(
                    "Characteristics",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: width * 0.0093,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500), // 텍스트 크기를 18로 설정
                  ),
                ),
                Container(
                  width: width * 0.0838,
                  height: height * 0.037037,
                  // 각 탭에 일정 간격 설정
                  child: Text(
                    "Application",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: width * 0.0093,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500), // 텍스트 크기를 18로 설정
                  ),
                ),
                Container(
                  width: width * 0.0958,
                  height: height * 0.037037,
                  // 각 탭에 일정 간격 설정
                  child: Text(
                    "Specifications",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: width * 0.0093,
                        fontFamily: 'Pretendard',
                        fontWeight: FontWeight.w500), // 텍스트 크기를 18로 설정
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _cincTabController,
              children: [
                Container(
                  height: height * 1.301,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.0435,
                      ),
                      Text(
                        'INTRODUCTION',
                        style: TextStyle(
                          color: Color(0xFF6194F9),
                          fontSize: width * 0.0104,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.0240,
                      ),
                      Text(
                        'CINC lndustry 소개',
                        style: TextStyle(
                          color: Color(0xFF191919),
                          fontSize: width * 0.02083,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.07870,
                      ),
                      Container(
                        width: width * 0.1505,
                        height: height * 0.44166,
                        child: Image.asset(
                          "assets/products/Cinc_Industry_Product.png",
                          fit: BoxFit.fitHeight,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.0370,
                      ),
                      Container(
                        width: width * 0.40416,
                        child: SelectableText.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: 'CINC는 액체-액체 원심분리기를 설계, 제조 및 공급하는 기업',
                                style: TextStyle(
                                    color: Color(0xFF191919),
                                    fontSize: width * 0.01041,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w500,
                                    height: height * 0.0018),
                              ),
                              TextSpan(
                                text:
                                    '으로, 전 세계의 석유, 화학, 광업,\n제약, 식품, 향료, 인쇄 및 환경 산업 분야의 연구를 수행하는 고객들의 신뢰를 받고 있습니다.\n'
                                    'CINC 원심분리기는 조정 가능한 중(重)상 위어(weir)와 가변 속도 모터를 통해  특정 중력 차이에\n따른 다양한 요구에 유연하게 대응할 수 있으며,자가 흡입 설계로 펌프 또는 중력 공급이 가능해\n'
                                    '유량 변화에도 안정적인 성능을 제공합니다.\n또한 모든 제품은 사내에서 설계, 제조 및 철저한 테스트를 거쳐 최고의 품질을 보장합니다.\nISO 9000 및 NAQ-1 기준을 준수하며, cGMP 및 FED 표준에 따라 원심분리기를 제조하고,CE 및\n'
                                    'PED 지침, ATEX 100 인증을 보유하고 있습니다. 연구개발부터 대량 생산 규모에 이르기까지 다양한 크기로 제공되며, 다양한 산업의 요구를 충족시키기 위해 끊임없이 발전하고 있습니다',
                                style: TextStyle(
                                    color: Color(0xFF5C5C5C),
                                    fontSize: width * 0.01041,
                                    fontFamily: 'Pretendard',
                                    fontWeight: FontWeight.w400,
                                    height: height * 0.0018),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: height * 1.301,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.0435,
                      ),
                      Text(
                        'HOW TO WORK',
                        style: TextStyle(
                          color: Color(0xFF6194F9),
                          fontSize: width * 0.0104,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.0240,
                      ),
                      Text(
                        'CINC lndustry 작동원리',
                        style: TextStyle(
                          color: Color(0xFF191919),
                          fontSize: width * 0.02083,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.07870,
                      ),
                      Container(
                        width: width * 0.63,
                        height: height * 0.5,
                        child: Row(
                          children: [
                            Container(
                              height: height * 0.5,
                              child: Image.asset("assets/how_to_work.png",
                                  fit: BoxFit.contain),
                            ),
                            SizedBox(
                              width: width * 0.025,
                            ),
                            Container(
                              height: height * 0.5,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: width * 0.0580,
                                    height: height * 0.0277,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * 0.01661),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF6194F9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(59.81),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SelectableText.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '01',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  fontSize: width * 0.008,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.15,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' 작동원리',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.008,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      Transform.translate(
                                        offset: Offset(0, -height * 0.0018),
                                        child: Container(
                                          width: width * 0.356,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
                                                color: Color(0xFF6194F9),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0060,
                                  ),
                                  SelectableText(
                                    '회전하는 로터 내에서 발생하는 원심력을 이용하여 서로 다른 밀도의 두 액체를 분리합니다.',
                                    style: TextStyle(
                                      color: Color(0xFF414141),
                                      fontSize: width * 0.0104,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: height * 0.0018,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.0150,
                                  ),
                                  Container(
                                    width: width * 0.0591,
                                    height: height * 0.0277,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * 0.01661),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF6194F9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(59.81),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SelectableText.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '02',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  fontSize: width * 0.008,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.15,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' 입력방식',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.008,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      Transform.translate(
                                        offset: Offset(0, -height * 0.0018),
                                        child: Container(
                                          width: width * 0.356,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
                                                color: Color(0xFF6194F9),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0060,
                                  ),
                                  SelectableText(
                                    '혼합된 액체가 양쪽 입구로 들어오거나, 각각의 액체가 독립적으로 유입됩니다.',
                                    style: TextStyle(
                                      color: Color(0xFF414141),
                                      fontSize: width * 0.0104,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: height * 0.0018,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.0150,
                                  ),
                                  Container(
                                    width: width * 0.0455,
                                    height: height * 0.0277,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * 0.01661),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF6194F9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(59.81),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SelectableText.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '03',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  fontSize: width * 0.008,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.15,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' 혼합',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.008,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      Transform.translate(
                                        offset: Offset(0, -height * 0.0018),
                                        child: Container(
                                          width: width * 0.356,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
                                                color: Color(0xFF6194F9),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0060,
                                  ),
                                  SelectableText(
                                    '로터와 하우징 사이에서 액체가 혼합되고(초록색), 로터 하단을 통해 유입됩니다.',
                                    style: TextStyle(
                                      color: Color(0xFF414141),
                                      fontSize: width * 0.0104,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: height * 0.0018,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.0150,
                                  ),
                                  Container(
                                    width: width * 0.0594,
                                    height: height * 0.0277,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * 0.01661),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF6194F9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(59.81),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SelectableText.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '04',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  fontSize: width * 0.008,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.15,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' 분리과정',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.008,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      Transform.translate(
                                        offset: Offset(0, -height * 0.0018),
                                        child: Container(
                                          width: width * 0.356,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
                                                color: Color(0xFF6194F9),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0060,
                                  ),
                                  SelectableText(
                                    '밀도가 높은 액체(파란색): 로터 바깥쪽으로 밀려나가 높은 단계의 출구로 배출됩니다.\n밀도가 낮은 액체(노란색): 로터 중심으로 이동해 낮은 단계의 출구로 배출됩니다.',
                                    style: TextStyle(
                                      color: Color(0xFF414141),
                                      fontSize: width * 0.0104,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: height * 0.0010,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.0150,
                                  ),
                                  Container(
                                    width: width * 0.0455,
                                    height: height * 0.0277,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: height * 0.01661),
                                    decoration: ShapeDecoration(
                                      color: Color(0xFF6194F9),
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(59.81),
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        SelectableText.rich(
                                          TextSpan(
                                            children: [
                                              TextSpan(
                                                text: '05',
                                                style: TextStyle(
                                                  color: Colors.white
                                                      .withOpacity(0.5),
                                                  fontSize: width * 0.008,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.15,
                                                ),
                                              ),
                                              TextSpan(
                                                text: ' 수집',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: width * 0.008,
                                                  fontFamily: 'Pretendard',
                                                  fontWeight: FontWeight.w600,
                                                  height: 0.15,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: width * 0.01,
                                      ),
                                      Transform.translate(
                                        offset: Offset(0, -height * 0.0018),
                                        child: Container(
                                          width: width * 0.356,
                                          decoration: ShapeDecoration(
                                            shape: RoundedRectangleBorder(
                                              side: BorderSide(
                                                width: 1,
                                                strokeAlign: BorderSide
                                                    .strokeAlignCenter,
                                                color: Color(0xFF6194F9),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0074,
                                  ),
                                  SelectableText(
                                    '각각의 액체는 다른 수집 링에 모여 분리된 출구로 배출됩니다.',
                                    style: TextStyle(
                                      color: Color(0xFF414141),
                                      fontSize: width * 0.0104,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w500,
                                      height: height * 0.0018,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: height * 1.301,
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.0435,
                      ),
                      Text(
                        'CHARACTERISTICS',
                        style: TextStyle(
                          color: Color(0xFF6194F9),
                          fontSize: width * 0.0104,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.0240,
                      ),
                      Text(
                        'CINC lndustry 작동원리',
                        style: TextStyle(
                          color: Color(0xFF191919),
                          fontSize: width * 0.02083,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.07870,
                      ),
                      Container(
                        width: width * 0.63,
                        height: height * 0.5888,
                        child: Row(
                          children: [
                            SizedBox(
                              width: width * 0.02,
                            ),
                            Container(
                              height: height * 0.5888,
                              color: Colors.white,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Why Choose CINC?',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: Color(0xFF191919),
                                      fontSize: width * 0.015,
                                      fontFamily: 'Pretendard',
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Container(
                                      width: width * 0.376,
                                      height: height * 0.003,
                                      decoration: BoxDecoration(
                                          color: Color(0xFF6194F9))),
                                  SizedBox(height: height * 0.0296),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: width * 0.015,
                                          height: height * 0.0277,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF191919),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(3)),
                                          ),
                                          child: Text(
                                            '01',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0083,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,

                                            ),
                                          )),
                                      SizedBox(width: width * 0.009),
                                      SelectableText(
                                        '분당 0.5~200gallons (1.9~757L)의 유량 처리 가능',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.009,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.0037),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: width * 0.024),
                                      DottedBorder(
                                        color: Color(0x7F6194F9), // 점선 색상
                                        strokeWidth: 1, // 선 두께
                                        dashPattern: [6, 3], // 점선 패턴 (길이, 간격)
                                        borderType: BorderType.RRect, // 둥근 사각형 테두리
                                        radius: Radius.circular(8), // 둥근 모서리 반경 (선택 사항)
                                        padding: EdgeInsets.all(0), // 패딩 (선택 사항)
                                        child: Container(
                                          width: width * 0.3530,
                                          // 기타 자식 위젯 속성 추가 가능
                                        ),
                                      )

                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: width * 0.015,
                                          height: height * 0.0277,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF191919),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(3)),
                                          ),
                                          child: Text(
                                            '02',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0083,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,

                                            ),
                                          )),
                                      SizedBox(width: width * 0.009),
                                      SelectableText(
                                        '용매, 세척액 등을 투입 할 수 있는 2개의 입구 설계',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.009,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.0037),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: width * 0.024),
                                      DottedBorder(
                                        color: Color(0x7F6194F9), // 점선 색상
                                        strokeWidth: 1, // 선 두께
                                        dashPattern: [6, 3], // 점선 패턴 (길이, 간격)
                                        borderType: BorderType.RRect, // 둥근 사각형 테두리
                                        radius: Radius.circular(8), // 둥근 모서리 반경 (선택 사항)
                                        padding: EdgeInsets.all(0), // 패딩 (선택 사항)
                                        child: Container(
                                          width: width * 0.3530,
                                          // 기타 자식 위젯 속성 추가 가능
                                        ),
                                      )

                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: width * 0.015,
                                          height: height * 0.0277,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF191919),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(3)),
                                          ),
                                          child: Text(
                                            '03',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0083,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,

                                            ),
                                          )),
                                      SizedBox(width: width * 0.009),
                                      SelectableText(
                                        '200~1,000g의 원심력만으로도 효율적인 분리 및 추출',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.009,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.0037),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: width * 0.024),
                                      DottedBorder(
                                        color: Color(0x7F6194F9), // 점선 색상
                                        strokeWidth: 1, // 선 두께
                                        dashPattern: [6, 3], // 점선 패턴 (길이, 간격)
                                        borderType: BorderType.RRect, // 둥근 사각형 테두리
                                        radius: Radius.circular(8), // 둥근 모서리 반경 (선택 사항)
                                        padding: EdgeInsets.all(0), // 패딩 (선택 사항)
                                        child: Container(
                                          width: width * 0.3530,
                                          // 기타 자식 위젯 속성 추가 가능
                                        ),
                                      )

                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: width * 0.015,
                                          height: height * 0.0277,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF191919),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(3)),
                                          ),
                                          child: Text(
                                            '04',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0083,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,

                                            ),
                                          )),
                                      SizedBox(width: width * 0.009),
                                      SelectableText(
                                        '전단에 민감한 유체를 위한 저혼잡 및 직접 투입 옵션 제공',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.009,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.0037),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: width * 0.024),
                                      DottedBorder(
                                        color: Color(0x7F6194F9), // 점선 색상
                                        strokeWidth: 1, // 선 두께
                                        dashPattern: [6, 3], // 점선 패턴 (길이, 간격)
                                        borderType: BorderType.RRect, // 둥근 사각형 테두리
                                        radius: Radius.circular(8), // 둥근 모서리 반경 (선택 사항)
                                        padding: EdgeInsets.all(0), // 패딩 (선택 사항)
                                        child: Container(
                                          width: width * 0.3530,
                                          // 기타 자식 위젯 속성 추가 가능
                                        ),
                                      )

                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: width * 0.015,
                                          height: height * 0.0277,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF191919),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(3)),
                                          ),
                                          child: Text(
                                            '05',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0083,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,

                                            ),
                                          )),
                                      SizedBox(width: width * 0.009),
                                      SelectableText(
                                        '중량 차이를 처리할 수 있는 조절 가능한 중상위어와 가변 속도 모터, 펌프식 및 중력식 모두 대응',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.009,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.0037),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: width * 0.024),
                                      DottedBorder(
                                        color: Color(0x7F6194F9), // 점선 색상
                                        strokeWidth: 1, // 선 두께
                                        dashPattern: [6, 3], // 점선 패턴 (길이, 간격)
                                        borderType: BorderType.RRect, // 둥근 사각형 테두리
                                        radius: Radius.circular(8), // 둥근 모서리 반경 (선택 사항)
                                        padding: EdgeInsets.all(0), // 패딩 (선택 사항)
                                        child: Container(
                                          width: width * 0.3530,
                                          // 기타 자식 위젯 속성 추가 가능
                                        ),
                                      )

                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: width * 0.015,
                                          height: height * 0.0277,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF191919),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(3)),
                                          ),
                                          child: Text(
                                            '06',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0083,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,

                                            ),
                                          )),
                                      SizedBox(width: width * 0.009),
                                      SelectableText(
                                        '투입 비율의 변화에 자동으로 적응, 별도의 조정 불필요',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.009,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.0037),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: width * 0.024),
                                      DottedBorder(
                                        color: Color(0x7F6194F9), // 점선 색상
                                        strokeWidth: 1, // 선 두께
                                        dashPattern: [6, 3], // 점선 패턴 (길이, 간격)
                                        borderType: BorderType.RRect, // 둥근 사각형 테두리
                                        radius: Radius.circular(8), // 둥근 모서리 반경 (선택 사항)
                                        padding: EdgeInsets.all(0), // 패딩 (선택 사항)
                                        child: Container(
                                          width: width * 0.3530,
                                          // 기타 자식 위젯 속성 추가 가능
                                        ),
                                      )

                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: width * 0.015,
                                          height: height * 0.0277,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF191919),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(3)),
                                          ),
                                          child: Text(
                                            '07',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0083,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,

                                            ),
                                          )),
                                      SizedBox(width: width * 0.009),
                                      SelectableText(
                                        '다양한 유량과 유령 중단을 자동으로 제어',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.009,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.0037),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: width * 0.024),
                                      DottedBorder(
                                        color: Color(0x7F6194F9), // 점선 색상
                                        strokeWidth: 1, // 선 두께
                                        dashPattern: [6, 3], // 점선 패턴 (길이, 간격)
                                        borderType: BorderType.RRect, // 둥근 사각형 테두리
                                        radius: Radius.circular(8), // 둥근 모서리 반경 (선택 사항)
                                        padding: EdgeInsets.all(0), // 패딩 (선택 사항)
                                        child: Container(
                                          width: width * 0.3530,
                                          // 기타 자식 위젯 속성 추가 가능
                                        ),
                                      )

                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: width * 0.015,
                                          height: height * 0.0277,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF191919),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(3)),
                                          ),
                                          child: Text(
                                            '08',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0083,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,

                                            ),
                                          )),
                                      SizedBox(width: width * 0.009),
                                      SelectableText(
                                        '냉동 온도부터 끓는 온도까지 다양한 투입 온도 처리 가능',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.009,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.0037),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: width * 0.024),
                                      DottedBorder(
                                        color: Color(0x7F6194F9), // 점선 색상
                                        strokeWidth: 1, // 선 두께
                                        dashPattern: [6, 3], // 점선 패턴 (길이, 간격)
                                        borderType: BorderType.RRect, // 둥근 사각형 테두리
                                        radius: Radius.circular(8), // 둥근 모서리 반경 (선택 사항)
                                        padding: EdgeInsets.all(0), // 패딩 (선택 사항)
                                        child: Container(
                                          width: width * 0.3530,
                                          // 기타 자식 위젯 속성 추가 가능
                                        ),
                                      )

                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: width * 0.015,
                                          height: height * 0.0277,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF191919),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(3)),
                                          ),
                                          child: Text(
                                            '09',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0083,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,

                                            ),
                                          )),
                                      SizedBox(width: width * 0.009),
                                      SelectableText(
                                        '내구성 높은 스테인리스 스틸 구조, 부식 방지 합금도 선택 가능',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.009,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.0037),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: width * 0.024),
                                      DottedBorder(
                                        color: Color(0x7F6194F9), // 점선 색상
                                        strokeWidth: 1, // 선 두께
                                        dashPattern: [6, 3], // 점선 패턴 (길이, 간격)
                                        borderType: BorderType.RRect, // 둥근 사각형 테두리
                                        radius: Radius.circular(8), // 둥근 모서리 반경 (선택 사항)
                                        padding: EdgeInsets.all(0), // 패딩 (선택 사항)
                                        child: Container(
                                          width: width * 0.3530,
                                          // 기타 자식 위젯 속성 추가 가능
                                        ),
                                      )

                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: width * 0.015,
                                          height: height * 0.0277,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF191919),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(3)),
                                          ),
                                          child: Text(
                                            '10',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0083,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,

                                            ),
                                          )),
                                      SizedBox(width: width * 0.009),
                                      SelectableText(
                                        '유지보수가 적고 신뢰성이 높은 제자리 세척(CIP) 로터 시스템',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.009,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.0037),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: width * 0.024),
                                      DottedBorder(
                                        color: Color(0x7F6194F9), // 점선 색상
                                        strokeWidth: 1, // 선 두께
                                        dashPattern: [6, 3], // 점선 패턴 (길이, 간격)
                                        borderType: BorderType.RRect, // 둥근 사각형 테두리
                                        radius: Radius.circular(8), // 둥근 모서리 반경 (선택 사항)
                                        padding: EdgeInsets.all(0), // 패딩 (선택 사항)
                                        child: Container(
                                          width: width * 0.3530,
                                          // 기타 자식 위젯 속성 추가 가능
                                        ),
                                      )

                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: width * 0.015,
                                          height: height * 0.0277,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF191919),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(3)),
                                          ),
                                          child: Text(
                                            '11',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0083,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,

                                            ),
                                          )),
                                      SizedBox(width: width * 0.009),
                                      SelectableText(
                                        '하나의 움직이는 부품만 있는 간단한 직접 구동 방식으로 안정성 강화',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.009,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.0037),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: width * 0.024),
                                      DottedBorder(
                                        color: Color(0x7F6194F9), // 점선 색상
                                        strokeWidth: 1, // 선 두께
                                        dashPattern: [6, 3], // 점선 패턴 (길이, 간격)
                                        borderType: BorderType.RRect, // 둥근 사각형 테두리
                                        radius: Radius.circular(8), // 둥근 모서리 반경 (선택 사항)
                                        padding: EdgeInsets.all(0), // 패딩 (선택 사항)
                                        child: Container(
                                          width: width * 0.3530,
                                          // 기타 자식 위젯 속성 추가 가능
                                        ),
                                      )

                                    ],
                                  ),
                                  SizedBox(height: height * 0.01),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: width * 0.015,
                                          height: height * 0.0277,
                                          decoration: ShapeDecoration(
                                            color: Color(0xFF191919),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(3)),
                                          ),
                                          child: Text(
                                            '12',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.0083,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w600,

                                            ),
                                          )),
                                      SizedBox(width: width * 0.009),
                                      SelectableText(
                                        '조용한 작동과 유연한 구성을 위한 직접 구동 패키지',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.009,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      )
                                    ],
                                  ),
                                  SizedBox(height: height * 0.0037),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(width: width * 0.024),
                                      DottedBorder(
                                        color: Color(0x7F6194F9), // 점선 색상
                                        strokeWidth: 1, // 선 두께
                                        dashPattern: [6, 3], // 점선 패턴 (길이, 간격)
                                        borderType: BorderType.RRect, // 둥근 사각형 테두리
                                        radius: Radius.circular(8), // 둥근 모서리 반경 (선택 사항)
                                        padding: EdgeInsets.all(0), // 패딩 (선택 사항)
                                        child: Container(
                                          width: width * 0.3530,
                                          // 기타 자식 위젯 속성 추가 가능
                                        ),
                                      )

                                    ],
                                  ),

                                ],
                              ),
                            ),
                            Container(
                              width: width * 0.1947,
                              height: height * 0.5888,
                              child: Image.asset(
                                "assets/products/Cinc_Industry_Product.png",
                                fit: BoxFit.fill,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  height: height * 1.301,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.0435,
                      ),
                      Text(
                        'Application',
                        style: TextStyle(
                          color: Color(0xFF6194F9),
                          fontSize: width * 0.0104,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.0240,
                      ),
                      Text(
                        'CINC lndustry 응용',
                        style: TextStyle(
                          color: Color(0xFF191919),
                          fontSize: width * 0.02083,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.0824,
                      ),
                      Container(
                        height: height * 0.3686,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width * 0.14895,
                              height: height * 0.3686,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x33000000),
                                    blurRadius: 14,
                                    offset: Offset(1, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      width: width * 0.14895,
                                      height: height * 0.1085,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          // 상단 왼쪽 모서리만 둥글게
                                          topRight: Radius.circular(
                                              8), // 상단 오른쪽 모서리만 둥글게
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('assets/app01.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * 0.0092,
                                          ),
                                          Text(
                                            'Chemical',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.009,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '폴리머 원료 공급', //first
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //2
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '폴리머 생산',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //3
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '부타디엔 및 스티렌 수지',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ),
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '유기 과산화물',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ),
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '공비 분리',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ),
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '용매 회수',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ),
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '열전달 유체 회수',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ),
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '유기물 세정',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.0098,
                            ),
                            Container(
                              width: width * 0.14895,
                              height: height * 0.3686,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x33000000),
                                    blurRadius: 14,
                                    offset: Offset(1, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      width: width * 0.14895,
                                      height: height * 0.1085,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          // 상단 왼쪽 모서리만 둥글게
                                          topRight: Radius.circular(
                                              8), // 상단 오른쪽 모서리만 둥글게
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('assets/app02.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * 0.0092,
                                          ),
                                          Text(
                                            'Pharmaceutical',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.009,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '항생제', //first
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //2
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '에리스로마이신',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //3
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '폴리머 원료 공급',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ),
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '페니실린',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.0098,
                            ),
                            Container(
                              width: width * 0.14895,
                              height: height * 0.3686,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x33000000),
                                    blurRadius: 14,
                                    offset: Offset(1, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      width: width * 0.14895,
                                      height: height * 0.1085,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          // 상단 왼쪽 모서리만 둥글게
                                          topRight: Radius.circular(
                                              8), // 상단 오른쪽 모서리만 둥글게
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('assets/app03.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * 0.0092,
                                          ),
                                          Text(
                                            'Petroleum',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.009,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '산류 회수', //first
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //2
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '유정 완성 유체 회수',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //3
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '생산수 처리',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ),
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '오일 탈수',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ),
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '육상 및 해상(FPSO 및 고정 플랫폼)',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.0098,
                            ),
                            Container(
                              width: width * 0.14895,
                              height: height * 0.3686,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x33000000),
                                    blurRadius: 14,
                                    offset: Offset(1, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      width: width * 0.14895,
                                      height: height * 0.1085,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          // 상단 왼쪽 모서리만 둥글게
                                          topRight: Radius.circular(
                                              8), // 상단 오른쪽 모서리만 둥글게
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('assets/app04.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * 0.0092,
                                          ),
                                          Text(
                                            'Biotech',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.009,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '재조합 DNA 제품', //first
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //2
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '배양액 추출',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
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
                      SizedBox(height: height * 0.04630),
                      Container(
                        height: height * 0.3686,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: width * 0.14895,
                              height: height * 0.3686,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x33000000),
                                    blurRadius: 14,
                                    offset: Offset(1, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      width: width * 0.14895,
                                      height: height * 0.1085,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          // 상단 왼쪽 모서리만 둥글게
                                          topRight: Radius.circular(
                                              8), // 상단 오른쪽 모서리만 둥글게
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('assets/app05.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * 0.0092,
                                          ),
                                          Text(
                                            'Environmental',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.009,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '유류 유출 정화', //first
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //2
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '지하수 복원',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //3
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '세척수 재활용',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ),
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '빌지수 처리',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ),
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '산업 세탁수 탈유',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.0098,
                            ),
                            Container(
                              width: width * 0.14895,
                              height: height * 0.3686,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x33000000),
                                    blurRadius: 14,
                                    offset: Offset(1, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      width: width * 0.14895,
                                      height: height * 0.1085,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          // 상단 왼쪽 모서리만 둥글게
                                          topRight: Radius.circular(
                                              8), // 상단 오른쪽 모서리만 둥글게
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('assets/app06.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * 0.0092,
                                          ),
                                          Text(
                                            'Mining and Metals Recovery',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.009,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '다양한 금속의 용매 추출', //first
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //2
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '용매 회수 및 재활용',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //3
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '폐수 분리',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.0098,
                            ),
                            Container(
                              width: width * 0.14895,
                              height: height * 0.3686,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x33000000),
                                    blurRadius: 14,
                                    offset: Offset(1, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      width: width * 0.14895,
                                      height: height * 0.1085,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          // 상단 왼쪽 모서리만 둥글게
                                          topRight: Radius.circular(
                                              8), // 상단 오른쪽 모서리만 둥글게
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('assets/app07.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * 0.0092,
                                          ),
                                          Text(
                                            'Food & Nutrition',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.009,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '이소플라본', //first
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //2
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '식용유',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //3
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '항료 추출',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ),
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '영양 보충제',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: width * 0.0098,
                            ),
                            Container(
                              width: width * 0.14895,
                              height: height * 0.3686,
                              decoration: ShapeDecoration(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8)),
                                shadows: [
                                  BoxShadow(
                                    color: Color(0x33000000),
                                    blurRadius: 14,
                                    offset: Offset(1, 2),
                                    spreadRadius: 0,
                                  )
                                ],
                              ),
                              child: Column(
                                children: [
                                  Container(
                                      width: width * 0.14895,
                                      height: height * 0.1085,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(8),
                                          // 상단 왼쪽 모서리만 둥글게
                                          topRight: Radius.circular(
                                              8), // 상단 오른쪽 모서리만 둥글게
                                        ),
                                        image: DecorationImage(
                                          image: AssetImage('assets/app08.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: height * 0.0092,
                                          ),
                                          Text(
                                            'Biodisel Production',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: width * 0.009,
                                              fontFamily: 'Pretendard',
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )),
                                  SizedBox(
                                    height: height * 0.01,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '메틸 에스터에서 글리세린 추출', //first
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //2
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '바이오디젤 수세',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ), //3
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '조류 세포 농축',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: height * 0.0015,
                                  ),
                                  Opacity(
                                    opacity: 0.10,
                                    child: Container(
                                      width: width * 0.1286,
                                      decoration: ShapeDecoration(
                                        shape: RoundedRectangleBorder(
                                          side: BorderSide(
                                            width: 0.5,
                                            strokeAlign:
                                                BorderSide.strokeAlignCenter,
                                            color: Color(0xFF191919),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: height * 0.008,
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: width * 0.0130,
                                      ),
                                      Container(
                                        width: width * 0.0020,
                                        height: height * 0.0037,
                                        decoration: ShapeDecoration(
                                          color: Color(0xFF6194F9),
                                          shape: OvalBorder(),
                                        ),
                                      ),
                                      SizedBox(
                                        width: width * 0.0083,
                                      ),
                                      SelectableText(
                                        '메틸 에스터에서 글리세린 분리',
                                        style: TextStyle(
                                          color: Color(0xFF414141),
                                          fontSize: width * 0.0083,
                                          fontFamily: 'Pretendard',
                                          fontWeight: FontWeight.w500,
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
                    ],
                  ),
                ),
                Container(
                  height: height * 1.301,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: height * 0.0435,
                      ),
                      Text(
                        'SPECIFICATIONS',
                        style: TextStyle(
                          color: Color(0xFF6194F9),
                          fontSize: width * 0.0104,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.0240,
                      ),
                      Text(
                        'CINC lndustry 특성',
                        style: TextStyle(
                          color: Color(0xFF191919),
                          fontSize: width * 0.02083,
                          fontFamily: 'Pretendard',
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.07870,
                      ),
                      Container(
                          width: width * 0.625,
                          height: height * 0.81574,
                          child: Image.asset('assets/table.png',
                              fit: BoxFit.contain))
                    ],
                  ),
                ),

              ],
            ),
          ),
        ],
      );
    });
  }

  // Sub TabBar for Products
  Widget _buildSubTabBar(List<String> tabNames) {
    return TabBar(
      isScrollable: true,
      tabs: tabNames.map((name) => Tab(text: name)).toList(),
    );
  }

  // Product List Builder
  Widget _buildProductList(List<Map<String, String>> products) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      // width와 height 모두를 고려한 반응형 조건 설정
      final isMobile = width < 600 && height < 800;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;

      return Center(
          child: GridView.builder(
        padding: EdgeInsets.only(left: width * 0.1041, right: width * 0.1041),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // 한 줄에 3개씩 배치
          crossAxisSpacing: 0, // 좌우 간격 줄이기
          mainAxisSpacing: 0.0, // 상하 간격 줄이기
          childAspectRatio: 0.75, // 아이템 비율 (세로로 길게)
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          return buildProductCard(
              products[index]["brand"]!,
              products[index]["name"]!,
              products[index]["image"]!,
              products[index]["content"]!,
              context,
              271,
              337,
              index);
        },
      ));
    });
  }

  Widget _buildTabButton(String title, int index) {
    return LayoutBuilder(builder: (context, constraints) {
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      // width와 height 모두를 고려한 반응형 조건 설정
      final isMobile = width < 600 && height < 800;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;
      return Container(
        // color:  Color(0xffd4e2f5).withOpacity(0.9),// TabBar 배경색 설정
        color: _selectedTabIndex == index
            ? Colors.white.withOpacity(0.6000000238418579)
            : Colors.black.withOpacity(0.5),
        width: width * 0.1166,
        height: height * 0.060,
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
                fontSize: width * 0.0104,
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
        return _buildHeidolphTab();
      case 1:
        return _buildNormagTab();
      case 2:
        return _buildCINCTab();
      default:
        return Container();
    }
  }

  Widget buildApplicationTextList(String main, String content) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;
    return Column(
      children: [
        Container(
          width: 300,
          height: height * 0.04629,
          decoration: BoxDecoration(
              color: Colors.black, // 배경 색상
              border: Border.all(
                color: Colors.grey, // 테두리 색상
                width: 1.0, // 테두리 두께
              ),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              )),
          padding: EdgeInsets.symmetric(vertical: 8),
          child: Text(
            main,
            style: TextStyle(
              fontSize: width * 0.0104,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: width * 0.1562,
          height: height * 0.2314,
          decoration: BoxDecoration(
              color: Colors.white, // 배경 색상
              border: Border.all(
                color: Colors.grey, // 테두리 색상
                width: 1.0, // 테두리 두께
              ),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10),
              )),
          child: Text(
            content,
            style: TextStyle(fontSize: width * 0.0083, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // Product Card Widget
  Widget buildProductCard(
      String brand,
      String name,
      String imagePath,
      String content,
      BuildContext context,
      double cardWidth,
      double cardHeight,
      int index) {
    return LayoutBuilder(builder: (context, constraints) {
      // width와 height 모두를 고려한 반응형 조건 설정
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;

      return MouseRegion(
        onEnter: (_) {
          setState(() {
            _isHovered[index] = true; // 마우스가 위에 있을 때 true로 설정
          });
        },
        onExit: (_) {
          setState(() {
            _isHovered[index] = false; // 마우스가 나갔을 때 false로 설정
          });
        },
        child: Column(
          children: [
            SizedBox(
              height: height * 0.0925,
            ),
            Container(
                width: width * 0.2432,
                height: height * 0.4851,
                decoration: _isHovered[index] == true
                    ? BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8), // 테두리 둥글기
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1), // 그림자 색상과 투명도
                            spreadRadius: 2, // 그림자의 퍼짐 정도
                            blurRadius: 20, // 그림자의 흐림 정도
                            offset: Offset(0, 0), // 그림자의 위치 (x, y)
                          ),
                        ],
                      )
                    : BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(
                          Radius.circular(8),
                        )),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  // 텍스트를 이미지 중앙 정렬
                  children: [
                    Container(
                      child: GestureDetector(
                          onTap: () {
                            // 제품 클릭 시 이름과 이미지 설정

                            setState(() {
                              _selectedName = name;
                              _selectedImage = imagePath;
                              _selectedContent = content;
                              _dialogBuilder(context, name, imagePath, content);
                            });
                          },
                          child: Column(
                            children: [
                              SizedBox(
                                height: height * 0.0400,
                              ),
                              Image.asset(
                                imagePath,
                                fit: BoxFit.contain,
                                width: width * 0.14114,
                                height: height * 0.3120,
                              ),
                              SizedBox(
                                height: height * 0.0400,
                              ),
                              Container(
                                width: width * 0.0494,
                                height: height * 0.0194,
                                child: Text(
                                  brand,
                                  style: TextStyle(
                                      fontSize: width * 0.009,
                                      fontFamily: 'Pretendard',
                                      color: Color(0xff6194f9),
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                              SizedBox(
                                height: height * 0.0050,
                              ),
                              Container(
                                height: height * 0.0500,
                                child: Text(
                                  name,
                                  style: TextStyle(
                                      fontSize: width * 0.0125,
                                      fontFamily: 'Pretendard',
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500),
                                ),
                              ),
                            ],
                          )),
                    ),
                  ],
                ))
          ],
        ),
      );
    });
  }

  Future<void> _dialogBuilder(
      BuildContext context, String name, String image, String content) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final size = MediaQuery.of(context).size;
            final width = size.width;
            final height = size.height;

            // 반응형 설정
            final isMobile = width < 600;
            final isTablet = width >= 600 && width < 1024;
            final isDesktop = width >= 1024;

            return AlertDialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: BorderSide(
                  color: Colors.black, // 경계선 색상
                  width: width * 0.0010, // 경계선 두께
                ), // 모서리 둥글게
              ),
              content: Container(
                height: isMobile ? 400 : height * 0.85,
                width: isMobile ? width * 0.8 : width * 0.4,
                decoration: BoxDecoration(
                  color: Colors.white, // 배경 색상
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 상단 이름과 닫기 버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Spacer(),
                        SizedBox(
                          width: width * 0.035,
                        ),
                        SelectableText(
                          name,
                          style: TextStyle(
                              fontSize: isMobile ? 16 : width * 0.015,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Pretendard'),
                        ),
                        Spacer(),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(
                            Icons.close,
                            size: width * 0.025,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: height * 0.0148),
                    // 이미지 섹션
                    Container(
                      padding: EdgeInsets.fromLTRB(
                          width * 0.0083, 0.0148, width * 0.0083, 0.0148),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16), // 둥근 모서리
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, height * 0.0027),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                        height: isMobile ? 150 : width * 0.20,
                        width: isMobile ? 150 : height * 0.30,
                      ),
                    ),
                    SizedBox(height: height * 0.05),
                    // 내용 섹션
                    Container(
                      child: SelectableText(
                        content,
                        style: TextStyle(
                          fontSize: isMobile ? 12 : height * 0.0120,
                          height: height * 0.00142, // 줄 간격 추가
                          fontFamily: 'Pretendard',
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),

                    SizedBox(height: height * 0.0148),
                    // 하단 버튼 (필요하다면 추가 가능)
                  ],
                ),
              ),
            );
          },
        );
      },
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
