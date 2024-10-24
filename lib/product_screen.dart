import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProductScreen extends StatefulWidget {
  final int initialTabIndex; // 초기 탭 인덱스를 받을 변수 추가

  ProductScreen({this.initialTabIndex = 0}); // 기본값 0으로 설정

  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen>
    with TickerProviderStateMixin {
  String? _selectedName;
  String? _selectedImage;
  String? _selectedContent;
  late TabController _mainTabController; // 메인 탭 컨트롤러
  late TabController _heidolphTabController; // Heidolph 하위 탭 컨트롤러
  late TabController _normagTabController; // NORMAG 하위 탭 컨트롤러

  final List<List<String>> squadData = [
    [
      'SPECIFICATIONS',
      'Model V-2',
      'Model V-5 TA(H)/CIP',
      'Model V-10 TA(H)/CIP',
      'Model V-16',
      'Model V-20'
    ],
    [
      'Rotor Size',
      '2\"\"\n(5.1 cm)',
      '5\"\"\n(12.7 cm)',
      '10\"\"\n(25.4 cm)',
      '16\"\"\n(40.6 cm)',
      '20\"\"\n(50.8 cm)'
    ],
    [
      'Throughput',
      '0 - 0.5 GPM\n(0 - 1.9 LPM)',
      '0.5 -5 GPM\n(1.9 - 19 LPM)',
      '1 - 30 GPM\n(3.8 - 110 LPM)',
      '10 - 90 GPM\n(38 - 340 LPM)',
      '30 - 200 GPM\n(110 - 750 LPM)'
    ],
    [
      'Footprint\n(Separator Only)',
      '9\"\"X 9\"\"\n(22.9 cm x 22.9 cm)',
      '12\"\"X 12\"\"\n(30.5 cm x 30.5 cm)',
      '24\"\"X 24\"\"\n(61 cm x 61 cm)',
      '48\"\"X 48\"\"\n(122cm x 122cm)',
      '60\"\"X 60\"\"\n(152.4cm x 152.4cm)'
    ],
    [
      'Height\n(Includes Motor)',
      '17\"\"to 19\"\"\n(43 to 48 cm)',
      '36\"\"to 44\"\"\n(31 to 112 cm)',
      '60\"\"to 72\"\"\n(152 to 183 cm)',
      '80\"\"\n(203cm)',
      '112\"\"\n(284.5cm)'
    ],
    [
      'Fittings (NPT Male)\n Input/Output',
      '3/8\"\" / 3/8\"\"',
      '1\"\" / 1\"\"',
      '2\"\" / 2\"\"',
      '4\"\" / 4\"\"',
      '4\"\" / 4\"\"'
    ],
    [
      'Standard Power',
      'Electric',
      'Electric',
      'Electric',
      'Electric',
      'Electric'
    ],
    [
      'Power Requirements',
      '1/8 HP\n(.12 kW)',
      '2 HP\n(1.5 kW)',
      '7.5 HP\n(5.5 kW)',
      '30 HP\n(22 kW)',
      '60 HP\n(45 kW)'
    ],
    [
      '                  ',
      '110,220 or 440 VAC',
      '220 or 440 VAC',
      '220 or 440 VAC',
      '220 or 440 VAC',
      '220 or 440 VAC'
    ],
    [
      '                  ',
      'Single-Phase or\nThree Phase',
      'Single-Phase or\nThree Phase',
      'Single-Phase or\nThree Phase',
      'Three-Phase',
      'Three-Phase'
    ],
    [
      'Weight - Approx.\n(In Stainless Steel)',
      '25 lbs\n(11.4 kg)',
      '150 lbs\n(70 kg)',
      '750 lbs\n(340 kg)',
      '3,000 lbs\n(1,360 kg)',
      '4500 lbs\n(2,041 kg)'
    ]
  ];

  @override
  void initState() {
    super.initState();
    // TabController에 초기 인덱스를 설정
    _mainTabController = TabController(
        length: 3, vsync: this, initialIndex: widget.initialTabIndex);
    _heidolphTabController =
        TabController(length: 5, vsync: this); // Heidolph 하위 탭
    _normagTabController = TabController(length: 3, vsync: this); // NORMAG 하위 탭
  }

  @override
  void dispose() {
    _mainTabController.dispose();
    _heidolphTabController.dispose();
    _normagTabController.dispose();
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
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(
              isMobile ? height * 0.2680 : height * 0.3369,
            ),
            child: AppBar(
              flexibleSpace: Column(
                children: [
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/main-background4.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Center(
                        child: Text("Products",
                            style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: isMobile ? 30 : 60),
                            )),
                      ),
                    ),
                  ),
                  Container(
                    width: isMobile ? width * 0.90 : width * 0.4,
                    height: isMobile ? 35 : 50,
                    // color:  Color(0xffd4e2f5).withOpacity(0.9),
                    color: Colors.grey,
                    child: Center(
                      child: TabBar(
                        controller: _mainTabController,
                        // TabController 설정
                        labelColor: Colors.black,
                        // 선택된 탭의 텍스트 색상
                        unselectedLabelColor: Colors.white,
                        // 선택되지 않은 탭의 텍스트 색상
                        indicatorColor: Colors.black,
                        // 탭 선택 시 밑줄 색상

                        tabs: [
                          Tab(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 30 : width * 0.019),
                              // 탭 간격 조정
                              child: Text(
                                "Heidolph",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobile ? 12 : width * 0.007),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 30 : width * 0.019),
                              // 탭 간격 조정
                              child: Text(
                                "NORMAG",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobile ? 12 : width * 0.007),
                              ),
                            ),
                          ),
                          Tab(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: isMobile ? 20 : width * 0.019),
                              // 탭 간격 조정
                              child: Text(
                                "CINC Industry",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: isMobile ? 12 : width * 0.007),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent, // 배경 투명
              elevation: 0, // 그림자 제거
            ),
          ),
          body: Container(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    height: isMobile ? height * 0.90 : height * 0.90,
                    color: Colors.white,
                    child: TabBarView(
                      controller: _mainTabController, // TabController 설정
                      children: [
                        _buildHeidolphTab(),
                        _buildNormagTab(),
                        _buildCINCTab(),
                      ],
                    ),
                  ),
                ),
              ],
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
          Center(
              // 탭바를 중앙에 배치하기 위해 Center로 감싸기
              child: Container(
            padding: EdgeInsets.fromLTRB(
                isMobile ? 0 : 400, 0, isMobile ? 0 : 400, 0),
            child: TabBar(
              controller: _heidolphTabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              // 탭 간격을 중앙에서 일정하게 하기 위해 Alignment 조정

              tabs: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 0 : width * 0.002,
                      vertical: height * 0.007),
                  // 각 탭에 일정 간격 설정
                  child: Text(
                    "Rotary Evaporator",
                    style: TextStyle(
                        fontSize: isMobile
                            ? width * 0.0004
                            : width * 0.007), // 텍스트 크기를 18로 설정
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 0 : width * 0.002,
                      vertical: height * 0.007),
                  child: Text(
                    " Stirring",
                    style: TextStyle(
                        fontSize: isMobile
                            ? width * 0.0004
                            : width * 0.007), // 텍스트 크기를 18로 설정
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 0 : width * 0.002,
                      vertical: height * 0.007),
                  child: Text(
                    " Automation",
                    style: TextStyle(
                        fontSize: isMobile
                            ? width * 0.0004
                            : width * 0.007), // 텍스트 크기를 18로 설정
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 0 : width * 0.002,
                      vertical: height * 0.007),
                  child: Text(
                    "Voltex & Shaking",
                    style: TextStyle(
                        fontSize: isMobile
                            ? width * 0.0004
                            : width * 0.007), // 텍스트 크기를 18로 설정
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 0 : width * 0.002,
                      vertical: height * 0.007),
                  child: Text(
                    "Liquid Handling",
                    style: TextStyle(
                        fontSize: isMobile
                            ? width * 0.0004
                            : width * 0.007), // 텍스트 크기를 18로 설정
                  ),
                ),
              ],
            ),
          )),
          Expanded(
            child: TabBarView(
              controller: _heidolphTabController,
              children: [
                _buildProductList([
                  {
                    "name": "Hei-VAP Series",
                    "image": "assets/products/Hei-VAP_Series.png",
                    "content": """
                  •5“ 터치 디스플레이의 중앙 제어 패널
                  •G1/G3 사선 글래스웨어의 핸드/모터 리프트 모델
                  •전체 값에 대한 명확한 디스플레이(베이직 및 어드밴스 모드)
                  •타이머, 최대 온도 제한, 다국어 메뉴 및 오류 메시지의 텍스트 디스플레이
                  •회전 및 가열용 별도 노브와 의도하지 않은 설정변경을 방지하는 잠금 기능
                  •멀리에서도 설정 조건을 표시하는 LED 링 라이트 및 픽토그램
                  •외부 진공 컨트롤러에서 필요한 진공압 조절을 위한 통합 용매 라이브러리
                  •USB 및 마이크로 SD 인터페이스
                  •증기 온도 디스플레이(옵션)
                  •진공 및 냉각기 컨트롤 포함, 가능한 경우 Hei-VAP Expert Control로 차후
                  업그레이드"""
                  },
                  {
                    "name": "Hei-VAP Industrial",
                    "image": "assets/products/Hei-VAP_Industrial.png",
                    "content": """
•고강도 투명 PMMA 도어로 탁월한 사용자 안전 보장
•김 서림 방지 안전유리 및 금속 프레임 가드 후드가 탁월한 사용자 보호
기능 제공
•작동 시 농축용 플라스크에 표시가 됨
•물과 기타 수조 용액을 모두 사용할 수 있는 일반 가열 수조로, 최고
180°C까지 온도 설정 가능
•회수 카세트 및 추가 PMMA 도어 하우징이 글래스웨어 파손 위험으로부터
보호
•통합 재충진 용수 시스템, 넘침 방지 기능 및 하단의 배출 밸브가
스탠다드로 제공
•옵션인 베이스 카트는 진공 펌프, 글래스웨어, 용매 혹은 부속품을 보관하는
용도로 분리가 가능한 패널로 사용 가능
•이 모델에 대해 이용 가능한 GMP에 따른 인증: 설치 검증(IQ) 및 운영
자격인증(OQ)
•모든 공정의 설정 조건을 포함하는 조명 디스플레이의 대형 터치 스크린
제어 패널, 프로그래밍할 수 있는 램프
                    """
                  },
                  {
                    "name": "Automatic Distillation",
                    "image": "assets/products/Automatic_Distillation.png",
                    "content": """
탈부착 가능한 7“ 터치스크린 컨트롤 패널을 이용해 회전 플라스크의 센서
및 시간 제어 충진을 위한 샘플의 설정 조건을 입력할 수 있습니다.
농축물 냉각(약 1L) 코팅 콜렉터 베셀 및 압축기를 통한 회전 플라스크
잔여물 배출 시간도 프로그래밍할 수 있습니다.
또한 자동 세척 모드 및 수동 모드로 작동 가능합니다.
Hei-VOLUME Distimatic 24/7의 통합 콤프레셔가 설치된 타워는 제공된
브래킷을 사용해 Hei-VAP Industrial 시리즈 탁상형 / 대용량 농축기의 모든
부품에 바로 설치할 수 있습니다.
전용 농축기 시스템과 함께 Hei-VOLUME Distimatic Pro 24/7 자동 모듈은
모든 범주의 실험에서 효율적인 무인 가동이 가능합니다.
최고 수준의 안전성과 다양한 실험을 실현하기 위해 제공되는 튜빙 등
샘플과 접촉하는 모든 부품은 내화학성 재료로 제작됐습니다."""
                  },
                  {
                    "name": "Hei Chill Peltier (소형 냉각기)",
                    "image": "assets/products/Hei_Chill_Peltier.png",
                    "content": """
Hei-CHILL Peltier Thermostat은 600와트의 높은 냉각 용량과 거의 두 배에
달하는 높은 난방 전력을 갖추고 있어 많은 온도 제어 작업에
적합합니다.온도 조절기는 다양한 인터페이스를 사용하는 Hei-PROCESS 
솔루션을 통해 프로세스에 통합될 수 있습니다.또한 장치는 재순환
칠러로서 Hei-VAP Expert Control 또는 Ultimate Control 회전 증발농축기를
통해 직접 제어하거나 통합 터치 디스플레이를 통해 독립적으로 사용할 수
있습니다.
• 지속적인 부하에도 온도 안정성을 위한 6리터 탱크 부피
• 0.05 ℃ 이하의 정밀한 온도 조절 및 안정성
• 작동 온도 범위 -10 °C ~ 70 °C
• 현대식 2.83인치 터치 디스플레이
• 처리 솔루션 통합을 위한 이더넷, RS 232 및 RS 485 인터페이스
                    """
                  },
                  {
                    "name": "Hei Chill Peltier (대형 냉각기)",
                    "image": "assets/products/Hei_Chill_5000.png",
                    "content": """
5,000W의 냉각 용량으로 까다로운 냉각 작업에 대해 포괄적인 범위의
냉각이 가능합니다.
•상단에 용액 충진부, 후방에 배수 탭
•150개 세그먼트의 통합 프로그래머, 5개 프로그램으로 분할 가능
•전자 수위 표시기와 저수위 알람
•자동 압축 컨트롤을 포함해 디지털식 에너지 절약형 냉각 컨트롤을 위한
SmartCool 시스템
•명확히 배치된 제어 요소, 대형 TFT 디스플레이, 멤브레인 키패드
•USB 인터페이스와 알람 컨택트가 표준 기능으로 통합되어 있음
                    """
                  },
                ]),
                _buildProductList([
                  {
                    "name": "Magnetic Stirrer",
                    "image": "assets/products/Magnetic_stirrer.png",
                    "content": """
Hei-PLATE Mix ‘n’ series는 자력 교반기에서 가장 많이 사용되는 제품입니다. 
이를 통해 사용자는 최대 1,400rpm까지 부드럽게 교반하고 최대 350°C의
온도까지 높은 정밀도로 가열할 수 있습니다. 또한 언제든지 제품을
사용하고 중지할 수 있는 전원버튼 및 놉에 있는 LED링은 정교하교
안전하게 사용 할수 있습니다. 다이나믹 로터리놉은 회전 속도에 따라
설정값을 빠르게 혹은 느리게 조정 할수 있습니다. 잠금 기능은 값이
우발적으로 변경되는 것을 방지합니다. 바로 이런 부분이 "Research made 
easy (연구가 쉬워짐)" 을 의미합니다.
이 자력 교반기는 가장 중요한 안전 기능을 갖추고 있습니다. 가열판과
제어판 사이의 안전 거리와 50°C 이상의 온도에서 시각적인 잔열 표시기가
화상을 방지합니다.
아노다이징 처리된 알루미늄으로 제작된 특허 받은 Kera-Disk® 풋프린트는
내화학성, 긁힘 방지 기능에 직경이 145mm입니다. 이 유니크한 사이즈
덕분에 좁은 설치 공간에서 많은 액세서리 및 샘플과 함께 사용하기에
적합하며 제품의 재질 특성으로 빠른 가열 시간을 보장합니다.
마그네틱 교반기 Hei-PLATE Mix 'n' Heat Core+는 원하는 온도까지 설정할
수 있는 디지털 디스플레이를 제공합니다. 오버슈팅이 없는 이 정밀한
온도는 두 가지 선택 가능한 가열 모드(FAST/PRECISE)와 옵션인 외부 온도
센서 Pt1000에 의해 제어됩니다."""
                  },
                  {
                    "name": "오버헤드 교반기",
                    "image": "assets/products/Overhead_stirrer.png",
                    "content": """
Hei-TORQUE 제품군 장치는 Heidolph 고성능 교반기입니다.
Hei-TORQUE Ultimate 200 실험실 교반기는 점도는 최고 100,000mPas, 
부피는 최대 50리터(H2O)까지 강력한 교반에 적합합니다. 넓은 속도
범위(10~2,000rpm)와 200Ncm에 달하는 최대 토크를 자랑합니다.
뿐만 아니라, Hei-TORQUE Ultimate 200은 무엇보다도 프로그래밍, 공정
모니터링(타이머 기능, 토크 트렌드 밸류 디스플레이 포함)을 비롯해
애플리케이션에 실시간으로 실험 상황을 모니터링하며 사용할수 있는
장비입니다. 여기에는 USB와 RS232의 2개의 인터페이스가 장착되어
있어서, 외부장치나 PC와 연결하여 프로그램화 컨트롤러(PLC) 또는
LabManager 등과 같은 자동화 시스템으로 연결하여 사용 할수 있습니다. 
PC를 통한 최대 4개 장치의 원격 조정용 무료 Hei-Control 소프트웨어를
포함합니다.
실험실 교반기 Hei-TORQUE Ultimate 200은 최신 엔진 기술 덕분에 모든
교반 작업을 최소한의 소음으로 수행합니다. 안전과 관련된 시작/정지 터치
기능은 의도하지 않은 작동의 위험을 최소화해줍니다.
흄 후드 내, 또는 원자로 상부구조용 드라이브로 사용하기에 적합한 HeiTORQUE
Ultimate 200에는 지름 10.5mm의 퀵 액션 척(안전 링이 포함된 퀵
척)이 있어서, 다양한 임펠라와 결합해 최상의 교반 결과를 도출할 수
있습니다."""
                  },
                ]),
                _buildProductList([
                  {
                    "name": "Hei-Process Cloud Core",
                    "image": "assets/products/Hei-Process_Cloud_Core.png",
                    "content": """
네트워크화되고 자동화된 실험실 환경을 마련하는 것은 결코 쉬운 일이
아닙니다. 수동 작업 흐름을 완전히 자동화된 프로세스로 전환하는 것은
서로 다른 장치와 소프트웨어 간의 호환성 문제로 인해 종종 장애물에
부딪힙니다. 제한된 솔루션은 수동 개입을 필요로 하며, 작업 흐름 효율성을
방해합니다.

이러한 문제를 인식하고 지원하고자 합니다. Hei-PROCESS는 개별 실험실
장치를 원활하게 통합하고 원격으로 제어하거나 복잡한 프로세스를 완전히
자동화하는 등 고객의 요구에 맞는 맞춤형 솔루션을 제공합니다."""
                  },
                ]),
                _buildProductList([
                  {
                    "name": "Platform shakers",
                    "image": "assets/products/Platform_shakers.png",
                    "content": """
Hei-SHAKE 시리즈의 플랫폼 셰이커를 사용하면 다양한 유형의 이동, 하중
무게 및 흔들림 및 혼합을 위한 광범위한 액세서리를 통해 가능한 수많은
응용 프로그램을 얻을 수 있습니다.
올바른 액세서리와 함께 최고 요구 사항을 충족하는 신뢰할 수 있는 플랫폼
셰이커를 가질 수 있으며, 강력한 디자인과 직관적인 작동 덕분에 실험실의
일상적인 요구 사항을 충족합니다."""
                  },
                  {
                    "name": "Vortexer",
                    "image": "assets/products/Vortexer.png",
                    "content": """
Vortexer는 모든 실험실에서 핵심적인 역할을 합니다. 사용 편의성과 실험실
연구원으로서 얻을 수 있는 빠른 결과에 중점을 둡니다. 고체를 용해시키기
위한 것이든, 세포 펠렛을 신선한 배지에 용해시키기 위한 것이든, 
시험관에서 개별 샘플을 단순히 혼합하기 위한 것이든, 이 도구는 항상
실험실 벤치의 한 지점을 찾습니다.
Heidolph Instruments GmbH & Co.KG에는 세 개의 다른 Voltexer가 있으므로, 
매일 사용할 수 있는 것이 있습니다. 게다가, 단일 Voltexer는 다양한
액세서리로 확장될 수 있어서, 다른 샘플들이 더 쉽고 빠르게 처리될 수
있습니다. 직접 보세요!"""
                  },
                  {
                    "name": "오버헤드 쉐이커",
                    "image": "assets/products/Overhead_shakers.png",
                    "content": """
콤팩트한 오버헤드 셰이커는 다양한 용도에 적합합니다. 특히 페인트 및
바니시 기술에서 이 도구는 색상 안료를 적절하게 분배하여 원하는 고른
결과를 얻기 위한 중요한 전제 조건을 제공합니다. 또한 대용량 모델(Reax 
20)에는 모두 별도의 비상 스위치가 장착되어 있어 무거운 하중과
고회전에도 절대적인 안전성이 보장됩니다."""
                  },
                ]),
                _buildProductList([
                  {
                    "name": "Liquid handling",
                    "image": "assets/products/Liquid_handling.png",
                    "content": """
정확한 투여는 제약, 화장품 및 식품 부문에서 특히나 중요합니다 종합적인
공정 여건은 민감한 샘플의 안전한 운반에 전제 조건입니다. 이는 오차 범위
±0.5%의 제어 정확성과 정밀한 속도 조절(5~120rpm)로 보장됩니다.
게다가 옵션인 풋 스위치로 폐쇄된 배기 후드에서 펌프가 작동할 수
있습니다. 속도, 회전 방향 및 온오프 기능 등의 매개 변수를 아날로그 또는
디지털 인터페이스를 통해 외부적으로 제어할 수 있습니다.
이 모델에서는, 싱글 채널 또는 멀티 채널 펌프 헤드를 선택할 수 있습니다. 
유량은 펌프 헤드에 따라 달라집니다.싱글 채널 헤드는 분당 0.38~813 
ml이고, 멀티 채널 헤드는 분당 0.005~364 ml입니다. 공정 중점에 따라 다음
매개 변수를 장치에서 설정할 수 있습니다. 속도, 튜빙 지름, 유량 디스플레이, 
계량 부피, 투여 간격 및 쉬는 시간. 펌프는 최적의 투여 결과를 위해
조정됩니다."""
                  },
                ]),
              ],
            ),
          ),
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
          Center(
            child: Container(
              padding: EdgeInsets.fromLTRB(
                  isMobile ? 0 : 400, 0, isMobile ? 0 : 400, 0),
              child: Container(
                height: isMobile ? 50 : 60,
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _normagTabController,
              children: [
                _buildProductList([
                  {
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
          ),
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
          Center(
              // 탭바를 중앙에 배치하기 위해 Center로 감싸기
              child: Container(
            padding: EdgeInsets.fromLTRB(
                isMobile ? 0 : 400, 0, isMobile ? 0 : 400, 0),
            child: TabBar(
              controller: _heidolphTabController,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.black,
              // 탭 간격을 중앙에서 일정하게 하기 위해 Alignment 조정
              tabs: [
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 0 : width * 0.002,
                      vertical: height * 0.007),
                  // 각 탭에 일정 간격 설정
                  child: Text(
                    " 소개",
                    style: TextStyle(
                        fontSize: isMobile
                            ? width * 0.0004
                            : width * 0.007), // 텍스트 크기를 18로 설정
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 0 : width * 0.002,
                      vertical: height * 0.007),
                  child: Text(
                    " How to Work",
                    style: TextStyle(
                        fontSize: isMobile
                            ? width * 0.0004
                            : width * 0.007), // 텍스트 크기를 18로 설정
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 0 : width * 0.002,
                      vertical: height * 0.007),
                  child: Text(
                    " 특징",
                    style: TextStyle(
                        fontSize: isMobile
                            ? width * 0.0004
                            : width * 0.007), // 텍스트 크기를 18로 설정
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 0 : width * 0.002,
                      vertical: height * 0.007),
                  child: Text(
                    "Application",
                    style: TextStyle(
                        fontSize: isMobile
                            ? width * 0.0004
                            : width * 0.007), // 텍스트 크기를 18로 설정
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? 0 : width * 0.002,
                      vertical: height * 0.007),
                  child: Text(
                    "Specifications",
                    style: TextStyle(
                        fontSize: isMobile
                            ? width * 0.0004
                            : width * 0.007), // 텍스트 크기를 18로 설정
                  ),
                ),
              ],
            ),
          )),
          Expanded(
            child: TabBarView(
              controller: _heidolphTabController,
              children: [
                Container(
                  child: Center(
                      child: Container(
                    width: isMobile ? 450 : width * 0.585,
                    height: isMobile ? 450 : height * 0.520,
                    child: Row(children: [
                      SizedBox(
                        width: width * 0.018,
                      ),
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white, // 배경 색상
                            border: Border.all(
                              color: Colors.grey, // 테두리 색상
                              width: 1.0, // 테두리 두께
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: Image.asset(
                          "assets/products/Cinc_Industry_Product.png",
                          width: isMobile ? 220 : width * 0.234,
                          height: isMobile ? 400 : height * 0.4166,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.018,
                      ),
                      VerticalDivider(
                        indent: height * 0.0083,
                        endIndent: height * 0.0166,
                      ),
                      Column(
                        children: [
                          SizedBox(
                            height: height * 0.0347,
                          ),
                          Text("CINC Industry 소개",
                              style: GoogleFonts.nanumGothic(
                                textStyle: TextStyle(
                                    fontSize: width * 0.0125,
                                    color: Colors.indigoAccent),
                              )),
                          SizedBox(
                            height: height * 0.0486,
                          ),
                          Text(
                            """
        CINC는 액체-액체 원심분리기를 설계, 제조 및 공급하는 기업으로, 
      전 세계의 석유, 화학, 광업, 제약, 식품, 
      향료, 인쇄 및 환경 산업 분야의 연구를 수행하는 고객들의 신뢰를 받고 있습니다.
      CINC 원심분리기는 조정 가능한 중(重)상 위어(weir)와 가변 속도 모터를 통해
      특정 중력 차이에 따른 다양한 요구에 유연하게 대응할 수 있으며,
      자가 흡입 설계로 펌프 또는 중력 공급이 가능해 유량 변화에도 안정적인 성능을 제공합니다.
      또한 모든 제품은 사내에서 설계, 제조 및 철저한 테스트를 거쳐 최고의 품질을 보장합니다.
      ISO 9000 및 NAQ-1 기준을 준수하며, cGMP 및 FED 표준에 따라 원심분리기를 제조하고,
      CE 및 PED 지침, ATEX 100 인증을 보유하고 있습니다.
      연구개발부터 대량 생산 규모에 이르기까지 다양한 크기로 제공되며, 
      다양한 산업의 요구를 충족시키기 위해 끊임없이 발전하고 있습니다""",
                            style: TextStyle(fontSize: width * 0.007),
                          )
                        ],
                      )
                    ]),
                  )),
                ),
                Container(
                  child: Center(
                      child: Container(
                    width: isMobile ? 450 : width * 0.600,
                    height: isMobile ? 450 : height * 0.486,
                    child: Row(children: [
                      SizedBox(
                        width: width * 0.018,
                      ),
                      Container(
                        width: isMobile ? 450 : width * 0.273,
                        height: isMobile ? 450 : height * 0.486,
                        decoration: BoxDecoration(
                            color: Colors.white, // 배경 색상
                            border: Border.all(
                              color: Colors.grey, // 테두리 색상
                              width: 1.0, // 테두리 두께
                            ),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            )),
                        child: Image.asset(
                          "assets/how_to_work.png",
                          width: isMobile ? 220 : width * 0.273,
                          height: isMobile ? 400 : height * 0.486,
                        ),
                      ),
                      SizedBox(
                        width: width * 0.018,
                      ),
                      VerticalDivider(
                        indent: height * 0.0083,
                        endIndent: height * 0.0166,
                      ),
                      Expanded(
                          child: Column(
                        children: [
                          SizedBox(
                            height: height * 0.030,
                          ),
                          Text("How To Work",
                              style: GoogleFonts.nanumGothic(
                                textStyle: TextStyle(
                                    fontSize: width * 0.0125,
                                    color: Colors.indigoAccent),
                              )),
                          SizedBox(
                            height: height * 0.0138,
                          ),
                          Text(
                            """
      1. 작동원리
        회전하는 로터 내에서 발생하는 원심력을 이용하여 서로 다른 밀도의 두 액체를 분리합니다.
        
      2. 입력 방식
        홉합된 액체가 양쪽 입구로 들어오거나, 각각의 액체가 독립적으로 유입됩니다.
        
      3. 혼합
        로터와 하우징 사이에서 액체가 혼합되고(초록색), 로터 하단을 통해 유입됩니다.
        
      4. 분리 과정
        - 밀도가 높은 액체(파란색): 로터 바깥쪽으로 밀려나가 높은 단계의 출구로 배출됩니다.          
        - 밀도가 낮은 액체(노란색): 로터 중심으로 이동해 낮은 단계의 출구로 배출됩니다.
          
      5. 수집
        각각의 액체는 다른 수집 링에 모여 분리된 출구로 배출됩니다.
        """,
                            style: TextStyle(fontSize: width * 0.007),
                          )
                        ],
                      ))
                    ]),
                  )),
                ),
                Container(
                  width: width * 0.156,
                  padding: EdgeInsets.symmetric(
                      horizontal: width * 0.007, vertical: height * 0.0138),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // Column 내부의 요소들을 중앙에 배치
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // 가로 방향으로도 중앙에 배치
                      children: [
                        Center(
                          child: Text("CINC Industry 특징",
                              style: GoogleFonts.nanumGothic(
                                textStyle: TextStyle(
                                    fontSize: width * 0.018,
                                    color: Colors.indigoAccent),
                              )),
                        ),
                        SizedBox(height: height * 0.0556),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.speed, color: Colors.blueAccent),
                            SizedBox(
                              width: width * 0.003,
                            ),
                            Text(
                              "분당 0.5~200 gallons (1.9~757L)의 유량 처리 가능",
                              style: TextStyle(
                                  fontSize: width * 0.007,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center, // 텍스트 중앙 정렬
                            ),
                          ],
                        ),
                        Divider(
                          indent: width * 0.351,
                          endIndent: width * 0.351,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.tune, color: Colors.blueAccent),
                            SizedBox(
                              width: width * 0.003,
                            ),
                            Text(
                              "200~1,000g의 원심력만으로도 효율적인 분리 및 추출",
                              style: TextStyle(
                                  fontSize: width * 0.007,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center, // 텍스트 중앙 정렬
                            ),
                          ],
                        ),
                        Divider(
                          indent: width * 0.351,
                          endIndent: width * 0.351,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.local_drink, color: Colors.blueAccent),
                            SizedBox(
                              width: width * 0.003,
                            ),
                            Text(
                              "전단에 민감한 유체를 위한 저혼합 및 직접 투입 옵션 제공",
                              style: TextStyle(
                                  fontSize: width * 0.007,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center, // 텍스트 중앙 정렬
                            ),
                          ],
                        ),
                        Divider(
                          indent: width * 0.351,
                          endIndent: width * 0.351,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.adjust, color: Colors.blueAccent),
                            SizedBox(
                              width: width * 0.003,
                            ),
                            Text(
                              "중량 차이를 처리할 수 있는 조절 가능한 중상위어와 가변 속도 모터",
                              style: TextStyle(
                                  fontSize: width * 0.007,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center, // 텍스트 중앙 정렬
                            ),
                          ],
                        ),
                        Divider(
                          indent: width * 0.351,
                          endIndent: width * 0.351,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.thermostat, color: Colors.blueAccent),
                            SizedBox(
                              width: width * 0.003,
                            ),
                            Text(
                              "냉동 온도부터 끓는 온도까지 다양한 투입 온도 처리 가능",
                              style: TextStyle(
                                  fontSize: width * 0.007,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center, // 텍스트 중앙 정렬
                            ),
                          ],
                        ),
                        Divider(
                          indent: width * 0.351,
                          endIndent: width * 0.351,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.build, color: Colors.blueAccent),
                            SizedBox(
                              width: width * 0.003,
                            ),
                            Text(
                              "내구성 높은 스테인리스 스틸 구조, 부식 방지 합금도 선택 가능",
                              style: TextStyle(
                                  fontSize: width * 0.007,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center, // 텍스트 중앙 정렬
                            ),
                          ],
                        ),
                        Divider(
                          indent: width * 0.351,
                          endIndent: width * 0.351,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.cleaning_services,
                                color: Colors.blueAccent),
                            SizedBox(
                              width: width * 0.003,
                            ),
                            Text(
                              "유지보수가 적고 신뢰성이 높은 제자리 세척(CIP) 로터 시스템",
                              style: TextStyle(
                                  fontSize: width * 0.007,
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.center, // 텍스트 중앙 정렬
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SingleChildScrollView(

                  child:  Column(
                    children: [
                      SizedBox(
                        height: height * 0.0250,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildApplicationTextList("""Chemical""", """
                                  
- 폴리머 원료 공급
- 폴리머 생산
- 부타디엔 및 스티렌 수지
- 유기 과산화물
- 공비(共沸) 분리
- 용매 회수
- 열전달 유체 회수
- 유기물 세정

                                """),
                          SizedBox(
                            width: width * 0.006,
                          ),
                          buildApplicationTextList("""Pharmaceutical""", """
       
                                  
- 항생제

- 에리스로마이신

- 페니실린


                                """),
                          SizedBox(
                            width: width * 0.006,
                          ),
                          buildApplicationTextList("""Petroleum""", """
                                          
- 산류 회수

- 유정 완성 유체 회수

- 생산수 처리

- 오일 탈수

- 육상 및 해상 (FPSO 및 고정 플랫폼)




                                """),
                          SizedBox(
                            width: width * 0.006,
                          ),
                          buildApplicationTextList("""Biotech""", """
       
     
                                  
- 재조합 DNA 제품


- 배양액 추출




                                """),
                        ],
                      ),
                      SizedBox(
                        height: height * 0.0250,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          buildApplicationTextList("""Environmental""", """
                                  
- 유류 유출 정화

- 지하수 복원

- 세척수 재활용

- 빌지수 처리

- 산업 세탁수 탈유


                                """),
                          SizedBox(
                            width: width * 0.006,
                          ),
                          buildApplicationTextList(
                              """Mining and Metals Recovery""", """
       
                                  
- 다양한 금속의 용매 추출

- 용매 회수 및 재활용

- 폐수 분리



                                """),
                          SizedBox(
                            width: width * 0.006,
                          ),
                          buildApplicationTextList("""Food & Nutrition""", """
       
                                       
- 이소플라본

- 식용유

- 향료 추출

- 영양 보충제





                                """),
                          SizedBox(
                            width: width * 0.006,
                          ),
                          buildApplicationTextList(
                              """Biodisel Production""", """
                                  
- 메틸 에스터에서 글리세린 분리

- 바이오디젤 수세

- 조류 세포 농축

- 메틸 에스터에서 글리세린 분리


                                """),
                        ],
                      ),
                    ],
                  ),
                ),

                // Container(
                //   child: Center(
                //       child: Column(
                //         children: [
                //           SizedBox(
                //             height: isMobile?0:80,
                //           ),
                //           Image.asset("assets/table.png",height: isMobile? 400:600,)
                //         ],
                //       )),
                // ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Container(
                    height: isMobile ? 500 : height * 0.5800,
                    padding: EdgeInsets.fromLTRB(isMobile ? 16 : width * 0.097,
                        0, isMobile ? 16 : width * 0.097, 0),
                    child: Center(
                        child: Table(
                      border: TableBorder.all(), // 표에 테두리 추가
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: List.generate(11, (rowIndex) {
                        return TableRow(
                          children: List.generate(6, (colIndex) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                squadData[rowIndex][colIndex],
                                style: TextStyle(
                                  fontSize:
                                      isMobile ? 8 : width * 0.005, // 각 행에 따라 폰트 크기 변경
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black, // 컬럼 인덱스에 따른 색상 지정
                                ),
                                textAlign: TextAlign.center,
                              ),
                            );
                          }),
                        );
                      }),
                    )),
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
        child: Container(
          width: 1500,
          child: GridView.builder(
            padding: EdgeInsets.fromLTRB(8.0, isMobile ? 24 : 48, 0, 8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 한 줄에 3개씩 배치
              crossAxisSpacing: 16.0, // 좌우 간격 줄이기
              mainAxisSpacing: 8.0, // 상하 간격 줄이기
              childAspectRatio: 0.75, // 아이템 비율 (세로로 길게)
            ),
            itemCount: products.length,
            itemBuilder: (context, index) {
              return buildProductCard(
                  products[index]["name"]!,
                  products[index]["image"]!,
                  products[index]["content"]!,
                  context,
                  isMobile ? width * 0.0400 : width * 0.1200,
                  isMobile ? height * 0.0100 : height * 0.400);
            },
          ),
        ),
      );
    });
  }

  Widget buildApplicationTextList(String main, String content) {
    return Column(
      children: [
        Container(
          width: 300,
          height: 50,
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
              fontSize: 20,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: 300,
          height: 250,
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
            style: TextStyle(fontSize: 16, color: Colors.black),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }

  // Product Card Widget
  Widget buildProductCard(String name, String imagePath, String content,
      BuildContext context, double width, double height) {
    return LayoutBuilder(builder: (context, constraints) {
      // width와 height 모두를 고려한 반응형 조건 설정
      final size = MediaQuery.of(context).size;
      final width = size.width;
      final height = size.height;
      final isMobile = width < 600 && height < 800;
      final isTablet = width >= 600 && width < 1024 && height < 1200;
      final isDesktop = width >= 1024 && height >= 1200;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.center, // 텍스트를 이미지 중앙 정렬
        children: [
          Container(
            width: width * 1,
            decoration: BoxDecoration(
                color: Colors.white, // 배경 색상
                border: Border.all(
                  color: Colors.grey, // 테두리 색상
                  width: 1.0, // 테두리 두께
                ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                )),
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
              child: Transform.scale(
                  scale: 0.9,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.contain,
                    width: isMobile ? 150 : 300,
                    height: isMobile ? 150 : 300,
                  )),
            ),
          ),
          Container(
              decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  )),
              width: width * 1,
              child: Center(
                child: Text(name,
                    style: TextStyle(
                        fontSize: isMobile ? 8 : 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              )),
        ],
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
                borderRadius: BorderRadius.circular(16), // 모서리 둥글게
              ),
              content: Container(
                height: isMobile ? 400 : 600,
                width: isMobile ? width * 0.8 : width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // 상단 이름과 닫기 버튼
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          name,
                          style: TextStyle(
                            fontSize: isMobile ? 16 : 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: Icon(Icons.close),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // 이미지 섹션
                    Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16), // 둥근 모서리
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 5,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Image.asset(
                        image,
                        fit: BoxFit.contain,
                        height: isMobile ? 150 : 250,
                        width: isMobile ? 150 : 250,
                      ),
                    ),
                    SizedBox(height: 16),
                    // 내용 섹션
                    Expanded(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Text(
                            content,
                            style: TextStyle(
                              fontSize: isMobile ? 12 : 16,
                              height: 1.5, // 줄 간격 추가
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.left,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
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
}
