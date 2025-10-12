import 'package:closet_craft_project/features/auth/provider/auth_provider.dart';
import 'package:closet_craft_project/features/bottom_navigation/bottom_navigation.dart';
import 'package:closet_craft_project/utils/utils.dart';
import 'package:closet_craft_project/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
//import 'login.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late final AuthenProvider authenProvider;

  @override
  void initState() {
    authenProvider = AuthenProvider();
    super.initState();
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _fullnameController = TextEditingController();

  // Gender selection variable
  String? _selectedGender;
  final List<String> _genderOptions = ['Male', 'Female'];

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
                'Create Account',
                style: context.responsiveTextStyle(
                  fontSize: isIPhoneProMax ? 36 : (isTabletOrLarger ? 34 : 32),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: context.responsiveSpacing(8)),
              Text(
                'Sign up to get started!',
                style: context.responsiveTextStyle(
                  fontSize: isIPhoneProMax ? 18 : (isTabletOrLarger ? 17 : 16),
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: context.responsiveSpacing(40)),

              // Full Name
              TextField(
                controller: _fullnameController,
                decoration: InputDecoration(
                  hintText: 'Full Name',
                  filled: true,
                  fillColor: Colors.grey[100],
                  prefixIcon: Icon(
                    Icons.person_outline,
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
              SizedBox(height: context.responsiveSpacing(20)),

              // Gender Selection Dropdown
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius:
                      BorderRadius.circular(context.responsiveSpacing(12)),
                ),
                child: DropdownButtonFormField<String>(
                  value: _selectedGender,
                  hint: Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Colors.grey,
                        size: context.responsiveIconSize(20),
                      ),
                      SizedBox(width: context.responsiveSpacing(12)),
                      Text(
                        'Select Gender',
                        style: context.responsiveTextStyle(
                          color: Colors.grey,
                          fontSize: isIPhoneProMax ? 16 : 14,
                        ),
                      ),
                    ],
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[100],
                    border: OutlineInputBorder(
                      borderRadius:
                          BorderRadius.circular(context.responsiveSpacing(12)),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: context.responsiveSpacing(16),
                      vertical: context.responsiveSpacing(16),
                    ),
                  ),
                  items: _genderOptions.map((String gender) {
                    return DropdownMenuItem<String>(
                      value: gender,
                      child: Text(
                        gender,
                        style: context.responsiveTextStyle(
                          fontSize: isIPhoneProMax ? 16 : 14,
                        ),
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  icon: Icon(
                    Icons.arrow_drop_down,
                    size: context.responsiveIconSize(20),
                  ),
                ),
              ),

              SizedBox(height: context.responsiveSpacing(20)),

              // Sign Up button
              ListenableBuilder(
                  listenable: authenProvider,
                  builder: (context, _) {
                    if (authenProvider.loading) {
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
                          // Validation for gender selection
                          if (_selectedGender == null) {
                            showSnackBar(context, "Please select your gender");
                            return;
                          }

                          final res = await authenProvider.signup(
                              _emailController.text.trim(),
                              _passwordController.text.trim(),
                              _fullnameController.text.trim(),
                              _selectedGender!); // Pass gender to signup method
                          if (context.mounted) {
                            if (res) {
                              moveUntil(context, const HomeScreen());
                            } else {
                              showSnackBar(context, "Something went wrong!!");
                            }
                          }
                        },
                        child: Text(
                          'Sign Up',
                          style: context.responsiveTextStyle(
                            fontSize: isIPhoneProMax ? 18 : 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    );
                  }),

              SizedBox(height: context.responsiveSpacing(30)),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account?",
                    style: context.responsiveTextStyle(
                      fontSize: isIPhoneProMax ? 16 : 14,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Login',
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
