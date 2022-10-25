import 'package:flutter/material.dart';
import 'package:flutter_delivery/screens/home_page.dart';
import 'package:flutter_delivery/screens/signUp_page.dart';
import 'package:flutter_delivery/utils/myColors.dart';
import 'package:flutter_delivery/utils/myImages.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _text = TextEditingController();
  final _txt = TextEditingController();
  bool _validate = true;
  bool _validatePass = false;
  bool _visibility = true;

  @override
  void dispose() {
    _txt.dispose();
    _text.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16.h),
                Text(
                  "Welcome to",
                  style: GoogleFonts.roboto(
                      fontSize: 34.sp, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Enter your Phone number or Email\naddress for sign in. Enjoy your food :)",
                  style: GoogleFonts.roboto(
                      fontSize: 16.sp, color: MyColors.C_868686),
                ),
                SizedBox(height: 36.h),
                Text(
                  "Email address",
                  style: GoogleFonts.roboto(
                      fontSize: 12.sp, color: MyColors.C_868686),
                ),
                emailField(),
                passwordRow(),
                passwordField(),
                SizedBox(height: 20.h),
                Center(
                  child: Text("Forgot Password?",
                      style: GoogleFonts.roboto(
                        fontSize: 12.sp,
                        color: MyColors.C_010F07,
                      )),
                ),
                SizedBox(height: 24.h),
                signInButton(context),
                SizedBox(height: 24.h),
                textRow(),
                SizedBox(height: 28.h),
                Center(
                  child: Text("Or",
                      style: GoogleFonts.roboto(
                          fontSize: 16.sp, color: MyColors.C_010F07)),
                ),
                SizedBox(height: 28.h),
                socialButton("Connect with Facebook", MyImages.facebook,
                    MyColors.C_395998),
                SizedBox(height: 24.h),
                socialButton(
                    "Connect with google", MyImages.google, MyColors.C_4285F4)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Row textRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Don’t have account?",
          style: GoogleFonts.roboto(fontSize: 12.sp, color: MyColors.C_010F07),
        ),
        SizedBox(width: 4.w),
        Text(
          "Create new account.?",
          style: GoogleFonts.roboto(fontSize: 12.sp, color: MyColors.C_22A45D),
        ),
      ],
    );
  }

  InkWell signInButton(BuildContext context) {
    return InkWell(
        onTap: (() {
          if (_validate == false && _validatePass == true) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const SignUpPage()));
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
                "SIGN IN",
                style: GoogleFonts.roboto(fontSize: 14.sp, color: Colors.white),
              ),
            )));
  }

  Row passwordRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Password",
          style: GoogleFonts.roboto(fontSize: 12.sp, color: MyColors.C_868686),
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
    );
  }

  TextField passwordField() {
    return TextField(
      controller: _txt,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        errorText: _validatePass ? null : 'Password Can\'t Be Empty',
      ),
      onChanged: (value) {
        setState(() {
          if (_txt.text.isEmpty) {
            _validatePass = false;
          } else {
            _validatePass = true;
          }
        });
      },
      obscureText: _visibility,
    );
  }

  TextField emailField() {
    return TextField(
      controller: _text,
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
          errorText: _validate ? 'Email Can\'t Be Empty' : null,
          suffixIcon: Icon(
            _validate ? Icons.close : Icons.check,
            color: _validate ? Colors.red : Colors.green,
          )),
      onChanged: (value) {
        setState(() {
          if (_text.text.isNotEmpty) {
            _validate = false;
          } else {
            _validate = true;
          }
        });
      },
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: null,
      backgroundColor: Colors.white,
      centerTitle: true,
      elevation: 0,
      title: Text(
        "Forgot Password",
        style: GoogleFonts.roboto(
            fontSize: 16.sp,
            color: MyColors.C_010F07,
            fontWeight: FontWeight.w700),
      ),
    );
  }
}

Container socialButton(text, image, color) {
  return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      width: double.infinity,
      height: 44.h,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(8.r)),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image(image: AssetImage(image), width: 28.h, height: 28.h),
            Text(
              text,
              style: GoogleFonts.roboto(
                  fontSize: 14.sp,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: 8.w,
            )
          ],
        ),
      ));
}
