import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panditapp/view_model/Store_bank_VM.dart';
import 'package:provider/provider.dart';
import '../../../../Consts/color1.dart';
import '../../../../Consts/text_const.dart';
import '../../../../Widgets/circular_loader.dart';
import '../../../../view_model/Bank_List_VM.dart';
import '../../../../view_model/Update_Bank_VM.dart';
import 'Bank Account Details.dart';
import 'Personal_Bank_Details.dart';

class Add_Bank_Account extends StatefulWidget {
  String? id;
  String? name;
  String? accountNumber;
  String? bankName;
  String? ifscCode;

  Add_Bank_Account({
    Key? key,
    this.id,
    this.name,
    this.accountNumber,
    this.bankName,
    this.ifscCode,
  }) : super(key: key);

  @override
  State<Add_Bank_Account> createState() => _Add_Bank_AccountState();
}

class _Add_Bank_AccountState extends State<Add_Bank_Account> {
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
  }

  @override
  Widget build(BuildContext context) {
    Store_Bank_VM store_bank_vm = context.watch<Store_Bank_VM>();

    return Consumer<Store_Bank_VM>(
      builder: (context, provider, child) {
        return Scaffold(
          //Bottom button
            bottomNavigationBar: Padding(
              padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 22, top: 16),
              child: GestureDetector(
                onTap: () {
                  Store_Bank_VM storebank = Provider.of<Store_Bank_VM>(
                      context, listen: false);
                  storebank.Store_Bank_APIcall(

                    name: _namecontroller.text.toString(),
                    accountno: _accountnocontroller.text,
                    bankname: _banknamecontroller.text,
                    ifsccode: _ifsccodecontroller.text,
                  );

                  Navigator.pop(context, MaterialPageRoute(
                      builder: (context) =>
                          Persional_Bank_Details(bank_id: '',)));
                },
                child: provider.loading? Container(

                  child: CircularProgressIndicator(color: kPrimaryColor,),
                ) :Container(
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
                      SAVE,
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
              title: Hero(tag: "_text", child: Text("Add bank account")),
            ),
            body: store_bank_vm.loading
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
                        "Account Holder Name",
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
                                    hintText: "Account Holder Name",
                                    hintStyle: TextStyle(fontSize: 15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: colorPrimary, width: 2.0),
                                      // borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(

                                      //borderRadius: BorderRadius.circular(24)
                                    ))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Account No",
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
                                    hintText: "Account No.",
                                    hintStyle: TextStyle(fontSize: 15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: colorPrimary, width: 2.0),
                                      // borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(

                                      //borderRadius: BorderRadius.circular(24)
                                    ))),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "Choose Bank",
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
                                    hintText: "Choose bank",
                                    hintStyle: TextStyle(fontSize: 15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: colorPrimary, width: 2.0),
                                      // borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(

                                      //borderRadius: BorderRadius.circular(24)
                                    ))),
                          ),
                        ),
                      ),

                      /*SizedBox(
                          width: double.infinity,
                          height: 48,
                          child: FormHelper.dropDownWidget(
                            context,

                            "Select Bank",
                            this.couuntryId,
                            this.countries,
                           // controller: _banknamecontroller,

                            //bankList_VM.bankListModel!.response!.banklist!,
                            (onChangedVal) {
                              this.couuntryId = onChangedVal;
                              print("Selected Bank: $onChangedVal");
                            },
                            (onValidateVal) {
                              if (onValidateVal == null) {
                                return "please select Bank";
                              }
                              return null;
                            },

                            borderColor: kSecondaryColor,
                            borderFocusColor: colorPrimary,
                            borderRadius: 4,
                            optionValue: "id",
                            optionLabel: "label",
                            //optionLabel:bankList_VM.bankListModel!.response!.banklist![0].bankName.toString(),
                          ),
                        ),*/
                      SizedBox(
                        height: 16,
                      ),
                      Text(
                        "IFSC Code",
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
                                    hintText: "IFSC CODE",
                                    hintStyle: TextStyle(fontSize: 15),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: colorPrimary, width: 2.0),
                                      // borderRadius: BorderRadius.circular(25.0),
                                    ),
                                    border: OutlineInputBorder(

                                      //borderRadius: BorderRadius.circular(24)
                                    ))),
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
