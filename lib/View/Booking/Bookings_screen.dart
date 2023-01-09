import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panditapp/Consts/image_const.dart';
import 'package:panditapp/View/Booking/pages/booking_details.dart';
import 'package:panditapp/Widgets/circular_loader.dart';
import 'package:provider/provider.dart';

import '../../Consts/text_const.dart';
import '../../Util/Appbar.dart';
import '../../consts/themescolor.dart';
import '../../route_app/page_navigeter_name_route.dart';
import '../../view_model/BookingViewDetails/Complete_Bookings.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({Key? key}) : super(key: key);

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  var ht, wt;
  bool small = false;

  late CompleteBookingViewModel completeBookingViewModel;
  Future<void> _refresh(bool reload, BuildContext context){
    completeBookingViewModel= Provider.of<CompleteBookingViewModel>(context,listen: false);
    completeBookingViewModel.completebookingAPIcall();
    return Future.delayed(const Duration(seconds: 0));


  }


  @override
  Widget build(BuildContext context) {
    completeBookingViewModel = Provider.of<CompleteBookingViewModel>(context,listen: false);
    completeBookingViewModel.completebookingAPIcall();

    wt = MediaQuery.of(context).size.width;
    ht = MediaQuery.of(context).size.height;
    return

       Scaffold(
          backgroundColor: white,
          body: completeBookingViewModel.loading
              ? const Center(child: CircularLoader())
              : DefaultTabController(
            length: 3,
            child: Padding(
              padding: const EdgeInsets.only(top: 27.5),
              child: Column(
                children: [
                  AppBarcomon(),
                  TabBar(
                    labelStyle: TextStyle(fontSize: small ? 15.0 : 18.0),
                    labelColor: h1Color,
                    unselectedLabelColor: const Color(0Xff999EA3),
                    tabs: const [
                      Tab(
                        text: 'Booking',
                      ),
                      Tab(
                        text: 'Completed',
                      ),
                      Tab(
                        text: 'Cancelled',
                      ),
                    ],
                  ),
                  Expanded(
                      child: TabBarView(
                        children: [
                          Center(
                            child: Upcoming(),
                          ),
                          Center(
                            child: CompletedPage(),
                          ),
                          Center(
                              child: Cancelled()),
                        ],
                      ))
                ],
              ),
            ),),
    );
  }

  Widget appBar(){
    return  Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 10,bottom: 15),
      child: Row(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteName.Profile_Screen);
            },
            child: const CircleAvatar(
              radius: 20,
              backgroundImage: NetworkImage(
                  'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8dXNlciUyMHByb2ZpbGV8ZW58MHx8MHx8&w=1000&q=80'),
              backgroundColor: Colors.transparent,
            ),
          ),

          SizedBox(width: 8,),
          Text("Govind Kumar",style: GoogleFonts.lato(fontSize: 16,fontWeight:FontWeight.w800,),),

          // SizedBox(
          //   height: 31,
          //   width: 120,
          //   child: LiteRollingSwitch(
          //     textOn: "Online",
          //     value: true,
          //     textOff: "Ofline",
          //     colorOn: btn,
          //     colorOff: p1Color,
          //     textSize: 16,
          //     onChanged: (val) {
          //       _online_ofline_view_model =
          //           Provider.of<OnlineOflineViewModel>(context,
          //               listen: false);
          //       _online_ofline_view_model.getonlineofline(
          //           userStatus: val ? "1" : "0");
          //     },
          //   ),
          // ),

          Spacer(),
          InkWell(
            onTap: () {
              Navigator.pushNamed(context, RouteName.Notifications_screen);
            },
            child: const Icon(Icons.notifications,color: kPrimaryColor,),
          )
        ],
      ),
    );
  }


  Widget Upcoming() {
    return RefreshIndicator(
      onRefresh: () async{
        await _refresh(true, context);
      },
      color: kPrimaryColor,
      strokeWidth: 5,
      displacement: 0,
      child: Container(
          child: ListView.builder(

            itemBuilder: (context, int index) {
              return Container(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            padding: EdgeInsets.only(left: 24,right: 24),
                            alignment: Alignment.bottomCenter,
                            width: double.infinity,
                            height: 213,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: Border.all(width: 1, color: kPrimaryColor)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 24,),
                                Text(
                                  completeBookingViewModel
                                      .completebokingmodel
                                      ?.response!
                                      .upcomingbookinglist![index]
                                      .poojaTitle ??
                                      "",
                                      //"Puja title katha",
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14,
                                      color: kPrimaryColor),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  // completeBookingViewModel
                                  //     .completebokingmodel
                                  //     ?.response!
                                  //     .upcomingbookinglist![index]
                                  //     .name ??
                                  //     "",
                                  BOOKING_NO+"#098767",
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      color:Colors.grey,
                                      fontWeight: FontWeight.w600),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  completeBookingViewModel
                                      .completebokingmodel
                                      ?.response!
                                      .upcomingbookinglist![index]
                                      .bookingPujaDate ??
                                      "",
                                // "13 march 2022 12:40",
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: blackColor),
                                ),
                                const SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  completeBookingViewModel
                                      .completebokingmodel
                                      ?.response!
                                      .upcomingbookinglist![index].address ?? "",
                                      //"H 32 noida ,uttar pradesh",
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 14,
                                      color: h1Color),
                                ),
                                // const Padding(
                                //   padding: EdgeInsets.only(
                                //       left: 16, right: 16, top: 10),
                                //   child: DottedLine(),
                                // ),
                                const SizedBox(
                                  height: 8,
                                ),
                                Text(BOOKING_BY+"${ completeBookingViewModel
                                    .completebokingmodel
                                    ?.response!
                                    .upcomingbookinglist![index].name ?? ""}",
                                     // "Govind kumar",
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                      color: h1Color),
                                ),


                                SizedBox(height: 15,),
                                Container(
                                  width: double.infinity,
                                  height: 48,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      color: buttonColor),
                                  child: Center(
                                      child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        BookingDetailsScreen(
                                                            bookingId: completeBookingViewModel
                                                                .completebokingmodel!
                                                                .response!
                                                                .upcomingbookinglist![index]
                                                                .id.toString())));
                                          },
                                          child: Text(
                                            "Visit on 13 March",
                                            style: GoogleFonts.lato(
                                                fontSize: 16,
                                                color: white,
                                                fontWeight: FontWeight.w500),
                                          ))),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
            itemCount: completeBookingViewModel
                .completebokingmodel?.response!.upcomingbookinglist!.length,
          )),
    );
  }

  Widget CompletedPage() {
    int index;

    return RefreshIndicator(
      onRefresh: () async{
        await _refresh(true, context);
      },
      color: kPrimaryColor,
      strokeWidth: 5,
      displacement: 0,
      child: ListView.builder(
        itemCount: completeBookingViewModel
            .completebokingmodel?.response!.compbookinglist!.length,
        itemBuilder: (context, int index) {
          return Container(
            child: Column(
              children: [
                Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        width: double.infinity,
                        height: 226,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(width: 1, color: kSecondaryColor)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 19, right: 19, top: 10),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(
                                        Icons.calendar_month,
                                        color: kPrimaryColor,
                                      ),
                                      const SizedBox(
                                        width: 11,
                                      ),
                                      Text(
                                        //"Mon 05/Oct/2021",
                                        completeBookingViewModel
                                            .completebokingmodel!
                                            .response!
                                            .compbookinglist![0]
                                            .poojaDate ??
                                            "",
                                        style: GoogleFonts.lato(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                            color: const Color(0xff232323)),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Icon(Icons.location_on,
                                          color: h1Color),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Center(
                                child: Text(
                                  completeBookingViewModel
                                      .completebokingmodel!
                                      .response!
                                      .compbookinglist![0]
                                      .hostname ??
                                      "",
                                  style: GoogleFonts.lato(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12,
                                      color: kPrimaryColor),
                                )),
                            const SizedBox(
                              height: 3,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16, top: 2),
                              child: Text(
                                BOOKING_LIST,
                                style: GoogleFonts.lato(
                                    fontSize: 14, fontWeight: FontWeight.w600),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "1 x ${completeBookingViewModel.completebokingmodel!.response!.compbookinglist![index].poojaTitle ?? ""}",
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: h1Color),
                              ),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 16),
                              child: Text(
                                "1 x Astrology",
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 14,
                                    color: h1Color),
                              ),
                            ),
                            const Padding(
                              padding:
                              EdgeInsets.only(left: 16, right: 16, top: 10),
                              child: DottedLine(),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(TOTAL_EARNING),
                                Text(
                                  "${completeBookingViewModel.completebokingmodel!.response!.compbookinglist![index].totalEarning ?? ""}",
                                  style: GoogleFonts.lato(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: h1Color),
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 16, right: 16, top: 10),
                              child: Container(
                                width: double.infinity,
                                height: 48,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    color: b1Color),
                                child: Center(
                                    child: TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          VIEWEARNINGS,
                                          style: GoogleFonts.lato(
                                              fontSize: 16,
                                              color: white,
                                              fontWeight: FontWeight.w500),
                                        ))),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        //itemCount: 5,

      ),
    );
  }

  Widget Cancelled() {
    return Container(
        child: RefreshIndicator(
          onRefresh: () async{
            await _refresh(true, context);
          },
          color: kPrimaryColor,
          strokeWidth: 5,
          displacement: 0,
          child: ListView.builder(

            itemCount: completeBookingViewModel
                .completebokingmodel?.response!.cancelbookinglist!.length,
            itemBuilder: (context, int index) {
              return Container(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.only(left: 24,right: 24,top: 20),
                        //alignment: Alignment.bottomCenter,
                        width: double.infinity,
                        height: 160,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            border: Border.all(width: 1, color: kPrimaryColor)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                           // SizedBox(height: 24,),
                           /* Text(
                              "${completeBookingViewModel.completebokingmodel?.response!
                                .cancelbookinglist![index].poojaTitle ?? ""}   " "(Cancel)",
                              //"Puja title katha",
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                  color: kPrimaryColor),
                            ),*/
                            Row(children: [
                              Text(
                                "${completeBookingViewModel.completebokingmodel?.response!
                                    .cancelbookinglist![index].poojaTitle ?? ""}",
                                //"Puja title katha",
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                   // color: kPrimaryColor
                                ),
                              ),
                              Text(" (Cancel)",
                                //"Puja title katha",
                                style: GoogleFonts.lato(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 14,
                                    color: kPrimaryColor),
                              ),
                            ],),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              // completeBookingViewModel
                              //     .completebokingmodel
                              //     ?.response!
                              //     .upcomingbookinglist![index]
                              //     .name ??
                              //     "",
                              BOOKING_NO+"#098767",
                              style: GoogleFonts.lato(
                                  fontSize: 14,
                                  color:Colors.grey,
                                  fontWeight: FontWeight.w600),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              completeBookingViewModel
                                  .completebokingmodel
                                  ?.response!
                                  .cancelbookinglist![index]
                                  .bookingPujaDate ??
                                  "",
                              // "13 march 2022 12:40",
                              style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: blackColor),
                            ),
                            const SizedBox(
                              height: 4,
                            ),
                            Text(
                              completeBookingViewModel
                                  .completebokingmodel
                                  ?.response!
                                  .cancelbookinglist![index].poojaTitle ?? "",
                              //"H 32 noida ,uttar pradesh",
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w400,
                                  fontSize: 14,
                                  color: h1Color),
                            ),
                            // const Padding(
                            //   padding: EdgeInsets.only(
                            //       left: 16, right: 16, top: 10),
                            //   child: DottedLine(),
                            // ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(BOOKING_BY+"${ completeBookingViewModel
                                .completebokingmodel
                                ?.response!
                                .cancelbookinglist![index].name ?? ""}",
                              // "Govind kumar",
                              style: GoogleFonts.lato(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: h1Color),
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            //itemCount: 20,

          ),
        ));
  }
}