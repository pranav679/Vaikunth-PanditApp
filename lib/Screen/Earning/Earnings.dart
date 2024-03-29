import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panditapp/Screen/Earning/components/Life_Time_Puja%E2%80%99s.dart';
import 'package:panditapp/Screen/Earning/components/Money_transferred_succesfully.dart';
import 'package:charts_flutter/flutter.dart'as charts;

import 'package:table_calendar/table_calendar.dart';

class Earnings_Screen extends StatefulWidget {
  const Earnings_Screen({Key? key}) : super(key: key);

  @override
  State<Earnings_Screen> createState() => _Earnings_ScreenState();
}

class _Earnings_ScreenState extends State<Earnings_Screen> {

  var ht,wt;
  Color kPrimaryColor = const Color(0xffFF7D33);
  Color kSecondaryColor = const Color(0xffCACACA);
  Color kScaffoldBackground = const Color(0xffFFF3E9);
  Color p1Color =  const Color(0xff6E798C);
  Color white = const Color(0xffFFFFFF);
  Color h1Color =const Color(0xff343D48);




  @override
  Widget build(BuildContext context) {
    wt = MediaQuery.of(context).size.width;
    ht = MediaQuery.of(context).size.height;



    return Scaffold(
      backgroundColor: white,
      body: SafeArea(child: Column(

        children: [
          Container(
            width: double.infinity,
            height: ht * 0.2,
            color: kPrimaryColor
              ,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Text("My Earnings",style: GoogleFonts.lato(
                      color: white,
                      fontSize: 20,fontWeight:  FontWeight.w600),),
                ),
                const SizedBox(
                  height:16 ,
                ),
                Container(
                  width: wt * 0.9,
                  height: 60,
                  decoration: BoxDecoration(
                    color: white,
                    borderRadius: BorderRadius.circular(4)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10,right: 10),
                    child: Row(

                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Wallet",style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w400,color: kSecondaryColor),),
                            Text("₹2518.00",style: GoogleFonts.lato(fontSize: 18, fontWeight: FontWeight.w600,color: h1Color),)
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                            showModalBottomSheet(
                              context: context,
                              builder: (builder)=> bottomSheet(),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(top: Radius.circular(4),)
                              )
                            );
                          },
                          child: Container(
                            width: wt * 0.3,
                            height: ht * 0.07,


                            decoration: BoxDecoration(
                              color: Color(0xff6363BE),
                              borderRadius: BorderRadius.circular(4)
                            ),
                            child: Center(child: Text("Withdraw",style:
                              GoogleFonts.lato(color: white,fontWeight: FontWeight.w600,fontSize: 18)
                              ,)),
                          ),
                        )

                      ],
                    ),
                  ),

                )

              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),

          Expanded(

            child: Padding(
              padding: const EdgeInsets.only(left: 12,right: 12),
              child:
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 156,
                          height: 68,
                          decoration: BoxDecoration(
                            color: Color(0xff6363BE),
                            borderRadius: BorderRadius.circular(4)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text("Life-Time earnings",style: GoogleFonts.lato(color: Color(0xffECF1F6),fontSize: 14,fontWeight: FontWeight.w400),),
                                Text("₹23652.25",style: GoogleFonts.lato(color: white,fontWeight: FontWeight.w600,fontSize: 18),)
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Life_Time_Puja()));
                          },
                          child: Container(
                            width: 156,
                            height: 68,
                            decoration: BoxDecoration(
                                color: Color(0xff32326F),
                                borderRadius: BorderRadius.circular(4)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Life-Time puja’s",style: GoogleFonts.lato(color: Color(0xffECF1F6,),fontWeight: FontWeight.w400 ,fontSize: 14),),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      Text("152",style: GoogleFonts.lato(color: white,fontSize: 18,fontWeight: FontWeight.w600),),
                                      Icon(Icons.arrow_right,color: white,)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 24,),
                    Text("Weekly",style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 14,color: h1Color),),
                    SizedBox(height: 8,),

                    Container(
                      width: double.infinity,
                       height:  wt * 0.9,
                      decoration: BoxDecoration(

                         borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              width: 1,
                              color: p1Color
                          )
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 16,right: 16,top: 10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(Icons.arrow_back_ios,),
                                Column(
                                  children: const [
                                    Text("Dec 7-13"),
                                    Text("₹1200.00"),

                                  ],
                                ),
                                const Icon(Icons.arrow_forward_ios)
                              ],
                            ),




                          ],
                        ),
                      ),


                      ),




                    const SizedBox(height: 24,),
                    Text("Monthly",style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 14,color: h1Color),),
                    SizedBox(height: 24,),
                    Container(
                      width: double.infinity,
                      height:  wt * 0.9,
                      decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                              width: 1,
                              color: p1Color
                          )
                      ),


                    ),


                  ],
                ),
              ),
            ),
          )
        ],
      ) ,
        
      ),
    );
  }
  Widget bottomSheet(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 200,
      margin:  EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Withdraw money to Bank Account",style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.w600,color: p1Color),),
          SizedBox(height: 16,),

          Center(child: Text("₹2518.00",style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 24,color: h1Color),)),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Radio(value: 1, groupValue: 1, onChanged: (value){

              }),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("IndusInd Bank",style: GoogleFonts.lato(fontSize: 16,fontWeight: FontWeight.w600,color: p1Color),),
                  Text("2541XXXXXXXX2653",style: GoogleFonts.lato(fontWeight: FontWeight.w600,fontSize: 12,color: h1Color),)
                ],
              )
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: Color(0xff6363BE)
            ),
            child: Center(child: TextButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>Money_transferred_succesfully()));
              },
                child: Text("Send money to account",style: GoogleFonts.lato(fontSize: 20,color: white,fontWeight: FontWeight.w500),))),
          )
        ],
      ),


    );
  }

}

