import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panditapp/consts/image_const.dart';
import 'package:panditapp/consts/text_const.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


import '../../../Util/picture/image.dart';
import '../../../consts/themescolor.dart';
import '../../../view_model/Profile/Help_Support_Details_VM.dart';
import 'Help&Support.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var ht, wt;


  Widget privacyPolicyDesign(){
    return GestureDetector(
      onTap: () {
        _privacypolicyURL(context);
      },
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: kSecondaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(ImageConst().PROFILE_PRIVACY_IMAGES),
                  Text(
                    PRIVACYPOLICY,
                    style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: h1Color),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }


  Widget termsConditionsDesign(){
    return GestureDetector(
      onTap: () {
        _launchURL(context);
      },
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: kSecondaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                      ImageConst().TERMS_AND_CONDITIONS_IMAGES),
                  Text(
                    TERMS_CONDITIONS,
                    style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: h1Color),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }

  Widget helpSupportDesign(){
    return GestureDetector(
      onTap: () {
        HelpSupportDetails_VM panditbanklist =
        Provider.of<HelpSupportDetails_VM>(context,
            listen: false);
        panditbanklist.HelpSupportDetailsAPIcall();

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => HelpSupportScreen()));
      },
      child: Container(
        width: double.infinity,
        height: 52,
        decoration: BoxDecoration(
          color: white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1, color: kSecondaryColor),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(ImageConst().HELP_IMAGES),
                  Text(
                    HELPSUPPORT,
                    style: GoogleFonts.lato(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: h1Color),
                  ),
                ],
              ),
              Icon(Icons.arrow_forward)
            ],
          ),
        ),
      ),
    );
  }


  Widget Appbar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25,top: 20,),
      child: Row (children: [
        InkWell(
            onTap: (){
              Navigator.pop(context);
            },
            child: SvgPicture.asset(IMG().BACKICON)),
        SizedBox(width: 12,),

        Text(SETTING, style: GoogleFonts.lato(
            fontSize: 20,
            color: h1Color,
            fontWeight: FontWeight.w700),),

      ],),
    );
  }

  @override
  Widget build(BuildContext context) {
    wt = MediaQuery.of(context).size.width;
    ht = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16,),
            child: Column(
              children: [
                Appbar(),
                privacyPolicyDesign(),
                SizedBox(
                  height: 16,
                ),
                termsConditionsDesign(),
                SizedBox(
                  height: 16,
                ),
                helpSupportDesign(),

              ],
            ),
          ),
        ),
      ),
    );
  }



  void _launchURL(BuildContext context) async {
    try {
      launch('https://vaikunth.fictivebox.com/t&c',
       /*   customTabsOption: CustomTabsOption(
            toolbarColor: Theme.of(context).primaryColor,
          )*/
      );
    }
    catch(e) {
      debugPrint(e.toString());
    }
  }
  void _privacypolicyURL(BuildContext context) async {
    try {
      launch('https://vaikunth.fictivebox.com/privacypolicy',
        /*   customTabsOption: CustomTabsOption(
            toolbarColor: Theme.of(context).primaryColor,
          )*/
      );
    }
    catch(e) {
      debugPrint(e.toString());
    }
  }
}
