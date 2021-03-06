import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:panditapp/Phone_Auth/auth_cubit.dart';
import 'package:panditapp/Phone_Auth/auth_state.dart';
import 'package:panditapp/Screen/login_flow/Name_Screen.dart';
import 'package:panditapp/Screen/login_flow/Phone_Number.dart';

import 'Screen/Splash_onboarding/splash_screen.dart';
import 'package:responsive_builder/responsive_builder.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color kPrimaryColor = Color(0xffFF7D33);
    Color kSecondaryColor = Color(0xffCACACA);
    Color kScaffoldBackground = Color(0xffFFF3E9);
    Color p1Color =  Color(0xff6E798C);
    Color white = Color(0xffFFFFFF);
    Color h1Color =Color(0xff343D48);
    return

      BlocProvider(
        create: (context) => AuthCubit(),
        child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
         primaryColor:  kPrimaryColor,
             appBarTheme: AppBarTheme(
            color: kPrimaryColor
        )

        ),
        home: BlocBuilder<AuthCubit,AuthState>(
          buildWhen: (oldState, newState){
            return oldState is AuthInitialState;
          },
            builder: (context,state)
            {
              if(state is AuthLoggedInState){
                return Name_Screen();
              }
              else if(state is AuthLoggedOutState){
                return PhoneNumber_Screen();
              }
              else{
                return SplashScreen();
              }
              return  SplashScreen();
            }
            //child: SplashScreen()
            ) ,
    ),
      );
  }

}

