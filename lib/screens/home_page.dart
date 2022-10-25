import 'package:flutter/material.dart';
import 'package:flutter_delivery/models/cafe_model.dart';
import 'package:flutter_delivery/screens/add_to_order_page.dart';
import 'package:flutter_delivery/utils/myColors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: bottomBar(),
      backgroundColor: Colors.white,
      appBar: appBar(),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(children: [
                  cafesLIstView(CafesModel.CafeList as List),
                  SizedBox(height: 14.h),
                  typeInfoRow("Type of Foods", "See all"),
                  SizedBox(height: 24.h),
                  SizedBox(height: 140.h, child: TypeFoodListBuilder()),
                  SizedBox(height: 16.h),
                  typeInfoRow("New Restaurants", "See all"),
                  SizedBox(height: 20.h),
                  SizedBox(
                    height: 220,
                    child: RestaurantListviewBuilder(),
                  )
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }

  BottomNavigationBar bottomBar() {
    return BottomNavigationBar(
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.green,
      selectedLabelStyle: const TextStyle(color: Colors.green),
      currentIndex: _selectedIndex, //New
      onTap: _onItemTapped,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.local_restaurant_outlined,
            ),
            label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
          ),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.list_alt,
          ),
          label: 'Orders',
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.person,
          ),
          label: 'Profile',
        ),
      ],
    );
  }

  Expanded RestaurantListviewBuilder() => Expanded(
          child: ListView.separated(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: CafesModel.RestaurantList.length,
        itemBuilder: (context, index) {
          Map restaurant = CafesModel.RestaurantList[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  height: 160.h,
                  width: 200.w,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(restaurant["image"]),
                        fit: BoxFit.cover),
                  )),
              SizedBox(height: 14.h),
              Text(
                restaurant["name"],
                style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    color: MyColors.C_010F07),
              ),
              SizedBox(height: 4.h),
              Text("Colarodo, San Francisco",
                  style: GoogleFonts.roboto(
                      fontSize: 16.sp, color: MyColors.C_868686))
            ],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 14.w);
        },
      ));

  Widget TypeFoodListBuilder() {
    return Expanded(
      child: ListView.separated(
        physics: ClampingScrollPhysics(),
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: CafesModel.TypeFoodList.length,
        itemBuilder: (context, index) {
          Map restaurant = CafesModel.TypeFoodList[index];
          return Column(
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    image: DecorationImage(
                        image: AssetImage(restaurant["image"]),
                        fit: BoxFit.cover)),
              ),
              SizedBox(height: 10.h),
              Text(
                restaurant["info"],
                style: GoogleFonts.roboto(
                    fontSize: 16.sp, color: MyColors.C_010F07),
              ),
            ],
          );
        },
        separatorBuilder: (context, index) {
          return SizedBox(width: 12.w);
        },
      ),
    );
  }

  Row typeInfoRow(txt1, txt2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          txt1,
          style: GoogleFonts.roboto(
              fontSize: 24.sp,
              fontWeight: FontWeight.w700,
              color: MyColors.C_010F07),
        ),
        Text(
          txt2,
          style: GoogleFonts.roboto(fontSize: 16.sp, color: MyColors.C_22A45D),
        ),
      ],
    );
  }

  ListView cafesLIstView(List cafeList) {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      scrollDirection: Axis.vertical,
      shrinkWrap: true,
      itemCount: cafeList.length,
      itemBuilder: (context, index) {
        Map cafe = cafeList[index];
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8.h),
            InkWell(
              onTap: () {
                setState(() {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AddToPage(cafeInfo: cafe)));
                });
              },
              child: Container(
                  height: 185.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    image: DecorationImage(
                        image: AssetImage(
                          cafe["image"],
                        ),
                        fit: BoxFit.cover),
                  )),
            ),
            SizedBox(height: 16.h),
            Text(cafe["name"],
                style: GoogleFonts.roboto(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: MyColors.C_010F07,
                )),
            SizedBox(height: 4.h),
            textsRow(cafe),
            SizedBox(height: 8.h),
            infosRow(),
            SizedBox(height: 20.h)
          ],
        );
      },
    );
  }

  Row infosRow() {
    return Row(
      children: [
        bottomInfoText("4.3"),
        bottomIcon(Icons.star, MyColors.C_22A45D),
        bottomInfoText("200+ Ratings"),
        bottomIcon(Icons.timer, Colors.black),
        bottomInfoText("25 Min"),
        comSIze(),
        bottomInfoText("\$"),
        SizedBox(width: 8.w),
        bottomInfoText("Free")
      ],
    );
  }

  SizedBox bottomIcon(icon, color) {
    return SizedBox(
      width: 24.w,
      child: Icon(
        icon,
        size: 12.sp,
        color: color,
      ),
    );
  }

  Text bottomInfoText(txt) {
    return Text(txt,
        style: GoogleFonts.roboto(
          fontSize: 12.sp,
          color: MyColors.C_010F07,
        ));
  }

  AppBar appBar() {
    return AppBar(
      elevation: 0.5,
      backgroundColor: Colors.white,
      leading: null,
      title: Center(
        child: Text(
          "San Francisco",
          style: GoogleFonts.roboto(
              fontSize: 22.sp,
              fontWeight: FontWeight.w700,
              color: MyColors.C_010F07),
        ),
      ),
      actions: [
        Row(
          children: [
            const Icon(
              Icons.keyboard_arrow_down_sharp,
              color: MyColors.C_010F07,
            ),
            Text("Filter",
                style: GoogleFonts.roboto(
                    fontSize: 16.sp,
                    color: MyColors.C_010F07,
                    fontWeight: FontWeight.w300)),
            SizedBox(width: 8.w)
          ],
        )
      ],
    );
  }
}

Text infoText(txt) {
  return Text(
    txt,
    style: GoogleFonts.roboto(fontSize: 16.sp, color: MyColors.C_868686),
  );
}

SizedBox comSIze() {
  return SizedBox(
    width: 20.w,
    child: const Icon(
      Icons.circle,
      size: 4,
      color: MyColors.C_868686,
    ),
  );
}

Row textsRow(Map<dynamic, dynamic> cafe) {
  return Row(
    children: [
      infoText("${cafe["price"]} \$"),
      comSIze(),
      infoText("Chinese"),
      comSIze(),
      infoText("American"),
      comSIze(),
      infoText("Deshi food")
    ],
  );
}
