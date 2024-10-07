import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  String? _selectedName;
  String? _selectedImage;
  String? _selectedContent;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final width = size.width;
    final height = size.height;

    return DefaultTabController(
      length: 3, // Heidolph, NORMAG, CINC Industry
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: PreferredSize(
          preferredSize:
               Size.fromHeight(MediaQuery.of(context).size.height * 0.3369),

          child: AppBar(
            flexibleSpace: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/main-background2.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Products",
                        style: TextStyle(color: Colors.white, fontSize: 60),
                      ),
                    ),
                  ),
                ),

                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: Colors.white, // TabBar 배경색 설정
                  child: Center(
                    child: TabBar(
                      labelColor: Colors.blue,
                      // 선택된 탭의 텍스트 색상
                      unselectedLabelColor: Colors.grey,
                      // 선택되지 않은 탭의 텍스트 색상
                      indicatorColor: Colors.blue,
                      // 탭 선택 시 밑줄 색상
                      isScrollable: true,
                      tabs: [
                        Tab(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50.0), // 탭 간격 조정
                            child: Text(
                              "Heidolph",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                        Tab(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0), // 탭 간격 조정
                            child: Text(
                              "NORMAG",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          ),
                        ),
                        Tab(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30.0), // 탭 간격 조정
                            child: Text(
                              "CINC Industry",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
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
        body: Column(
          children: [


            Expanded(
              child: Container(
                color: Colors.white,
                child: TabBarView(
                  children: [
                    _buildHeidolphTab(),
                    _buildNormagTab(),
                    _buildCINCTab(),
                  ],
                ),
              ),
            ),
            // 제품 설명을 위한 새로운 컨테이너

          ],
        ),


      ),
    );
  }

  // Heidolph 대분류 탭
  Widget _buildHeidolphTab() {
    return DefaultTabController(
      length: 5, // Heidolph의 중분류 탭 개수
      child: Column(
        children: [
          Container(
            width: 800,

            child: TabBar(
              labelColor: Colors.blueAccent,
              // 선택된 탭의 텍스트 색상
              unselectedLabelColor: Colors.grey,
              // 선택되지 않은 탭의 텍스트 색상
              indicatorColor: Colors.blueAccent,
              // 탭 선택 시 밑줄 색상
              isScrollable: true,
              // 스크롤 가능하도록 설정
              tabs: [
                Tab(text: "Rotary Evaporator"),
                Tab(text: "Stirring"),
                Tab(text: "Automation"),
                Tab(text: "Voltex & Shaking"),
                Tab(text: "Liquid Handling"),
              ],
            ),
          ),

          Expanded(
            child: TabBarView(
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
                  {"name": "Vortexer", "image": "assets/products/Vortexer.png",
                    "content": """
Vortexer는 모든 실험실에서 핵심적인 역할을 합니다. 사용 편의성과 실험실
연구원으로서 얻을 수 있는 빠른 결과에 중점을 둡니다. 고체를 용해시키기
위한 것이든, 세포 펠렛을 신선한 배지에 용해시키기 위한 것이든, 
시험관에서 개별 샘플을 단순히 혼합하기 위한 것이든, 이 도구는 항상
실험실 벤치의 한 지점을 찾습니다.
Heidolph Instruments GmbH & Co.KG에는 세 개의 다른 Voltexer가 있으므로, 
매일 사용할 수 있는 것이 있습니다. 게다가, 단일 Voltexer는 다양한
액세서리로 확장될 수 있어서, 다른 샘플들이 더 쉽고 빠르게 처리될 수
있습니다. 직접 보세요!"""},
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
      ),
    );
  }

  // NORMAG 대분류 탭
  Widget _buildNormagTab() {
    return DefaultTabController(
      length: 3, // NORMAG의 중분류 탭 개수
      child: Column(
        children: [
          Container(
            width: 800,
            child: TabBar(
              labelColor: Colors.blueAccent,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blueAccent,
              isScrollable: true,
              tabs: [
                Tab(text: "Lab Fast Pro"),
                Tab(text: "Pilot Compact"),
                Tab(text: "Process Reaction System"),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
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
                ]),
                _buildProductList([
                  {
                    "name": "Pilot Compact Reactor (10 ~ 30L)",
                    "image": "assets/products/Pilot_compact_reactor.png",
                    "content": """
Advantages

Pilot compact 10 to 30L Reactor: jacketed vessel, PFA coated flat lid
Mobile, welded and brushed stainless steel frame with round tube additions
Lifting/Lowering Device for easy accessibility and cleaning of the reactor
Safety features: Pressure gauge, overpressure relief valve, burst disk
Spare nozzles for a variety of sensors and feeds 
Design completely GMP compliant: fully drainable, cleanable, non-contaminating 
seal…"""
                  },
                ]),
                _buildProductList([
                  {
                    "name": "Glass Reaction System",
                    "image": "assets/products/ReactionSystemPilot.png",
                    "content": ""
                  },
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // CINC Industry 대분류 탭 (업데이트 예정)
  Widget _buildCINCTab() {
    return Center(
      child: Text(
        "업데이트 예정",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
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
    return Center(
      child: Container(
        width: 1500,
        child: GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, // 한 줄에 3개씩 배치
            crossAxisSpacing: 16.0, // 좌우 간격 줄이기
            mainAxisSpacing: 8.0, // 상하 간격 줄이기
            childAspectRatio: 0.75, // 아이템 비율 (세로로 길게)
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            return _buildProductCard(
                products[index]["name"]!,
                products[index]["image"]!,
                products[index]["content"]!,
            );
          },
        ),
      ),
    );
  }

  // Product Card Widget
  Widget _buildProductCard(String name, String imagePath, String content) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // 텍스트를 이미지 중앙 정렬
        children: [
          GestureDetector(
            onTap: () {
              // 제품 클릭 시 이름과 이미지 설정

              setState(() {
               _selectedName = name;
                 _selectedImage = imagePath;
               _selectedContent = content;
                _dialogBuilder(context,name,imagePath,content);
              });
            },
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain,
              width: 300,
              height: 300,
            ),
          ),
          Text(
            name,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }


  Future<void> _dialogBuilder(BuildContext context, String name , String image , String content) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.zero
          ),
          title: Row(
           children: [
             Text('${name}'),
              Spacer(),
             IconButton(onPressed: (){
               Navigator.of(context).pop();
             }, icon: Icon(Icons.close)),
           ],
          ),
          content:  Container(
            height: 800,
            child: Column(
                children: [
                  Image.asset(
                    image,
                    fit: BoxFit.contain,
                    width: 300,
                    height: 300,
                  ),
                  Text(
                      '${content}'
                  ),
                ]

            ),
          ),


        );
      },
    );
  }

}

