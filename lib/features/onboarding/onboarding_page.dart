import 'package:closet_craft_project/features/auth/pages/login.dart';
import 'package:closet_craft_project/features/auth/pages/signup.dart';
import 'package:closet_craft_project/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;
          final screenType = _getScreenType(screenWidth, screenHeight);
          final isDesktop = screenType == ScreenType.desktop;
          final isTablet = screenType == ScreenType.tablet;

          return Stack(
            children: [
              // Background wardrobe image (faded)
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/wardrobe.jpg'),
                    fit: BoxFit.cover,
                    colorFilter: ColorFilter.mode(
                      Colors.black26,
                      BlendMode.darken,
                    ),
                  ),
                ),
              ),

              // Gradient overlay for better text readability
              Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.3),
                      Colors.black.withOpacity(0.7),
                    ],
                  ),
                ),
              ),

              // Main content
              SafeArea(
                child: isDesktop
                    ? _buildDesktopLayout(context, screenWidth, screenHeight)
                    : _buildMobileTabletLayout(
                        context, screenWidth, screenHeight, isTablet),
              ),
            ],
          );
        },
      ),
    );
  }

  ScreenType _getScreenType(double width, double height) {
    if (kIsWeb) {
      if (width >= 1200) return ScreenType.desktop;
      if (width >= 768) return ScreenType.tablet;
      return ScreenType.mobile;
    }

    // For mobile platforms, use height as primary indicator
    if (height >= 900) return ScreenType.desktop;
    if (height >= 700) return ScreenType.tablet;
    return ScreenType.mobile;
  }

  Widget _buildDesktopLayout(
      BuildContext context, double screenWidth, double screenHeight) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
          maxWidth: 1200,
          maxHeight: screenHeight * 0.9,
        ),
        // Add a defined width to the Row
        child: Container(
          width: 1200, // or screenWidth
          child: Row(
            children: [
              // Left side - Content
              Expanded(
                flex: 1,
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.05,
                    vertical: screenHeight * 0.05,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Logo
                      SizedBox(
                        width: 120,
                        height: 120,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.asset("assets/images/revastra_logo.jpg"),
                        ),
                      ),
                      SizedBox(height: 40),

                      // App title
                      Text(
                        'ReVastra',
                        style: TextStyle(
                          fontSize: 48,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1.5,
                        ),
                      ),

                      SizedBox(height: 16),

                      // Subtitle
                      Text(
                        'Your Smart Wardrobe Companion',
                        style: TextStyle(
                          fontSize: 24,
                          color: Colors.white70,
                          fontWeight: FontWeight.w300,
                        ),
                      ),

                      SizedBox(height: 60),

                      // Feature cards

                      SizedBox(height: 60),
                    ],
                  ),
                ),
              ),

              // Right side - Visual element or additional content
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(32),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _buildDesktopFeatureItem(
                            Icons.inventory_2_outlined,
                            'Organize Your Closet',
                            'Keep track of all your clothes digitally',
                          ),
                          SizedBox(height: 24),
                          _buildDesktopFeatureItem(
                            Icons.wb_sunny_outlined,
                            'Weather-Based Suggestions',
                            'Get outfit recommendations based on weather',
                          ),
                          SizedBox(height: 24),
                          _buildDesktopFeatureItem(
                            Icons.auto_awesome_outlined,
                            'AI-Powered Styling',
                            'Smart recommendations for perfect outfits',
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    // Buttons
                    Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 64,
                            child: ElevatedButton(
                              onPressed: () {
                                moveTo(context, const SignUpPage());
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6366F1),
                                foregroundColor: Colors.white,
                                elevation: 8,
                                shadowColor: Colors.black26,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Get Started',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: SizedBox(
                            height: 64,
                            child: OutlinedButton(
                              onPressed: () {
                                moveTo(context, const LoginPage());
                              },
                              style: OutlinedButton.styleFrom(
                                foregroundColor: Colors.white,
                                side: const BorderSide(
                                    color: Colors.white, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              ),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
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
      ),
    );
  }

  Widget _buildMobileTabletLayout(BuildContext context, double screenWidth,
      double screenHeight, bool isTablet) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: isTablet ? screenWidth * 0.08 : screenWidth * 0.06,
        vertical: isTablet ? 32.0 : 24.0,
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minHeight: screenHeight -
              MediaQuery.of(context).padding.top -
              MediaQuery.of(context).padding.bottom,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: isTablet ? 60 : 40),

            // Logo
            SizedBox(
              width: isTablet ? 120 : 100,
              height: isTablet ? 120 : 100,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(isTablet ? 24 : 20),
                child: Image.asset("assets/images/revastra_logo.jpg"),
              ),
            ),
            SizedBox(height: isTablet ? 40 : 30),

            // App title
            Text(
              'ReVastra',
              style: TextStyle(
                fontSize: isTablet ? 36 : 32,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 1.2,
              ),
            ),

            SizedBox(height: isTablet ? 16 : 12),

            // Subtitle
            Text(
              'Your Smart Wardrobe Companion',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                color: Colors.white70,
                fontWeight: FontWeight.w300,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: isTablet ? 60 : 40),

            // Feature cards
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxWidth: isTablet ? 600 : screenWidth * 0.9,
              ),
              padding: EdgeInsets.all(isTablet ? 28 : 20),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(isTablet ? 20 : 16),
                border: Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  _buildFeatureItem(
                    Icons.inventory_2_outlined,
                    'Organize Your Closet',
                    'Keep track of all your clothes digitally',
                    isTablet,
                  ),
                  SizedBox(height: isTablet ? 24 : 20),
                  _buildFeatureItem(
                    Icons.wb_sunny_outlined,
                    'Weather-Based Suggestions',
                    'Get outfit recommendations based on weather',
                    isTablet,
                  ),
                  SizedBox(height: isTablet ? 24 : 20),
                  _buildFeatureItem(
                    Icons.auto_awesome_outlined,
                    'AI-Powered Styling',
                    'Smart recommendations for perfect outfits',
                    isTablet,
                  ),
                ],
              ),
            ),

            SizedBox(height: isTablet ? 60 : 50),

            // Buttons container
            Container(
              width: double.infinity,
              constraints: BoxConstraints(
                maxWidth: isTablet ? 600 : screenWidth * 0.9,
              ),
              child: Column(
                children: [
                  // Get Started button
                  SizedBox(
                    width: double.infinity,
                    height: isTablet ? 64 : 56,
                    child: ElevatedButton(
                      onPressed: () {
                        moveTo(context, const SignUpPage());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF6366F1),
                        foregroundColor: Colors.white,
                        elevation: 8,
                        shadowColor: Colors.black26,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(isTablet ? 20 : 16),
                        ),
                      ),
                      child: Text(
                        'Get Started',
                        style: TextStyle(
                          fontSize: isTablet ? 20 : 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: isTablet ? 20 : 16),

                  // Secondary button
                  SizedBox(
                    width: double.infinity,
                    height: isTablet ? 64 : 56,
                    child: OutlinedButton(
                      onPressed: () {
                        moveTo(context, const LoginPage());
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.white,
                        side: const BorderSide(color: Colors.white, width: 2),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(isTablet ? 20 : 16),
                        ),
                      ),
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: isTablet ? 20 : 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: isTablet ? 40 : 30),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(
      IconData icon, String title, String description, bool isTablet) {
    return Row(
      children: [
        Container(
          width: isTablet ? 56 : 48,
          height: isTablet ? 56 : 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(isTablet ? 16 : 12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: isTablet ? 28 : 24,
          ),
        ),
        SizedBox(width: isTablet ? 20 : 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: isTablet ? 18 : 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: isTablet ? 6 : 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: isTablet ? 16 : 14,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopFeatureItem(
      IconData icon, String title, String description) {
    return Row(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 32,
          ),
        ),
        SizedBox(width: 24),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                description,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white70,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

enum ScreenType {
  mobile,
  tablet,
  desktop,
}
