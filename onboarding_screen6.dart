import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class OnboardingScreen6 extends StatefulWidget {
  const OnboardingScreen6({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen6> createState() => _OnboardingScreen6State();
}

class _OnboardingScreen6State extends State<OnboardingScreen6> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<StoryPage> _pages = [
    StoryPage(
      title: 'Once Upon a Time...',
      description:
          'In a world full of chaos and disorganization, people struggled to manage their daily tasks.',
      animation: 'assets/animations/story_chaos.json',
      backgroundColor: Color(0xFFFFF3E0),
      textColor: Color(0xFF5D4037),
    ),
    StoryPage(
      title: 'Then Came a Solution',
      description:
          'A powerful tool emerged, designed to bring order and efficiency to everyone\'s life.',
      animation: 'assets/animations/story_solution.json',
      backgroundColor: Color(0xFFE8F5E9),
      textColor: Color(0xFF2E7D32),
    ),
    StoryPage(
      title: 'The Magic of Organization',
      description:
          'With smart features and intuitive design, managing tasks became as simple as magic.',
      animation: 'assets/animations/story_magic.json',
      backgroundColor: Color(0xFFE3F2FD),
      textColor: Color(0xFF1565C0),
    ),
    StoryPage(
      title: 'Your Journey Begins',
      description:
          'Now it\'s your turn to experience the transformation. Are you ready to begin?',
      animation: 'assets/animations/story_journey.json',
      backgroundColor: Color(0xFFF3E5F5),
      textColor: Color(0xFF6A1B9A),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) {
              setState(() {
                _currentPage = index;
              });
            },
            itemBuilder: (context, index) => _buildStoryPage(_pages[index]),
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => _buildPageIndicator(index),
                  ),
                ),
                SizedBox(height: 20),
                if (_currentPage == _pages.length - 1)
                  _buildStartJourneyButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStoryPage(StoryPage page) {
    return Container(
      color: page.backgroundColor,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            page.animation,
            height: 300,
            repeat: true,
          ),
          SizedBox(height: 40),
          Text(
            page.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: page.textColor,
              fontFamily: 'Playfair Display',
            ),
          ),
          SizedBox(height: 20),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: page.textColor.withOpacity(0.8),
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    bool isCurrentPage = _currentPage == index;
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: isCurrentPage ? 24 : 8,
      decoration: BoxDecoration(
        color: _pages[_currentPage].textColor.withOpacity(
              isCurrentPage ? 1 : 0.3,
            ),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildStartJourneyButton() {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: _pages[_currentPage].textColor.withOpacity(0.3),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to main app
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: _pages[_currentPage].textColor,
                padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Start Your Journey',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(width: 10),
                  Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class StoryPage {
  final String title;
  final String description;
  final String animation;
  final Color backgroundColor;
  final Color textColor;

  StoryPage({
    required this.title,
    required this.description,
    required this.animation,
    required this.backgroundColor,
    required this.textColor,
  });
}
