import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panditapp/view_model/Pandit_Bank_List_VM.dart';
import 'package:provider/provider.dart';
import '../../../../Consts/color1.dart';
import '../../../../Widgets/circular_loader.dart';
import 'Bank Account Details.dart';
class Persional_Bank_Details extends StatefulWidget {
  const Persional_Bank_Details({Key? key}) : super(key: key);

  @override
  State<Persional_Bank_Details> createState() => _Persional_Bank_DetailsState();
}

class _Persional_Bank_DetailsState extends State<Persional_Bank_Details> {


  @override
  Widget build(BuildContext context) {
     // Pandit_Bank_List_VM panditbanklist= Provider.of<Pandit_Bank_List_VM>(context,listen: false);
                          //panditbanklist.panditbankListAPIcall();
    Pandit_Bank_List_VM panditbanklist = context.watch<Pandit_Bank_List_VM>();
    return  Scaffold(
      bottomNavigationBar:
      Padding(
        padding: const EdgeInsets.only(left: 16,right: 16,bottom: 22,top: 16),
        child: GestureDetector(
          onTap: (){
            Navigator.push(context, MaterialPageRoute(


                builder: (context) => Bank_Account_Screen()));
          },
          child: Container(
            //padding: EdgeInsets.only(left: 16,right: 16),
            width: double.infinity,
            height: 48,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                  width: 1,
                  color: colorPrimary
              ),
            ),
            child:
              Padding(
                padding: const EdgeInsets.all(14.0),
                child:  Text("Add other bank",style: GoogleFonts.lato(fontWeight: FontWeight.w500,fontSize: 16,color: colorPrimary),textAlign: TextAlign.center,),
              ),
          ),
        ),
      ),
        appBar: AppBar(
          title: Center(child: Hero(
              tag: "_text",
              child: Text("Bank Account Details"))),
        ),
        body: panditbanklist.loading
            ? Center(child: CircularLoader())
            :
        SafeArea(
          child: ListView.separated(itemBuilder: (context , int index){
            return
              Container(
              padding: EdgeInsets.only(left: 16,right: 16,top: 16),
              child:Container(
                width: double.infinity,
                //height: 126,
                decoration: BoxDecoration(

                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                      width: 1.3,
                      color: kSecondaryColor

                  ),
                ),
                child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(children: [
                      Row(children: [
                        Text("Name : ",style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.w500,color: h1Color),),
                        Text(
                          //"Govind kumar"
                          panditbanklist.panditBankListModel!.response!.panditbanklist![index].accountHolderName.toString()
                          ,style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.w500,color: p1Color),),
                        Spacer(),
                        Row(children: [
                          InkWell(
                              onTap: (){},
                              child: Text("Edit",style: GoogleFonts.poppins(fontSize: 12,fontWeight: FontWeight.w500,color: black),)),
                          SizedBox(width: 13,),
                          InkWell(
                              onTap: (){},
                              child: Text("Delete",style: GoogleFonts.poppins(fontSize: 14,fontWeight: FontWeight.w500,color: red),)),
                        ],)
                      ],),
                      SizedBox(height: 10,),
                      Row(children: [
                        Text("Account No : ",style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.w500,color: h1Color),),
                        Text(panditbanklist.panditBankListModel!.response!.panditbanklist![index].bankAccountNo.toString(),style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.w500,color: p1Color),),
                      ],),
                      SizedBox(height: 14,),
                      Row(children: [
                        Text("Bank Name : ",style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.w500,color: h1Color),),
                        Text(panditbanklist.panditBankListModel!.response!.panditbanklist![index].bankName.toString(),style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.w500,color: p1Color),),
                      ],),
                      SizedBox(height: 14,),
                      Row(children: [
                        Text("IFSC Code : ",style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.w500,color: h1Color),),
                        Text(panditbanklist.panditBankListModel!.response!.panditbanklist![index].ifscCode.toString(),style: GoogleFonts.lato(fontSize: 14,fontWeight: FontWeight.w500,color: p1Color),),
                      ],),
                      SizedBox(height: 8,),
                    ],)
                ),
              ),

            );

          },
            separatorBuilder:(context,index) => SizedBox(height: 0,),
            //itemCount: 13,
            itemCount: panditbanklist.panditBankListModel!.response!.panditbanklist!.length,
          ),
        ));
  }
}