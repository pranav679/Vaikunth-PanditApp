import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panditapp/View/login_flow/OTP_Verify.dart';
import 'package:panditapp/consts/image_const.dart';
import 'package:provider/provider.dart';
import '../../Consts/text_const.dart';
import '../../consts/themescolor.dart';
import '../../route_app/page_navigeter_name_route.dart';
import '../../view_model/Earnings_View_Model/Earnings_Home_VM.dart';
import '../../view_model/home_tab/booking_request_view_model.dart';
class PhoneNumberScreen extends StatefulWidget {
  const PhoneNumberScreen({Key? key}) : super(key: key);

  @override
  State<PhoneNumberScreen> createState() => _PhoneNumberScreenState();
}

class _PhoneNumberScreenState extends State<PhoneNumberScreen> {
  var phoneController = TextEditingController();
  BookingRequestViewModel? booking_request_view_model;

  var ht, wt;

  @override
  Widget build(BuildContext context) {
    wt = MediaQuery.of(context).size.width;
    ht = MediaQuery.of(context).size.height;

    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: colorPrimary,
    ));
    return Scaffold(
      backgroundColor: white,
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                height: double.infinity,
                width: double.infinity,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        ENTERYOURPHONENUMBER,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            color: h1Color,
                            fontSize: 24),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: textFiled(),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, bottom: 24),
              child: Container(
                child: Container(
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4), //color: Colors.red
                  ),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OTPVerify(
                                    mobile: phoneController.text,
                                  )));
                      // Navigator.pushNamed(context, RouteName.OTP_verify);
                    },
                    child: Text(
                      SENDOTP,
                      style: GoogleFonts.lato(
                        color: white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                        primary: colorPrimary,
                        //padding: EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                        textStyle: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold)),
                  ),
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  Widget textFiled() {
    return Container(
        height: 48,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(width: 1, color: h1Color)),
        child: Row(
          children: [
            Padding(
                padding: EdgeInsets.only(left: 10),
                child: Image.asset(ImageConst().FLAG_IMAGES)),
            SizedBox(
              width: 10,
            ),
            Text("+91"),
            SizedBox(
              width: 5,
            ),
            VerticalDivider(
              width: 2,
              color: kSecondaryColor,
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 5),
                child: TextFormField(
                  cursorColor: kPrimaryColor,
                  controller: phoneController,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(10),
                    FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                  ],
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: ENTER_YOU_PHONE_NUMBER,
                    border: InputBorder.none,
                  ),
                ),
              ),
            )
          ],
        ));
  }
}
