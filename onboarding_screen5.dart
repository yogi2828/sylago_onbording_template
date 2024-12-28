import 'package:flutter/material.dart';

class OnboardingScreen5 extends StatefulWidget {
  const OnboardingScreen5({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen5> createState() => _OnboardingScreen5State();
}

class _OnboardingScreen5State extends State<OnboardingScreen5> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Smart Features',
      description: 'Tap the icons to explore our innovative features',
      quote: '"Simplicity is the ultimate sophistication"',
      icons: [
        InteractiveIcon(icon: Icons.speed, label: 'Fast'),
        InteractiveIcon(icon: Icons.security, label: 'Secure'),
        InteractiveIcon(icon: Icons.sync, label: 'Sync'),
      ],
      color: Color(0xFF6C63FF),
    ),
    OnboardingPage(
      title: 'Powerful Tools',
      description: 'Click on images to see detailed information',
      quote: '"Make it simple, but significant"',
      icons: [
        InteractiveIcon(icon: Icons.analytics, label: 'Analytics'),
        InteractiveIcon(icon: Icons.notifications, label: 'Alerts'),
        InteractiveIcon(icon: Icons.cloud_done, label: 'Cloud'),
      ],
      color: Color(0xFF4CAF50),
    ),
    OnboardingPage(
      title: 'Stay Connected',
      description: 'Interact with our community features',
      quote: '"Together we can do so much"',
      icons: [
        InteractiveIcon(icon: Icons.group, label: 'Community'),
        InteractiveIcon(icon: Icons.chat, label: 'Chat'),
        InteractiveIcon(icon: Icons.share, label: 'Share'),
      ],
      color: Color(0xFFFF5722),
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
            itemBuilder: (context, index) {
              return _buildPage(_pages[index]);
            },
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
                _buildNavigationButton(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Container(
      color: page.color.withOpacity(0.1),
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            page.title,
            style: TextStyle(
              fontSize: 32,
              fontWeight: FontWeight.bold,
              color: page.color,
            ),
          ),
          SizedBox(height: 20),
          Text(
            page.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 50),
          _buildInteractiveIcons(page.icons, page.color),
          SizedBox(height: 50),
          AnimatedContainer(
            duration: Duration(milliseconds: 300),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: page.color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Text(
              page.quote,
              style: TextStyle(
                fontSize: 16,
                fontStyle: FontStyle.italic,
                color: page.color,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInteractiveIcons(List<InteractiveIcon> icons, Color color) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: icons.map((icon) {
        return GestureDetector(
          onTap: () {
            _showIconDetails(icon, color);
          },
          child: TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: Duration(milliseconds: 500),
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: color.withOpacity(0.1),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        icon.icon,
                        size: 40,
                        color: color,
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      icon.label,
                      style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }).toList(),
    );
  }

  void _showIconDetails(InteractiveIcon icon, Color color) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(icon.icon, color: color),
            SizedBox(width: 10),
            Text(icon.label),
          ],
        ),
        content: Text('Detailed information about ${icon.label} feature'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('Close'),
          ),
        ],
      ),
    );
  }

  Widget _buildPageIndicator(int index) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: _currentPage == index ? 24 : 8,
      decoration: BoxDecoration(
        color: _currentPage == index
            ? _pages[_currentPage].color
            : _pages[_currentPage].color.withOpacity(0.3),
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }

  Widget _buildNavigationButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: () {
          if (_currentPage < _pages.length - 1) {
            _pageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          } else {
            // Navigate to main app
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: _pages[_currentPage].color,
          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          _currentPage < _pages.length - 1 ? 'Next' : 'Get Started',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String quote;
  final List<InteractiveIcon> icons;
  final Color color;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.quote,
    required this.icons,
    required this.color,
  });
}

class InteractiveIcon {
  final IconData icon;
  final String label;

  InteractiveIcon({
    required this.icon,
    required this.label,
  });
}
