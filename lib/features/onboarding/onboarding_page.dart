import 'package:closet_craft_project/features/auth/pages/login.dart';
import 'package:closet_craft_project/features/auth/pages/signup.dart';
import 'package:closet_craft_project/utils/utils.dart';
import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          final screenHeight = constraints.maxHeight;
          final screenWidth = constraints.maxWidth;
          final isSmallScreen = screenHeight < 700;
          final isMediumScreen = screenHeight >= 700 && screenHeight < 900;

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
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(
                    horizontal: screenWidth * 0.06,
                    vertical: isSmallScreen ? 16.0 : 24.0,
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
                        SizedBox(height: isSmallScreen ? 20 : 40),

                        // Logo
                        SizedBox(
                          width: isSmallScreen ? 80 : 100,
                          height: isSmallScreen ? 80 : 100,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child:
                                Image.asset("assets/images/revastra_logo.jpg"),
                          ),
                        ),
                        SizedBox(height: isSmallScreen ? 20 : 40),

                        // App title
                        Text(
                          'ReVastra',
                          style: TextStyle(
                            fontSize: isSmallScreen
                                ? 28
                                : isMediumScreen
                                    ? 32
                                    : 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            letterSpacing: 1.2,
                          ),
                        ),

                        SizedBox(height: isSmallScreen ? 8 : 12),

                        // Subtitle
                        Text(
                          'Your Smart Wardrobe Companion',
                          style: TextStyle(
                            fontSize: isSmallScreen ? 14 : 18,
                            color: Colors.white70,
                            fontWeight: FontWeight.w300,
                          ),
                          textAlign: TextAlign.center,
                        ),

                        SizedBox(height: isSmallScreen ? 30 : 50),

                        // Feature cards
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth:
                                screenWidth > 400 ? 400 : screenWidth * 0.9,
                          ),
                          padding: EdgeInsets.all(isSmallScreen ? 16 : 20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(16),
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
                                isSmallScreen,
                              ),
                              SizedBox(height: isSmallScreen ? 16 : 20),
                              _buildFeatureItem(
                                Icons.wb_sunny_outlined,
                                'Weather-Based Suggestions',
                                'Get outfit recommendations based on weather',
                                isSmallScreen,
                              ),
                              SizedBox(height: isSmallScreen ? 16 : 20),
                              _buildFeatureItem(
                                Icons.auto_awesome_outlined,
                                'AI-Powered Styling',
                                'Smart recommendations for perfect outfits',
                                isSmallScreen,
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: isSmallScreen ? 40 : 60),

                        // Buttons container
                        Container(
                          width: double.infinity,
                          constraints: BoxConstraints(
                            maxWidth:
                                screenWidth > 400 ? 400 : screenWidth * 0.9,
                          ),
                          child: Column(
                            children: [
                              // Get Started button
                              SizedBox(
                                width: double.infinity,
                                height: isSmallScreen ? 48 : 56,
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
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    'Get Started',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 16 : 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: isSmallScreen ? 12 : 16),

                              // Secondary button
                              SizedBox(
                                width: double.infinity,
                                height: isSmallScreen ? 48 : 56,
                                child: OutlinedButton(
                                  onPressed: () {
                                    moveTo(context, const LoginPage());
                                  },
                                  style: OutlinedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    side: const BorderSide(
                                        color: Colors.white, width: 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: Text(
                                    'Sign In',
                                    style: TextStyle(
                                      fontSize: isSmallScreen ? 16 : 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: isSmallScreen ? 20 : 40),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildFeatureItem(
      IconData icon, String title, String description, bool isSmallScreen) {
    return Row(
      children: [
        Container(
          width: isSmallScreen ? 40 : 48,
          height: isSmallScreen ? 40 : 48,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: isSmallScreen ? 20 : 24,
          ),
        ),
        SizedBox(width: isSmallScreen ? 12 : 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontSize: isSmallScreen ? 14 : 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: isSmallScreen ? 2 : 4),
              Text(
                description,
                style: TextStyle(
                  fontSize: isSmallScreen ? 12 : 14,
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
