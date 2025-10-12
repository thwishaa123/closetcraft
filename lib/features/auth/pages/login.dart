import 'package:closet_craft_project/features/auth/pages/signup.dart';
import 'package:closet_craft_project/features/auth/provider/auth_provider.dart';
import 'package:closet_craft_project/features/bottom_navigation/bottom_navigation.dart';
import 'package:closet_craft_project/utils/utils.dart';
import 'package:closet_craft_project/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isIPhoneProMax = context.isIPhoneProMax;
    final isTabletOrLarger = context.isTabletOrLarger;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          padding: context.responsivePadding,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Welcome Back!',
                style: context.responsiveTextStyle(
                  fontSize: isIPhoneProMax ? 36 : (isTabletOrLarger ? 34 : 32),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: context.responsiveSpacing(8)),
              Text(
                'Login to your account',
                style: context.responsiveTextStyle(
                  fontSize: isIPhoneProMax ? 18 : (isTabletOrLarger ? 17 : 16),
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: context.responsiveSpacing(40)),

              // Email
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  hintText: 'Email',
                  filled: true,
                  fillColor: Colors.grey[100],
                  prefixIcon: Icon(
                    Icons.email_outlined,
                    size: context.responsiveIconSize(20),
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(context.responsiveSpacing(12)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: context.responsiveSpacing(16),
                    vertical: context.responsiveSpacing(16),
                  ),
                  hintStyle: context.responsiveTextStyle(
                    fontSize: isIPhoneProMax ? 16 : 14,
                  ),
                ),
                style: context.responsiveTextStyle(
                  fontSize: isIPhoneProMax ? 16 : 14,
                ),
              ),
              SizedBox(height: context.responsiveSpacing(20)),

              // Password
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  filled: true,
                  fillColor: Colors.grey[100],
                  prefixIcon: Icon(
                    Icons.lock_outline,
                    size: context.responsiveIconSize(20),
                  ),
                  border: OutlineInputBorder(
                    borderRadius:
                        BorderRadius.circular(context.responsiveSpacing(12)),
                    borderSide: BorderSide.none,
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: context.responsiveSpacing(16),
                    vertical: context.responsiveSpacing(16),
                  ),
                  hintStyle: context.responsiveTextStyle(
                    fontSize: isIPhoneProMax ? 16 : 14,
                  ),
                ),
                style: context.responsiveTextStyle(
                  fontSize: isIPhoneProMax ? 16 : 14,
                ),
              ),

              SizedBox(height: context.responsiveSpacing(10)),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    'Forgot Password?',
                    style: context.responsiveTextStyle(
                      fontSize: isIPhoneProMax ? 16 : 14,
                    ),
                  ),
                ),
              ),

              SizedBox(height: context.responsiveSpacing(20)),

              // Login button
              Consumer<AuthenProvider>(
                builder: (context, provider, _) {
                  if (provider.loading) {
                    return Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                      ),
                    );
                  }
                  return SizedBox(
                    width: double.infinity,
                    height: context.responsiveButtonHeight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurple,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                              context.responsiveSpacing(12)),
                        ),
                      ),
                      onPressed: () async {
                        final res = await provider.login(
                            _emailController.text.trim(),
                            _passwordController.text.trim());
                        if (context.mounted) {
                          if (res) {
                            moveUntil(context, const HomeScreen());
                          } else {
                            showSnackBar(context,
                                provider.error ?? "Something went wrong!!");
                          }
                        }
                      },
                      child: Text(
                        'Login',
                        style: context.responsiveTextStyle(
                          fontSize: isIPhoneProMax ? 18 : 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                },
              ),

              SizedBox(height: context.responsiveSpacing(30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: context.responsiveTextStyle(
                      fontSize: isIPhoneProMax ? 16 : 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      moveTo(context, SignUpPage());
                    },
                    child: Text(
                      'Sign Up',
                      style: context.responsiveTextStyle(
                        fontSize: isIPhoneProMax ? 16 : 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
