import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lite_rolling_switch/lite_rolling_switch.dart';
import 'package:provider/provider.dart';

import '../Consts/themescolor.dart';
import '../view_model/Earnings_View_Model/Earnings_Home_VM.dart';
import '../view_model/Profile/Personal_Detail_View_Model.dart';
import '../view_model/home_tab/Online_Ofline_view_model.dart';
import '../view_model/home_tab/booking_request_view_model.dart';
class TotalEarningGraph extends StatefulWidget {
  const TotalEarningGraph({Key? key}) : super(key: key);

  @override
  State<TotalEarningGraph> createState() => _TotalEarningGraphState();
}

class _TotalEarningGraphState extends State<TotalEarningGraph> {
  late OnlineOflineViewModel _online_ofline_view_model;
  late BookingRequestViewModel booking_request_view_model;
  late PersonalDetailViewModel? personaldetailviewmodel;
  late EarningsHomeVM earnings_home_vm;



  @override
  void initState() {
    personaldetailviewmodel = Provider.of<PersonalDetailViewModel>(context, listen: false);
    _online_ofline_view_model =
        Provider.of<OnlineOflineViewModel>(context,
            listen: false);
  }

  @override
  Widget build(BuildContext context) {
    earnings_home_vm = context.watch<EarningsHomeVM>();
    return Consumer<OnlineOflineViewModel>(
      builder: (_, provider, __) => Container(
        padding: EdgeInsets.only(left: 16,right: 16,top: 1),
        height: 168,
        //width: d,
        decoration: BoxDecoration(
            color: Color(0xFFffffff),
            boxShadow: [
              BoxShadow(
                color: Color(0xffFFD1CC),
                blurRadius: 15.0, // soften the shadow
                spreadRadius: 8.0, //extend the shadow
                // offset: Offset(
                //   1.0, // Move to right 5  horizontally
                //   5.0, // Move to bottom 5 Vertically
                // ),
              )
            ],

            //border: Border.all(color: Colors.red),
            borderRadius: BorderRadius.all(Radius.circular(20))
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Row(children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    //color: Colors.blue,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  // color: Colors.blue,
                  height:62 ,
                  width: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Total Earning",style: GoogleFonts.lato(fontSize:14,fontWeight: FontWeight.w400,color:Color(0xff7C7C7C)),),
                      Spacer(),
                      Text("₹${earnings_home_vm.earningsHomeModel?.response?.lifetimeearnings ?? "0.00"}",style: GoogleFonts.lato(fontSize:24,fontWeight: FontWeight.w700),),
                    ],
                  ),
                ),
              ),
              //Spacer(),
              SizedBox(width: 16,),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    //color: Colors.red,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  width: double.infinity,
                  height: 62,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Duty",style: GoogleFonts.lato(fontSize:14,fontWeight: FontWeight.w400,color:Color(0xff7C7C7C)),),
                      Spacer(),
                      SizedBox(
                        height: 31,
                        width: 120,
                        child: LiteRollingSwitch(
                          textOn: "Working",
                          value: personaldetailviewmodel?.presonalDetailModel?.success ?? false ? personaldetailviewmodel?.presonalDetailModel?.response?.panditDetails?.onlinestatus == "1" : true,
                          textOff: "Offline",
                          colorOn: btn,
                          colorOff: p1Color,
                          textSize: 16,
                          onChanged: (val) {
                            _online_ofline_view_model.getonlineofline(
                                userStatus: val ? "1" : "0");
                          }, onTap: (){}, onDoubleTap: (){}, onSwipe: (){},
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],),
            Row(children: [
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffE2FFF3),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  height: 62,
                  width: double.infinity,
                  //color: Colors.red,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Today Earn",style: GoogleFonts.lato(fontSize: 15,fontWeight: FontWeight.w400,color: Color(0xff7C7C7C)),),
                        Text("₹${earnings_home_vm.earningsHomeModel?.response?.lifetimeearnings ?? "0.00"}",style: GoogleFonts.lato(fontSize: 18,fontWeight: FontWeight.w700),),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(width: 16,),
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                      color: Color(0xffFFD1CC),
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                  height: 62,
                  width: double.infinity,
                  //color: Colors.orangeAccent,
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Total Visits",style: GoogleFonts.lato(fontSize: 15,fontWeight: FontWeight.w400,color: Color(0xff7C7C7C)),),
                        Text(earnings_home_vm.earningsHomeModel?.response?.lifetimepuja.toString() ?? "0",style: GoogleFonts.lato(fontSize: 18,fontWeight: FontWeight.w700),)

                      ],
                    ),
                  ),
                ),
              ),
            ],),



          ],),
      ),
    );
  }
}

