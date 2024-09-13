import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Heidolph, NORMAG, CINC Industry
      child: Scaffold(
        appBar: AppBar(
          title: Text("Products"),
          bottom: TabBar(
            tabs: [
              Tab(text: "Heidolph"),
              Tab(text: "NORMAG"),
              Tab(text: "CINC Industry"),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _buildHeidolphTab(),
            _buildNormagTab(),
            _buildCINCTab(),
          ],
        ),
      ),
    );
  }

  // Heidolph Tab
  Widget _buildHeidolphTab() {
    return Column(
      children: [
        _buildSubTabBar(["Rotary Evaporator", "Stirring", "Automation", "Voltex & Shaking", "Liquid Handling"]),
        Expanded(
          child: TabBarView(
            children: [
              _buildProductList([
                {"name": "Hei-VAP Series", "image": "assets/products/Hei-VAP_Series.png"},
                {"name": "Hei-VAP Industrial", "image": "assets/products/Hei-VAP_Industrial.png"},
                {"name": "Automatic Distillation", "image": "assets/products/Automatic_Distillation.png"},
                {"name": "Hei Chill Peltier (소형 냉각기)", "image": "assets/products/Hei_Chill_Peltier.png"},
                {"name": "Hei Chill Peltier (대형 냉각기)", "image": "assets/products/Hei_Chill_5000.png"},
              ]),
              _buildProductList([
                {"name": "Magnetic Stirrer", "image": "assets/products/Magnetic_stirrer.png"},
                {"name": "오버헤드 교반기", "image": "assets/products/Overhead_stirrer.png"},
              ]),
              _buildProductList([
                {"name": "Hei-Process Cloud Core", "image": "assets/products/Hei-Process_Cloud_Core.png"},
              ]),
              _buildProductList([
                {"name": "Platform shakers", "image": "assets/products/Platform_shakers.png"},
                {"name": "Vortexer", "image": "assets/products/Vortexer.png"},
                {"name": "오버헤드 쉐이커", "image": "assets/products/Overhead_shakers.png"},
              ]),
              _buildProductList([
                {"name": "Liquid handling", "image": "assets/products/Liquid_handling.png"},
              ]),
            ],
          ),
        ),
      ],
    );
  }

  // NORMAG Tab
  Widget _buildNormagTab() {
    return Column(
      children: [
        _buildSubTabBar(["Lab Fast Pro", "Pilot Compact", "Process Reaction System"]),
        Expanded(
          child: TabBarView(
            children: [
              _buildProductList([
                {"name": "Lab Fast Pro", "image": "assets/products/Lab_Fast_Pro.png"},
              ]),
              _buildProductList([
                {"name": "Pilot Compact Reactor (10 ~ 30L)", "image": "assets/products/Pilot_compact_reactor.png"},
              ]),
              _buildProductList([
                {"name": "Glass Reaction System", "image": "assets/products/ReactionSystemPilot.png"},
              ]),
            ],
          ),
        ),
      ],
    );
  }

  // CINC Industry Tab (업데이트 예정)
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
    return GridView.builder(
      padding: EdgeInsets.all(16.0),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16.0,
        mainAxisSpacing: 16.0,
        childAspectRatio: 0.8,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        return _buildProductCard(products[index]["name"]!, products[index]["image"]!);
      },
    );
  }

  // Product Card Widget
  Widget _buildProductCard(String name, String imagePath) {
    return Column(
      children: [
        Expanded(
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
        SizedBox(height: 10),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
