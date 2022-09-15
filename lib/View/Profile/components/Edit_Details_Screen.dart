import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../Consts/color1.dart';
import '../../../Consts/text_const.dart';
import '../../../view_model/Service_VM.dart';

class Edit_Details_Screen extends StatefulWidget {
  const Edit_Details_Screen({Key? key}) : super(key: key);

  @override
  State<Edit_Details_Screen> createState() => _Edit_Details_ScreenState();
}

class _Edit_Details_ScreenState extends State<Edit_Details_Screen> {

  late ServiceVM serviceVM;
  var ht,wt;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
     serviceVM = Provider.of<ServiceVM>(context, listen: false);
    wt = MediaQuery.of(context).size.width;
    ht = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,

      appBar: AppBar(
        title: Text("Edit Details"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16,right: 16,top: 32),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(NAME,style: GoogleFonts.lato(
                          fontSize: 18,fontWeight: FontWeight.w500,color: h1Color),),
                      SizedBox(height: 12,),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          height:48,
                          child:
                          TextField(
                              cursorColor: colorPrimary,
                              // controller: _namecontroller,
                              //keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  fillColor:grey,
                                  hintText:"Name",
                                  hintStyle: TextStyle(fontSize: 15),

                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: colorPrimary, width: 2.0),
                                    // borderRadius: BorderRadius.circular(25.0),
                                  ),


                                  border: OutlineInputBorder(

                                    //borderRadius: BorderRadius.circular(24)
                                  )
                              )
                          ),

                        ),
                      ),
                      SizedBox(height: 32,),
                      Text("Services offered",style: GoogleFonts.lato(fontSize: 18,fontWeight: FontWeight.w500),)
                        ,SizedBox(height: 9.0,),
                      Row(
                        children: [
                             Image.asset("assets/images/chopada_pujan_book.png")
                            ,SizedBox(width: 23,) ,Text("Puja", style: GoogleFonts.lato(fontWeight: FontWeight.w400,fontSize: 14,color: kPrimaryColor),)

                        ],
                      ),
                        SizedBox(height: 14,),
                      Row(
                        children: [
                          Image.asset("assets/images/cemetery.png")
                          ,SizedBox(width: 23,) ,Text("Funeral Services", style: GoogleFonts.lato(fontWeight: FontWeight.w400,fontSize: 14,color: kPrimaryColor),)


                        ],
                      ),
                      SizedBox(height: 12,),
                      DottedBorder(
                         borderType: BorderType.RRect,
                          strokeWidth: 2,
                          dashPattern: [6,3,2,3],
                          color: kPrimaryColor,
                          radius: Radius.circular(4),
                          child: ClipRRect(

                            child: InkWell(
                              onTap: (){
                                showModalBottomSheet(
                                  context: context,
                                  builder: (builder)=> bottomSheet(),
                                );
                              },
                              child: Container(
                                width: double.infinity,
                                height: 46,
                                child: Center(child: Text("Add/Remove services",style: GoogleFonts.lato(fontSize: 18,fontWeight: FontWeight.w500,color: kPrimaryColor),)),
                              ),
                            ),
                          )

                      ),
                      SizedBox(height: 44,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Text(serviceVM.serviceModel!.response!.serviceslist![0].name.toString()),
                          Text("City",style: GoogleFonts.lato(fontWeight: FontWeight.w500,fontSize: 18,),),
                          Text("EDIT",style: GoogleFonts.lato(fontSize: 18,fontWeight: FontWeight.w500,color: kPrimaryColor),)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Center(
                        child: SizedBox(
                          width: double.infinity,
                          height:48,
                          child:
                          TextField(
                              cursorColor: colorPrimary,
                             // controller: _namecontroller,
                              //keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  fillColor:grey,
                                  hintText:LOCATION,
                                  hintStyle: TextStyle(fontSize: 15),

                                  focusedBorder:OutlineInputBorder(
                                    borderSide: const BorderSide(color: colorPrimary, width: 2.0),
                                    // borderRadius: BorderRadius.circular(25.0),
                                  ),


                                  border: OutlineInputBorder(

                                    //borderRadius: BorderRadius.circular(24)
                                  )
                              )
                          ),

                        ),
                      ),

                    ],
                  ),
                )
            ],
          ),
        ),
      )
    );
  }
  Widget bottomSheet(){
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 350,
      margin:  EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
            Text("Services offered",style: GoogleFonts.lato(fontWeight: FontWeight.w500,fontSize: 16,color: kSecondaryColor),),
          SizedBox(
            height: 12,
          ),
          Text("Add/Remove services you offered.",style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.w600,color: h1Color),)
      ,SizedBox(
      height: 12,
    ),

        Expanded(
          child: Container(
              width: double.infinity,
              height: 400,
              child: ListView.separated(itemBuilder: (context, index) => GestureDetector(
                onTap: (){

                    _selectedIndex = index;
                    setState(() {});
                },
                child: Container(

                  width: wt*0.9,
                  height: ht* 0.07,

                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      border: Border.all(color: _selectedIndex == index ? kPrimaryColor : kSecondaryColor)

                  ),
                  child: Center(child:

                  Text(
                    serviceVM.serviceModel!.response!.serviceslist![index].name.toString(),
                    style: GoogleFonts.lato(fontWeight: FontWeight.w500,
                        fontSize: 16),
                  )),
                ),
              ), separatorBuilder: (context, index) => SizedBox(
                height: 12,
              ), itemCount: serviceVM.serviceModel!.response!.serviceslist!.length)),
        ),
          //Spacer(),

          GestureDetector(
            onTap: (){
              print("Container clickedd");
             // servicesname: serviceVM.serviceModel!.response!.serviceslist![_selectedIndex].name;
            },
            child: Container(
              width: wt*0.9,
              height: ht* 0.07,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: kPrimaryColor

              ),
              child: Center(child: Text("Save"
                , style: GoogleFonts.lato(fontWeight: FontWeight.w500,
                    fontSize: 16,color: white),
              )),
            ),
          )

        ],
      ),


    );
  }
}
