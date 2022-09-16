import 'package:dotted_line/dotted_line.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panditapp/View/Booking/pages/Booking_Progress_Screen.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:provider/provider.dart';
import 'package:panditapp/view_model/BookingViewDetails/getBookingOTP.dart';
import 'package:sms_autofill/sms_autofill.dart';


import '../../../Consts/color1.dart';
import '../../../model/Booking_View_Details/Check_booking_OTP_Model.dart';
import '../../../model/Booking_View_Details/Check_booking_OTP_Model.dart';
import '../../../model/Booking_View_Details/Check_booking_OTP_Model.dart';
import '../../../model/Booking_View_Details/Check_booking_OTP_Model.dart';
import '../../../model/Booking_View_Details/Check_booking_OTP_Model.dart';
import '../../../view_model/BookingViewDetails/Check_Booking_Confirm_OTP.dart';
import '../../../view_model/BookingViewDetails/Check_Booking_Confirm_OTP.dart';
import '../../../view_model/BookingViewDetails/Check_Booking_Confirm_OTP.dart';
import '../../../view_model/ViewDetails_VM.dart';



class Booking_Details_Screen extends StatefulWidget {
  var bookingId;
  var userOTP;
   Booking_Details_Screen({Key? key, this.bookingId,this.userOTP}) : super(key: key);

  @override
  State<Booking_Details_Screen> createState() => _Booking_Details_ScreenState();
}

class _Booking_Details_ScreenState extends State<Booking_Details_Screen> {


  var ht,wt;
 late Puja_Confirm_OTP  puja_Confirm_OTP;

  late ViewDetailVM viewdetailVM;
  TextEditingController otpController = TextEditingController();
  SmsAutoFill smsAutoFill = SmsAutoFill();
  String? strVerificationId;



  @override
  Widget build(BuildContext context) {
    viewdetailVM = Provider.of<ViewDetailVM>(context, listen: false);
    viewdetailVM.viewdetailAPIcall(userbooking: widget.bookingId);

    puja_Confirm_OTP = Provider.of<Puja_Confirm_OTP>(context,listen: false);
    puja_Confirm_OTP.getPujaCofirmOtp(userBooking_id: widget.bookingId);

    wt = MediaQuery.of(context).size.width;
    ht = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        backgroundColor: white,
        appBar: AppBar(
          title:  const Text("Booking Details"),
        ),
         body: Consumer<ViewDetailVM>(
           builder: (_, data, __ ) => data.loading ? const Center(child: CircularProgressIndicator(),) : SingleChildScrollView(
             child:  Expanded(
               child: Column(
                 children: [
                   Center(child: Padding(
                     padding: const EdgeInsets.only(top: 10),
                     child: Text("Booking Number",style: GoogleFonts.lato(fontWeight: FontWeight.w500,fontSize: 14,color: h1Color),),
                   )),
                   Text(viewdetailVM.viewdetailmodel!.response!.viewdetaildata![0].orderId.toString(),style: GoogleFonts.lato(fontSize: 18,color:h1Color,fontWeight: FontWeight.w500),)
                   ,Container(
                     width: double.infinity,
                     height: 40,
                     color: bgColor,
                     child: Padding(
                       padding: const EdgeInsets.only(left: 16,right: 16),
                       child: Row(
                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Text(viewdetailVM.viewdetailmodel!.response!.viewdetaildata![0].name.toString(),style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.w600,color: kPrimaryColor),),
                           InkWell(
                             onTap: (){
                               FlutterPhoneDirectCaller.callNumber("${viewdetailVM.viewdetailmodel!.response!.viewdetaildata![0].phone}");
                             },
                             child: Container(
                               width: 140,
                               height: 32,
                               decoration: BoxDecoration(
                                   color: white,
                                   borderRadius: BorderRadius.circular(40)
                               ),
                               child: Row(
                                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                 children: [
                                   const Icon(Icons.call,color: kPrimaryColor,),
                                   Text("Call Now"
                                     ,style: GoogleFonts.lato(fontWeight: FontWeight.w500,fontSize: 14,color: kPrimaryColor),)
                                 ],
                               ),
                             ),
                           )
                         ],
                       ),
                     ),
                   ),
                   const SizedBox(height: 19,),
                   Padding(
                     padding: const EdgeInsets.only(left: 16,right: 16),
                     child: Column(
                       children: [
                         Row(
                           children: [
                             const Icon(Icons.calendar_month,color: kPrimaryColor,),
                             const SizedBox(width: 11,),
                             //Text("Mon 05/Oct/2021"),
                             Text(viewdetailVM.viewdetailmodel!.response!.viewdetaildata![0].bookingPujaDate.toString().split(" ")[0]),
                           ],
                         ),
                         const SizedBox(height: 19,),
                         Row(
                           children: [
                             const Icon(Icons.access_time,color: kPrimaryColor,),
                             const SizedBox(width: 11,),

                             Text(viewdetailVM.viewdetailmodel!.response!.viewdetaildata![0].bookingPujaDate.toString().replaceRange(0, 11, "")),
                           ],
                         ),
                         const SizedBox(height: 19,),
                         Row(
                           children: [
                             const Icon(Icons.location_on,color: kPrimaryColor,),
                             const SizedBox(width: 11,),
                             Text(viewdetailVM.viewdetailmodel!.response!.viewdetaildata![0].cityname.toString())
                           ],
                         )
                       ],
                     ),
                   ),
                   const SizedBox(height: 26,),
                   Container(
                     width: double.infinity,
                     height: 40,
                     color: bgColor,
                     child: Padding(
                       padding: const EdgeInsets.only(left: 16,top: 8),
                       child: Text("Items",style: GoogleFonts.lato(fontWeight: FontWeight.w500,fontSize: 18,color: kPrimaryColor),),
                     ),
                   ),
                   const SizedBox(height: 16,),
                   Padding(
                     padding: const EdgeInsets.only(left: 16),
                     child: Column(
                       children: [
                         Row(
                           children: [
                             Text("1 x ${viewdetailVM.viewdetailmodel!.response!.viewdetaildata![0].poojaTitle.toString()}",),
                           ],
                         ),
                         const SizedBox(
                           height: 16,
                         ),
                         Row(
                           children: const [
                             Text("2 x Astrology Session"),
                           ],
                         )
                       ],
                     ),
                   ),
                   const SizedBox(height: 24,),
                   Container(
                     width: double.infinity,
                     height: 40,
                     color: bgColor,
                     child: Padding(
                       padding: const EdgeInsets.only(left: 16,top: 8),
                       child: Text("Earnings",style: GoogleFonts.lato(fontWeight: FontWeight.w500,fontSize: 18,color: kPrimaryColor),),
                     ),
                   ),
                   const SizedBox(height: 24,),
                   Padding(
                     padding: const EdgeInsets.only(left: 16,right: 16),
                     child: Column(
                       children: [
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children:  [
                             const Text("Puja Earnings"),
                             Text("₹${viewdetailVM.viewdetailmodel!.response!.viewdetaildata![0].bookingPaidAmount.toString()}"),
                           ],
                         ),
                         const SizedBox(height: 10,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children: const [
                             Text("Visiting Charge"),
                             Text("₹200")
                           ],
                         ),
                         const SizedBox(height: 10,),
                         const DottedLine(),
                         const SizedBox(height: 10,),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                           children:[
                             const Text("Total",style:TextStyle(fontSize: 14,fontWeight: FontWeight.w400)),
                             Text("₹${viewdetailVM.viewdetailmodel!.response!.viewdetaildata![0].bookingPaidAmount.toString()}"),
                           ],
                         )
                       ],
                     ),
                   ),
                   const SizedBox(height: 24,),
                   Padding(
                     padding: const EdgeInsets.only(left: 16,right: 16),
                     child: Container(
                       width: double.infinity,
                       height: 48,
                       decoration: BoxDecoration(
                           borderRadius: BorderRadius.circular(4)
                           ,border: Border.all(
                           width: 2,
                           color: buttonColor
                       )
                       ),
                       child:
                       Center(
                         child: Row(
                           mainAxisAlignment: MainAxisAlignment.center,
                           children: [
                             const Icon(Icons.navigation,color: buttonColor,),
                             Text("Navigate",style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.w600,color: buttonColor),)
                           ],
                         ),
                       ),
                     ),
                   ),
                   const SizedBox(height: 24,),
                   Padding(
                     padding: const EdgeInsets.only(left: 16,right: 16),
                     child: InkWell(
                       onTap: (){
                         showModalBottomSheet(
                           context: context,
                           builder: (builder)=> bottomSheet(bookingId: viewdetailVM.viewdetailmodel!.response!.viewdetaildata![0].bookingId.toString()),
                         );
                         puja_Confirm_OTP.getPujaCofirmOtp(userBooking_id: widget.bookingId);
                       },
                       child: Container(
                         width: double.infinity,
                         height: 48,
                         decoration: BoxDecoration(
                             color: buttonColor,
                             borderRadius: BorderRadius.circular(4)
                         ),
                         child: Center(child: Text("Next ",style: GoogleFonts.lato(color: white,fontWeight: FontWeight.w600,fontSize: 20),)),
                       ),
                     ),
                   )
                 ],
               ),
             ),
           ),
         )
      ),
    );
  }





  @override
  void dispose() {
    otpController.dispose();
  }

  toast() {
    print("Booking Detail OTP Error");
  }

  bottomSheet({required String bookingId})  {

    return Consumer<Check_Booking_Confirm_OTP_View_Model>(
  builder: (context, provider, child) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 480,
    margin:  const EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Enter the 4 digit OTP",style: GoogleFonts.lato(color: kSecondaryColor,fontSize: 16,fontWeight: FontWeight.w500),)
        ,const SizedBox(height: 12,),
        Text("Ask for 4 digit code received by the user on their mobile number",style:
          GoogleFonts.lato(color: h1Color,fontSize: 14,fontWeight: FontWeight.w600),),
        const SizedBox(height: 12,),
        PinCodeTextField(

          keyboardType: TextInputType.number,
          controller: otpController,
          inputFormatters: [
            LengthLimitingTextInputFormatter(4),
            FilteringTextInputFormatter.allow(
                RegExp("[0-9]")),
          ],
          // keyboardType: TextInputType.(),
          appContext: context,
          length: 4,
          onChanged: (value) {
            if (value.length == 4) {
              print("object vk");
              puja_Confirm_OTP.getPujaCofirmOtp(userBooking_id: widget.bookingId);
            };
          },
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 48,
            fieldWidth: 48,
            inactiveColor: const Color(0XFFCACACA),
            activeColor: const Color(0XFFFF7D33),
            selectedColor: const Color(0XFFFF7D33),
          ),
        ),
        const SizedBox(height: 12,),

        provider.loading ? Container(
            width: double.infinity,
            alignment: Alignment.center,
            child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircularProgressIndicator(color: kPrimaryColor,),
        )) : InkWell(
          onTap: (){
            provider.getCheckBookingConfirm(userBooking_id: widget.bookingId,otpcode: "1234").then((value) {
              print("Value $value");
              provider.getcheckBookingConfirmOtpModel!.success! ?  Navigator.push(context, MaterialPageRoute(builder: (context)=>   Booking_Progress())) : toast();
            });


            },
          child: Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: BorderRadius.circular(4)

            ),
            child: Center(child: Text("Next ",style: GoogleFonts.lato(color: white,fontWeight: FontWeight.w600,fontSize: 20),)),
          ),
        ),
      ],
    ),
  );
  },
);
  }
}
