import 'package:flutter/material.dart';
// Home 페이지 (기존의 Main 페이지)
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Main section
          Container(
            width: double.infinity,
            height: 600,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/main-background2.png'),
                fit: BoxFit.cover,
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/logo-white.png', width: 400),
                SizedBox(height: 60),
                Text("New Chem", style: TextStyle(fontSize: 40, color: Colors.white, fontWeight: FontWeight.bold)),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildBrandButton("Heidolph", "assets/heidolph_logo.png"),
                    buildBrandButton("NORMAG", "assets/normag_logo.png"),
                    buildBrandButton("CINC_Industry", "assets/CINCIndustry.png"),
                  ],
                ),
              ],
            ),
          ),
          // Product section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Text("PRODUCT", style: TextStyle(fontSize: 15, color: Colors.red, fontWeight: FontWeight.bold)),
                Text("대표 제품", style: TextStyle(fontSize: 35)),
                SizedBox(height: 20),
                GridView.count(
                  shrinkWrap: true,
                  crossAxisCount: 3,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                  children: [
                    buildProductCard("Hei-VAP Series (탁상형 농축기)", "assets/products/Hei-VAP_Series.png"),
                    buildProductCard("Magnetic Stirrer (자력 교반기)", "assets/products/Magnetic_stirrer.png"),
                    buildProductCard("오버헤드 교반기", "assets/products/Overhead_stirrer.png"),
                    buildProductCard("Lab Fast Pro", "assets/products/Lab_Fast_Pro.png"),
                    buildProductCard("Pilot Compact Reactor (10 ~ 30L)", "assets/products/Pilot_compact_reactor.png"),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget for brand buttons
  Widget buildBrandButton(String brandName, String imagePath) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Column(
        children: [
          Image.asset(imagePath, width: 250, height: 40),
          Text(brandName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  // Widget for product card
  Widget buildProductCard(String title, String imagePath) {
    return Column(
      children: [
        Image.asset(imagePath, width: 150, height: 150),
        Text(title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue)),
        Text("제품에 대한 설명을 여기에 넣을 수 있습니다.", textAlign: TextAlign.center),
      ],
    );
  }
}