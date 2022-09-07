
import 'package:flutter/material.dart';
import 'package:panditapp/model_viwe/ApiCallLogin.dart';



import 'package:panditapp/repo/api_remote_services.dart';
import 'package:provider/provider.dart';

import 'Viwe/Splash_onboarding/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';


Future<void>  main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
      ChangeNotifierProvider(create: (_)=>ApiCallLogin())

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

