import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_delivery/screens/home_page.dart';
import 'package:flutter_delivery/screens/signIn_page.dart';
import 'package:flutter_delivery/utils/myColors.dart';
import 'package:flutter_delivery/utils/myImages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _textName = TextEditingController();
  final _textPassvword = TextEditingController();
  final _textEmail = TextEditingController();
  bool _validateName = true;
  bool _validatePassword = false;
  bool _validateEmail = true;
  bool _visibility = true;

  @override
  void dispose() {
    _textName.dispose();
    _textPassvword.dispose();
    _textEmail.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 12.h),
              Text(
                "Create Account",
                style: GoogleFonts.roboto(
                    fontSize: 34.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: 18.h),
              Text(
                "Enter your Name, Email and Password\nfor sign up. Already have account?",
                style: GoogleFonts.roboto(
                    fontSize: 16.sp, color: MyColors.C_868686),
              ),
              SizedBox(height: 28.h),
              infoText("Full name"),
              nameTextfield(),
              SizedBox(height: 14.h),
              infoText("Email address"),
              emailTextField(),
              SizedBox(height: 8.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "Password",
                    style: GoogleFonts.roboto(
                        fontSize: 12.sp, color: MyColors.C_868686),
                  ),
                  TextButton(
                      onPressed: () {
                        setState(() {
                          _visibility = !_visibility;
                        });
                      },
                      child: Icon(_visibility
                          ? Icons.visibility_off
                          : Icons.remove_red_eye_sharp))
                ],
              ),
              passwordTextField(),
              SizedBox(height: 22.h),
              signUpButton(context),
              SizedBox(height: 14.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.w),
                child: Text(
                  "By Signing up you agree to our Terms Conditions & Privacy Policy.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.roboto(
                      fontSize: 14.sp, color: MyColors.C_868686),
                ),
              ),
              SizedBox(height: 14.h),
              Center(
                child: Text("Or",
                    style: GoogleFonts.roboto(
                        fontSize: 16.sp, color: MyColors.C_010F07)),
              ),
              SizedBox(height: 18.h),
              socialButton("Connect with Facebook", MyImages.facebook,
                  MyColors.C_395998),
              SizedBox(height: 16.h),
              socialButton(
                  "Connect with google", MyImages.google, MyColors.C_4285F4)
            ],
          ),
        ),
      )),
    );
  }

  InkWell signUpButton(BuildContext context) {
    return InkWell(
        onTap: (() {
          if (_validateName == false &&
              _validateEmail == false &&
              _validatePassword == true) {
            saveLogin(context);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomePage()));
          }
        }),
        child: Container(
            width: double.infinity,
            height: 48.h,
            decoration: BoxDecoration(
                color: MyColors.C_22A45D,
                borderRadius: BorderRadius.circular(8.r)),
            child: Center(
              child: Text(
                "SIGN UP",
                style: GoogleFonts.roboto(fontSize: 14.sp, color: Colors.white),
              ),
            )));
  }

  TextField passwordTextField() {
    return TextField(
      controller: _textPassvword,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorText: _validatePassword ? null : 'Password Can\'t Be Empty',
      ),
      onChanged: (value) {
        setState(() {
          if (_textPassvword.text.isEmpty) {
            _validatePassword = false;
          } else {
            _validatePassword = true;
          }
        });
      },
      obscureText: _visibility,
    );
  }

  Text infoText(txt) {
    return Text(
      txt,
      style: GoogleFonts.roboto(fontSize: 12.sp, color: MyColors.C_868686),
    );
  }

  TextField emailTextField() {
    return TextField(
      controller: _textEmail,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          errorText: _validateEmail ? 'Email Can\'t Be Empty' : null,
          suffixIcon: Icon(
            _validateEmail ? Icons.close : Icons.check,
            color: _validateEmail ? Colors.red : Colors.green,
          )),
      onChanged: (value) {
        setState(() {
          if (_textEmail.text.isNotEmpty) {
            _validateEmail = false;
          } else {
            _validateEmail = true;
          }
        });
      },
    );
  }

  TextField nameTextfield() {
    return TextField(
      controller: _textName,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          errorText: _validateName ? 'Name Can\'t Be Empty' : null,
          suffixIcon: Icon(
            _validateName ? Icons.close : Icons.check,
            color: _validateName ? Colors.red : Colors.green,
          )),
      onChanged: (value) {
        setState(() {
          if (_textName.text.isNotEmpty) {
            _validateName = false;
          } else {
            _validateName = true;
          }
        });
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back_ios,
          size: 16.sp,
          color: Colors.black,
        ),
      ),
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      title: Text(
        "Create Account",
        style: GoogleFonts.roboto(
            fontSize: 16.sp,
            color: MyColors.C_010F07,
            fontWeight: FontWeight.w700),
      ),
    );
  }

  void saveLogin(context) async {
    SharedPreferences _pref = await SharedPreferences.getInstance();
    _pref.setBool("isLoggedIn", true);

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomePage()));
  }
}
