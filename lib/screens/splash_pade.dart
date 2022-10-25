import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_delivery/screens/home_page.dart';
import 'package:flutter_delivery/screens/signIn_page.dart';
import 'package:flutter_delivery/utils/myColors.dart';
import 'package:flutter_delivery/utils/myImages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPage();
}

class _SplashPage extends State<SplashPage> {
  bool isLog = false;

  Future<bool> isLoggedIn() async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    isLog = _pref.getBool("isLoggedIn") ?? false;
    return _pref.getBool("isLoggedIn") ?? false;
  }

  @override
  void initState() {
    super.initState();

    isLoggedIn();
    goNext();
  }

  void goNext() {
    Future.delayed(Duration(seconds: 3)).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) {
            return isLog ? HomePage() : SignInPage();
          },
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.C_E5E5E5,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 28).r,
          child: splashWidgets(),
        ),
      ),
    );
  }

  Column splashWidgets() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          image: const AssetImage(MyImages.splashImage),
          height: 299.h,
          width: 299.w,
        ),
        const SizedBox(height: 70),
        Text(
          "Free delivery offers",
          style: GoogleFonts.roboto(
              fontSize: 30.sp,
              color: MyColors.C_010F07,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(height: 20),
        Text(
          "Free delivery for new customers via Apple Pay and others payment methods.",
          style: GoogleFonts.roboto(
            fontSize: 16.sp,
            color: MyColors.C_010F07,
            fontWeight: FontWeight.w300,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
