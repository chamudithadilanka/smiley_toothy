import 'package:flutter/material.dart';
import 'package:smiley_toothy/color_theme/color_theme.dart';
import 'package:smiley_toothy/models/user_model.dart';
import 'package:smiley_toothy/screens/nav_bar_with_main_screen/main_screen.dart';
import 'package:smiley_toothy/screens/register_screen/widget/custom_button.dart';
import 'package:smiley_toothy/screens/register_screen/widget/custom_text_filed.dart';

import '../../service/hive_service.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  // ── Controllers (NEW) ──────────────────────────────────────
  final _nameController  = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController   = TextEditingController();
  String? selectGender;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _ageController.dispose();
    super.dispose();
  }

  // ── Save to Hive + Navigate (NEW) ─────────────────────────
  void _onRegister() {
    final name  = _nameController.text.trim();
    final email = _emailController.text.trim();
    final age   = int.tryParse(_ageController.text.trim());

    // Basic validation
    if (name.isEmpty || email.isEmpty || age == null || selectGender == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please fill all fields'),
          backgroundColor: Colors.redAccent,
        ),
      );
      return;
    }

    // Save user to Hive
    HivService.saveUser(UserModel(
      name:   name,
      email:  email,
      age:    age,
      gender: selectGender!,
    ));

    // Navigate (your existing navigation)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const MainScreenWithNavBar(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth  = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: screenWidth,
          height: screenHeight * 1.0,
          decoration: BoxDecoration(
            gradient: RadialGradient(
              colors: [kMainBackgroundBlueNormal, kMainBackgroundBlueDark],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: screenHeight * 0.08),
                Image.asset("assets/image/create_account.png", width: 380),
                SizedBox(height: screenHeight * 0.05),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100),
                  child: Container(
                    width: screenWidth * 0.44,
                    height: screenHeight * 0.19,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      boxShadow: [
                        BoxShadow(
                          color: kMainLoadingWhitContainerColor.withValues(alpha: 0.2),
                          spreadRadius: 3,
                          blurRadius: 3,
                        ),
                      ],
                      border: Border.all(
                        color: kMainLoadingIndicatorYellowdark,
                        width: 3,
                      ),
                      image: const DecorationImage(
                        image: AssetImage("assets/image/splash_screen_teeth.png"),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.06),

                // ── Name field (controller added) ──
                CustomTextInputRegisterScreen(
                  controller: _nameController,   // ← ADD THIS
                  hintText: "Enter Your Name",
                  isNumber: false,
                  isHintText: true,
                  boarderRadius: 35,
                ),
                SizedBox(height: screenHeight * 0.02),

                // ── Email field (controller added) ──
                CustomTextInputRegisterScreen(
                  controller: _emailController,  // ← ADD THIS
                  hintText: "Enter Your Email",
                  isNumber: false,
                  isHintText: true,
                  boarderRadius: 35,
                ),
                SizedBox(height: screenHeight * 0.02),

                // ── Age row (controller added) ──
                Row(
                  children: [
                    SizedBox(width: screenWidth * 0.07),
                    Text(
                      "Enter Your Age : ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: kMainLoadingIndicatorYellowdark,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        child: CustomTextInputRegisterScreen(
                          controller: _ageController,  // ← ADD THIS
                          isHintText: true,
                          hintText: "ex - 15",
                          isNumber: true,
                          boarderRadius: 100,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenHeight * 0.02),
                // ── Gender dropdown (unchanged) ──
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    SizedBox(width: screenWidth * 0.07),
                    Text(
                      "Select Gender  : ",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: kMainLoadingIndicatorYellowdark,
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                    Expanded(
                      child: SizedBox(
                        width: screenWidth * 0.04,
                        child: DropdownButtonFormField<String>(
                          value: selectGender,
                          hint: const Text(
                            "Select",
                            style: TextStyle(color: Colors.white),
                          ),
                          style: TextStyle(
                            color: kMainLoadingWhitContainerColor.withValues(alpha: 0.6),
                            fontSize: 18,
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 15,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainLoadingIndicatorYellowdark,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: kMainLoadingIndicatorYellowdark,
                                width: 3,
                              ),
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          dropdownColor: Colors.white,
                          items: ["Male", "Female"].map((item) {
                            return DropdownMenuItem(
                              value: item,
                              child: Text(
                                item,
                                style: TextStyle(
                                  color: kMainLoadingIndicatorYellowdark,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() => selectGender = value);
                          },
                        ),
                      ),
                    ),
                    SizedBox(width: screenWidth * 0.05),
                  ],
                ),
                SizedBox(height: screenHeight * 0.11),

                // ── Button (onPress now calls _onRegister) ──
                CustomButtonRegister(
                  onPress: _onRegister,  // ← CHANGED from inline Navigator to _onRegister
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}