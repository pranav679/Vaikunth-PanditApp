
import 'package:flutter/material.dart';
import 'package:panditapp/view_model/ApiCallLogin.dart';
import 'package:panditapp/view_model/CityListApi.dart';
import 'package:panditapp/view_model/Complete_Bookings.dart';

import 'package:panditapp/view_model/home_tab/Accept_Booking_Api.dart';
import 'package:panditapp/view_model/home_tab/booking_request_view_model.dart';
import 'package:panditapp/view_model/verification_number_api.dart';
import 'package:provider/provider.dart';
import 'View/Splash_onboarding/splash_screen.dart';

import 'package:firebase_core/firebase_core.dart';


Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [

       ChangeNotifierProvider(create: (_)=>ApiCallLogin()),
       ChangeNotifierProvider(create: (_)=>Booking_Request_View_Model()),
       ChangeNotifierProvider(create: (_)=>CompleteBookingViewModel()),
       ChangeNotifierProvider(create: (_)=>Accept_Booking_Api()),
       ChangeNotifierProvider(create: (_)=>City_List_Api()),
       ChangeNotifierProvider(create: (_)=>NumberVerifyViewModel())

      ],
      child: const MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color kPrimaryColor = Color(0xffFF7D33);

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor:  kPrimaryColor,
            appBarTheme: AppBarTheme(
                color: kPrimaryColor
            )

        ),
        home: SplashScreen(),
      );
  }

}

