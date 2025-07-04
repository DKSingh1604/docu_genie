import 'package:docu_genie/functions/functions.dart';
import 'package:docu_genie/lists/document.dart';
import 'package:docu_genie/screens/tipsAndGuide.dart';
import 'package:flutter/material.dart';
import 'package:docu_genie/widgets/home_screen_widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  double _currentPage = 0.0;

  @override
  void initState() {
    super.initState();
    // Set initial page to a high value for infinite scroll effect
    _pageController = PageController(viewportFraction: 0.8, initialPage: 1000);
    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final titleFontSize = screenWidth < 600 ? 28.0 : 34.0;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            colors: [Color(0xFF1D1E33), Color(0xFF0A0E21)],
            center: Alignment.center,
            radius: 0.8,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05, vertical: 20),
                child: ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Colors.lightBlueAccent, Colors.purpleAccent],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: Text(
                    'DocuGenie',
                    style: TextStyle(
                      fontSize: titleFontSize,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: screenHeight * 0.55,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: 10000, // Large number for infinite effect
                  itemBuilder: (context, index) {
                    final docIndex = index % documents.length;
                    final scale = (1 - (_currentPage - index).abs() * 0.2)
                        .clamp(0.8, 1.0);
                    return Transform.scale(
                      scale: scale,
                      child: buildFeaturedCard(context, documents[docIndex],
                          (doc) => Functions.navigateToForm(context, doc)),
                    );
                  },
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(top: 16.0),
                child: Center(
                  child: Text(
                    '< Slide to Explore >',
                    style: TextStyle(
                      color: Colors.white24,
                      fontSize: 14,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildQuickAccessButton(
                            context, 'Recent Docs', Icons.history, () {}),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _buildQuickAccessButton(
                            context, 'Tips & Guide', Icons.lightbulb_outline,
                            () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Tipsandguide(),
                            ),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickAccessButton(
      BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return ElevatedButton(
      onPressed: onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF1D1E33).withOpacity(0.8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.white.withOpacity(0.2)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: Colors.white, size: 24),
          const SizedBox(height: 5),
          Text(
            title,
            style: const TextStyle(color: Colors.white, fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
