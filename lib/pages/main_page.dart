import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tsi_mobile/pages/pages.dart';
import 'package:tsi_mobile/pages/pasien/form.dart';
import 'package:tsi_mobile/shared/shared.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:unicons/unicons.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int currentIndex = 0;

  final List<Widget> bottomNavigator = [
    HomePage(),
    PasienPage(),
    StorePage(),
    TerapisPage(),
    AccountPage()
  ];

  void onTapTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: bottomNavigator[currentIndex],
      floatingActionButton: currentIndex == 1
          ? FloatingActionButton(
              backgroundColor: secondary1,
              onPressed: () {
                Get.to(PasienFormScreen());
              },
              child: Icon(Icons.add),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: onTapTapped,
          selectedItemColor: primary1,
          unselectedItemColor: textDark3,
          selectedLabelStyle: ralewayTextStyle.copyWith(
            fontSize: 12.sp,
            color: primary1,
          ),
          unselectedLabelStyle:
              ralewayTextStyle.copyWith(fontSize: 12.sp, color: textDark3),
          type: BottomNavigationBarType.fixed,
          iconSize: 20.sp,
          backgroundColor: bgLight2,
          items: [
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.home_alt),
              label: "Home",
            ),
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.wheelchair),
              label: "Pasien",
            ),
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.store_alt),
              label: "Store",
            ),
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.users_alt),
              label: "Terapis",
            ),
            BottomNavigationBarItem(
              icon: Icon(UniconsLine.user_circle),
              label: "Akun",
            ),
          ]),
    );
  }
}
