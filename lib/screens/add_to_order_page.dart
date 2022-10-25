import 'package:flutter/material.dart';
import 'package:flutter_delivery/models/cafe_model.dart';
import 'package:flutter_delivery/screens/home_page.dart';
import 'package:flutter_delivery/utils/myColors.dart';
import 'package:flutter_delivery/utils/myImages.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class AddToPage extends StatefulWidget {
  Map cafeInfo;
  AddToPage({super.key, required this.cafeInfo});

  @override
  State<AddToPage> createState() => _AddToPageState();
}

class _AddToPageState extends State<AddToPage> {
  int count = 0;
  num price = 0;
  Map checkingTop = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
  };
  Map checkingBottom = {
    0: false,
    1: false,
    2: false,
    3: false,
    4: false,
    5: false,
    6: false,
    7: false,
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: SingleChildScrollView(
        child: Column(
          children: [
            imageStack(context),
            SizedBox(height: 24.h),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.cafeInfo["name"],
                    style: GoogleFonts.roboto(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        color: MyColors.C_010F07),
                  ),
                  SizedBox(height: 14.h),
                  Text(
                    "Bu yerda sizning reklamangiz bo'lishi mumkin edi :)",
                    style: GoogleFonts.roboto(
                        fontSize: 16.sp,
                        color: MyColors.C_010F07.withOpacity(0.64)),
                  ),
                  SizedBox(height: 20.h),
                  textsRow(widget.cafeInfo),
                  SizedBox(height: 32.h),
                  typeRow("Choice of top Cookie"),
                  SizedBox(height: 24.h),
                  chooseListview(checkingTop),
                  const Divider(),
                  SizedBox(height: 34.h),
                  typeRow("Choice of Bottom Cookie"),
                  SizedBox(height: 24.h),
                  chooseListview(checkingBottom),
                  const Divider(),
                  SizedBox(height: 48.h),
                  specialRow(),
                  SizedBox(height: 12.h),
                  Divider(),
                  SizedBox(height: 32.h),
                  calculatingRow(),
                  SizedBox(height: 12.h),
                  Center(
                    child: ElevatedButton(
                        onPressed: (() {}),
                        child: Text("Add to Order (\$${price})")),
                  ),
                  SizedBox(height: 24.h),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }

  Row calculatingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            setState(() {
              if (count > 0) {
                price = price - widget.cafeInfo["price"];
                count--;
              }
            });
          },
          child: Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: MyColors.C_F8F8F8),
              child: Center(
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 36.sp, color: MyColors.C_010F07),
                ),
              )),
        ),
        SizedBox(width: 20.w),
        Text(
          "$count",
          style: const TextStyle(fontSize: 20, color: MyColors.C_010F07),
        ),
        SizedBox(width: 20.w),
        InkWell(
          onTap: () {
            setState(() {
              count++;
              price = widget.cafeInfo["price"] + price ?? 0;
            });
          },
          child: Container(
              height: 54,
              width: 54,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: MyColors.C_F8F8F8),
              child: Center(
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 36.sp, color: MyColors.C_010F07),
                ),
              )),
        ),
      ],
    );
  }

  Row specialRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Add Special Instructions",
          style: GoogleFonts.roboto(
              fontSize: 16.sp, color: MyColors.C_010F07.withOpacity(0.74)),
        ),
        Icon(Icons.keyboard_arrow_right, color: Colors.black, size: 28.sp)
      ],
    );
  }

  ListView chooseListview(map) {
    return ListView.separated(
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              setState(() {
                map.forEach((key, value) {
                  map[key] = false;
                });
                map[index] = true;
              });
            },
            child: Row(children: [
              map[index] ? selectedBox() : unSelectedBox(),
              SizedBox(width: 8.w),
              Text(
                CafesModel.choose[index],
                style: GoogleFonts.roboto(
                    fontSize: 16.sp, color: MyColors.C_010F07),
              )
            ]),
          );
        },
        separatorBuilder: (context, index) {
          return Divider();
        },
        itemCount: CafesModel.choose.length);
  }

  Container selectedBox() {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 24,
      width: 24,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: MyColors.C_868686),
      ),
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.green),
      ),
    );
  }

  Container unSelectedBox() {
    return Container(
        height: 24,
        width: 24,
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: MyColors.C_868686)));
  }

  Stack imageStack(BuildContext context) {
    return Stack(children: [
      Container(
        height: 280.h,
        width: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(widget.cafeInfo["image"]),
                fit: BoxFit.cover)),
      ),
      Positioned(
          left: 20,
          top: 54,
          child: InkWell(
            onTap: () {
              setState(() {
                Navigator.pop(context);
              });
            },
            child: const Image(
              image: AssetImage(
                MyImages.close,
              ),
              height: 34,
              width: 34,
            ),
          ))
    ]);
  }

  Row typeRow(txt) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(txt,
            style: GoogleFonts.roboto(
                fontSize: 20.sp,
                color: MyColors.C_010F07,
                fontWeight: FontWeight.w600)),
        Container(
          width: 90.w,
          height: 32.h,
          decoration: BoxDecoration(
            color: MyColors.C_EF9920.withOpacity(0.2),
            borderRadius: BorderRadius.circular(4.r),
          ),
          child: Center(
            child: Text(
              "REQUIRED",
              style: GoogleFonts.roboto(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                  color: MyColors.C_EF9920),
            ),
          ),
        )
      ],
    );
  }
}
