import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../../../Consts/color1.dart';
import '../../../../Widgets/circular_loader.dart';
import '../../../../consts/text_const.dart';
import '../../../../view_model/Profile/Bank Account Details/Bank_List_VM.dart';
import '../../../../view_model/Profile/Bank Account Details/Pandit_Bank_List_VM.dart';
import '../../../../view_model/Profile/Bank Account Details/Update_Bank_VM.dart';
import 'Personal_Bank_Details.dart';

class Bank_Account_Screen extends StatefulWidget {
  String? id;
  String? name;
  String? accountNumber;
  String? bankName;
  String? ifscCode;

  Bank_Account_Screen({
    Key? key,
    this.id,
    this.name,
    this.accountNumber,
    this.bankName,
    this.ifscCode,
  }) : super(key: key);

  @override
  State<Bank_Account_Screen> createState() => _Bank_Account_ScreenState();
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class _Bank_Account_ScreenState extends State<Bank_Account_Screen> {
  List<dynamic> countries = [];
  String? couuntryId;

  final _namecontroller = TextEditingController();
  final _accountnocontroller = TextEditingController();
  final _banknamecontroller = TextEditingController();
  final _ifsccodecontroller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.countries.add({"id": 1, "label": "Bank of India", "status": "0"});
    this.countries.add({"id": 2, "label": "Bank of Baroda", "status": "0"});
    this.countries.add(
        {"id": 3, "label": "Punjab National Bank", "status": "0"});
    this.countries.add(
        {"id": 4, "label": "Kotak Mahindra Bank", "status": "0"});
    this.countries.add({"id": 5, "label": "Axis Bank", "status": "0"});
    this.countries.add({"id": 6, "label": "ICICI Bank", "status": "0"});
    this.countries.add(
        {"id": 7, "label": "State Bank of India", "status": "0"});


    _namecontroller.text = widget.name.toString();
    _accountnocontroller.text = widget.accountNumber.toString();
    couuntryId = widget.bankName.toString();
    _ifsccodecontroller.text = widget.ifscCode.toString();
    _banknamecontroller.text = widget.bankName.toString();
  }

  @override
  Widget build(BuildContext context) {
    BankList_VM bankList_VM = context.watch<BankList_VM>();

    return Consumer<BankList_VM>(
      builder: (context, provider, child) {
        return Scaffold(
          //Bottom button
            bottomNavigationBar: Padding(
              padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 22, top: 16),
              child: GestureDetector(
                onTap: () {
                  Update_Bank_VM updatebanklist = Provider.of<Update_Bank_VM>(
                      context, listen: false);
                  updatebanklist.Update_Bank_APIcall(
                    id: widget.id,
                    name: _namecontroller.text,
                    accountno: _accountnocontroller.text,
                    bankname: _banknamecontroller.text,
                    ifsccode: _ifsccodecontroller.text,
                  );

                  Navigator.pop(context, MaterialPageRoute(
                      builder: (context) => Persional_Bank_Details(bank_id: "",)));
                },
                child:
                provider.loading? Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  child: CircularProgressIndicator(color: kPrimaryColor,),
                ) :
                Container(
                  //padding: EdgeInsets.only(left: 16,right: 16),
                  width: double.infinity,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: colorPrimary),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 13.0),
                    child: Text(
                      UPDATE_BANK_DETAILS,
                      style: GoogleFonts.lato(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: colorPrimary),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
            appBar: AppBar(
              title: Hero(tag: "_text", child: Text(UPDATE_BANK_DETAILS)),
            ),
            body: bankList_VM.loading
                ? Center(child: CircularLoader())
                : SingleChildScrollView(
              child: SafeArea(
                child:
                //wrap with single child view
                Container(
                  padding: EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 24,
                      ),
                      Text(
                        ACCOUNT_HOLDER_NAME,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: h1Color),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Center(
                          child: SizedBox(
                            height: 48,
                            child: TextField(
                                cursorColor: colorPrimary,
                                controller: _namecontroller,
                                keyboardType: TextInputType.name,
                                decoration: InputDecoration(
                                    fillColor: grey,
                                    hintText: ACCOUNT_HOLDER_NAME,
                                    hintStyle: TextStyle(fontSize: 15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: colorPrimary, width: 2.0),
                                      // borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(

                                      //borderRadius: BorderRadius.circular(24)
                                    )),
                              inputFormatters: [
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-z A-Z]")),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        ACCOUNT_NO,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: h1Color),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Center(
                          child: SizedBox(
                            height: 48,
                            child: TextField(
                                cursorColor: colorPrimary,
                                controller: _accountnocontroller,
                                //keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    fillColor: grey,
                                    hintText: ACCOUNT_NO,
                                    hintStyle: TextStyle(fontSize: 15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: colorPrimary, width: 2.0),
                                      // borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(

                                      //borderRadius: BorderRadius.circular(24)
                                    )),
                              inputFormatters: [
                                //LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[0-9]")),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        CHOOSE_BANK,
                        style: GoogleFonts.lato(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: h1Color),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Center(
                          child: SizedBox(
                            height: 48,
                            child: TextField(
                                cursorColor: colorPrimary,
                                controller: _banknamecontroller,
                                //keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    fillColor: grey,
                                    hintText: IFSC_CODE,
                                    hintStyle: TextStyle(fontSize: 15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: colorPrimary, width: 2.0),
                                      // borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(

                                      //borderRadius: BorderRadius.circular(24)
                                    )),
                              inputFormatters: [
                                //LengthLimitingTextInputFormatter(10),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-z A-Z]")),
                              ],
                            ),
                          ),
                        ),
                      ),


                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        IFSC_CODE,
                        style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: h1Color),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 0, right: 0),
                        child: Center(
                          child: SizedBox(
                            height: 48,
                            child: TextField(
                                cursorColor: colorPrimary,
                                controller: _ifsccodecontroller,
                                //keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    fillColor: grey,
                                    hintText: IFSC_CODE,
                                    hintStyle: TextStyle(fontSize: 15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: colorPrimary, width: 2.0),
                                      // borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(

                                      //borderRadius: BorderRadius.circular(24)
                                    )),
                              inputFormatters: [
                                LengthLimitingTextInputFormatter(11),
                                UpperCaseTextFormatter(),
                                FilteringTextInputFormatter.allow(
                                    RegExp("[a-z A-Z 0-9]")),
                              ],
                              textCapitalization:TextCapitalization.characters,

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ));
      },
    );
  }
}
