import 'package:flutter/material.dart';
import 'package:panditapp/View/Booking/Bookings_screen.dart';
import 'package:panditapp/View/Earning/Earnings.dart';
import 'package:panditapp/View/Home/Pages/home_page.dart';
import 'package:panditapp/View/Profile/Profile.dart';
import 'package:provider/provider.dart';
import '../../Consts/text_const.dart';
import '../../Util/Appbar.dart';
import '../../consts/image_const.dart';
import '../../consts/themescolor.dart';
import '../../view_model/Earnings_View_Model/Earnings_Home_VM.dart';
import '../../view_model/home_tab/booking_request_view_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;
  final screen = [
    HomePageScreen(),
    EarningsScreen(),
    BookingsScreen(),
    AppBarcomon(),
   // ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {

    return  WillPopScope(
      onWillPop: () => _onBackButtonPressed(context),
      child: Scaffold(
          backgroundColor: white,
          body: screen[currentIndex],
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: currentIndex,
              onTap: (index) => setState(() => currentIndex = index),
              type: BottomNavigationBarType.fixed,
              selectedItemColor: kPrimaryColor,
              iconSize: 30,
              items: [
                BottomNavigationBarItem(
                    icon: Image.asset(ImageConst().HOME), label: HOME),
                BottomNavigationBarItem(
                    icon: Image.asset(ImageConst().EARNING), label: EARNING),
                BottomNavigationBarItem(
                    icon: Image.asset(ImageConst().BOOKING), label: BOOKINGS),
                BottomNavigationBarItem(
                    icon: Image.asset(ImageConst().PROFILE), label: PROFILE)
              ])),
    );
  }

  Future<bool> _onBackButtonPressed(BuildContext context) async {
    bool exitApp = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(VAIKUNTH, style: TextStyle(color: Color(0XFFFF7D33))),
            content: Text(
              DO_YOU_WANT_TO_EXIT,
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    NO,
                    style: TextStyle(color: Colors.black),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(YES, style: TextStyle(color: Colors.black))),
            ],
          );
        });
    return exitApp ;
  }
}
