import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panditapp/Widgets/circular_loader.dart';
import 'package:panditapp/consts/text_const.dart';

import 'package:panditapp/View/Home/Home_Screen.dart';

import 'package:panditapp/view_model/Profile/Bank%20Account%20Details/Bank_List_VM.dart';
import 'package:provider/provider.dart';

import '../../Util/login_in_User.dart';
import '../../consts/themescolor.dart';
import '../../view_model/Login/ApiCallLogin.dart';

class AccountDetail extends StatefulWidget {
  final String? aadhar, pancard, name, mobile, servicesname, cityId;
  final File? photo, photoaadharfront, photoaadharback, pan;

  AccountDetail({
    Key? key,
    this.aadhar,
    this.pancard,
    this.name,
    this.cityId,
    this.photo,
    this.mobile,
    this.photoaadharback,
    this.photoaadharfront,
    this.pan,
    this.servicesname,
  }) : super(key: key);

  @override
  State<AccountDetail> createState() => _AccountDetailState();
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

class _AccountDetailState extends State<AccountDetail> {
  var ht, wt;

  final TextEditingController _bankName = TextEditingController();
  final TextEditingController _accountNumber = TextEditingController();
  final TextEditingController _confirmAccountNumber = TextEditingController();
  final TextEditingController _accountHolderName = TextEditingController();
  final TextEditingController _ifscCode = TextEditingController();

  late BankListVM bankList_VM;
  String? bankNameValue;
  bool isBankListVisible = false;
  List list = [];
  String searchValue = "";

  @override
  void initState() {
    // TODO: implement initState
    bankList_VM = Provider.of<BankListVM>(context, listen: false);
    bankList_VM.bankListAPIcall(data: {});
    super.initState();
  }

  Widget stepContainer({Color? color}) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.12,
      height: 4,
      decoration:
          BoxDecoration(color: color, borderRadius: BorderRadius.circular(40)),
    );
  }

  ApiCallLogin api = ApiCallLogin();

  @override
  Widget build(BuildContext context) {
    wt = MediaQuery.of(context).size.width;
    ht = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: white,
      body: Consumer<BankListVM>(
        builder: (_, provider, __) =>
            provider.loading ? const Center(child: CircularLoader()) : body(),
      ),
    );
  }

  Widget dropDown() {
    return Consumer<BankListVM>(
        builder: (_, provider, __) => DropdownButtonHideUnderline(
              child: DropdownButton2(
                dropdownOverButton: true,
                isExpanded: true,
                hint: Row(
                  children: const [
                    SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: Text(
                        'Select bank',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.normal,
                          color: h1Color,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                items: provider.bankListModel?.response?.banklist
                    ?.map((item) => DropdownMenuItem<String>(
                          value: item.bankName == "Bank of India"
                              ? ""
                              : item.bankName,
                          child: Text(
                            item.bankName ?? "",
                            style: const TextStyle(
                              fontSize: 16,
                              color: p1Color,
                              letterSpacing: 0.50,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ))
                    .toList(),
                value: bankNameValue,
                onChanged: (value) {
                  if (value != null && value != "") {
                    setState(() {
                      bankNameValue = value.toString();
                    });
                  }
                },
                icon: const Icon(
                  Icons.keyboard_arrow_down_sharp,
                  size: 30,
                ),
                iconSize: 14,
                iconEnabledColor: const Color(0xff252525),
                iconDisabledColor: h1Color,
                buttonHeight: 50,
                buttonPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 13,
                ),
                buttonDecoration: BoxDecoration(
                  color: TEXTFIELD_BACKGROUND_COLOR,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                  border: Border.all(
                    color: TEXTFIELD_BORDER_COLOR,
                  ),
                ),
                dropdownMaxHeight: ht * 0.3,
                dropdownWidth: wt * 0.92,
                dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(14),
                  color: TEXTFIELD_BACKGROUND_COLOR,
                ),
                dropdownElevation: 1,
                scrollbarRadius: const Radius.circular(40),
                scrollbarThickness: 6,
                scrollbarAlwaysShow: true,
                offset: const Offset(0, 0),
              ),
            ));
  }

  Widget accountHolderName() {
    return TextField(
      cursorColor: colorPrimary,
      controller: _accountHolderName,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: h1Color,
      ),
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: ACCOUNT_HOLDER_NAME,
        helperStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: p1Color,
        ),
        filled: true,
        fillColor: TEXTFIELD_BACKGROUND_COLOR,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: TEXTFIELD_BORDER_COLOR, width: 1.0),
        ),
        enabled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: TEXTFIELD_BORDER_COLOR, width: 1.0),
        ),
      ),
      inputFormatters: [
        //LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
      ],
    );
  }

  Widget accountNumber() {
    return TextField(
      cursorColor: colorPrimary,
      controller: _accountNumber,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: h1Color,
      ),
      onChanged: (value) {
        setState(() {});
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: ACCOUNT_NUMBER,
        helperStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: p1Color,
        ),
        filled: true,
        fillColor: TEXTFIELD_BACKGROUND_COLOR,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: TEXTFIELD_BORDER_COLOR, width: 1.0),
        ),
        enabled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: TEXTFIELD_BORDER_COLOR, width: 1.0),
        ),
      ),
      inputFormatters: [
        //LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ],
    );
  }

  Widget confirmAccountNumber() {
    return TextField(
      cursorColor: colorPrimary,
      controller: _confirmAccountNumber,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: h1Color,
      ),
      onChanged: (value) {
        setState(() {});
      },
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        hintText: CONFIRM_ACCOUNT_NUMBER,
        helperStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: p1Color,
        ),
        filled: true,
        fillColor: TEXTFIELD_BACKGROUND_COLOR,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: TEXTFIELD_BORDER_COLOR, width: 1.0),
        ),
        enabled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: TEXTFIELD_BORDER_COLOR, width: 1.0),
        ),
      ),
      inputFormatters: [
        //LengthLimitingTextInputFormatter(10),
        FilteringTextInputFormatter.allow(RegExp("[0-9]")),
      ],
    );
  }

  Widget ifscCode() {
    return TextField(
      cursorColor: colorPrimary,
      controller: _ifscCode,
      style: GoogleFonts.poppins(
        fontSize: 14,
        color: h1Color,
      ),
      onChanged: (value) {
        setState(() {});
      },
      decoration: InputDecoration(
        hintText: IFSC_CODE,
        helperStyle: GoogleFonts.poppins(
          fontSize: 14,
          color: p1Color,
        ),
        filled: true,
        fillColor: TEXTFIELD_BACKGROUND_COLOR,
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: TEXTFIELD_BORDER_COLOR, width: 1.0),
        ),
        enabled: true,
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: TEXTFIELD_BORDER_COLOR, width: 1.0),
        ),
      ),
      inputFormatters: [
        //LengthLimitingTextInputFormatter(10),
        UpperCaseTextFormatter(),
        FilteringTextInputFormatter.allow(RegExp("[a-z A-Z 0-9]")),
      ],
    );
  }

  Widget button() {
    return (_bankName.text.isEmpty ||
            _ifscCode.text.isEmpty ||
            _accountNumber.text.isEmpty ||
            _accountHolderName.text.isEmpty ||
            _confirmAccountNumber.text.isEmpty ||
            !(_accountNumber.text == _confirmAccountNumber.text))
        ? Container()
        : SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              style: ButtonStyle(
                alignment: Alignment.center,
                padding: MaterialStateProperty.resolveWith(
                    (states) => const EdgeInsets.symmetric(
                          vertical: 13,
                        )),
                backgroundColor:
                    MaterialStateColor.resolveWith((states) => colorPrimary),
              ),
              onPressed: () async {
                print(widget.mobile.toString() + " " + widget.name.toString());
                await bankList_VM.fechingloginApi(
                  mobile: widget.mobile,
                  name: widget.name,
                  services: widget.servicesname,
                  city: widget.cityId,
                  aadharnumber: widget.aadhar,
                  pannumber: widget.pancard,
                  account_number: _accountNumber.text,
                  bank: _bankName.text,
                  ifsc: _ifscCode.text,
                  photo: widget.photo,
                  aadharbackphoto: widget.photoaadharback,
                  aadharfrontphoto: widget.photoaadharfront,
                  panfile: widget.pan,
                  accountHolderName: _accountHolderName.text,
                  context: context,
                );
              },
              child: Text(
                FINISH,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: white,
                ),
              ),
            ),
          );
    ;
  }

  Widget bankName() {
    return Consumer<BankListVM>(
      builder: (_, provider, __) => TextField(
        cursorColor: colorPrimary,
        controller: _bankName,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: h1Color,
        ),
        readOnly: true,
        onTap: () {
          setState(() {
            list.clear();
            provider.bankListModel?.response?.banklist?.forEach((element) {
              list.add(element.bankName);
            });
            isBankListVisible = !isBankListVisible;
          });
        },
        decoration: InputDecoration(
          hintText: SELECT_BANK,
          helperStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: p1Color,
          ),
          suffixIcon: isBankListVisible
              ? const Icon(
                  Icons.keyboard_arrow_up,
                  color: h1Color,
                )
              : const Icon(
                  Icons.keyboard_arrow_down,
                  color: h1Color,
                ),
          filled: true,
          fillColor: TEXTFIELD_BACKGROUND_COLOR,
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: TEXTFIELD_BORDER_COLOR, width: 1.0),
          ),
          enabled: true,
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: TEXTFIELD_BORDER_COLOR, width: 1.0),
          ),
        ),
        inputFormatters: [
          //LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
        ],
      ),
    );
  }

  Widget bankList() {
    return Container(
      width: double.infinity,
      height: 400,
      decoration: BoxDecoration(
        color: TEXTFIELD_BACKGROUND_COLOR,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          searchBank(),
          Expanded(child: Consumer<BankListVM>(builder: (_, provider, __) {
            return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) => GestureDetector(
                      onTap: () {
                        setState(() {
                          _bankName.text = list[index];
                          isBankListVisible = !isBankListVisible;
                        });
                      },
                      child: Text(
                        list[index] ?? "",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          color: h1Color,
                        ),
                      ),
                    ),
                separatorBuilder: (context, index) => const Divider(),
                itemCount: list.length ?? 0);
          }))
        ],
      ),
    );
  }

  Widget searchBank() {
    return Consumer<BankListVM>(
      builder: (_, provider, __) => TextField(
        cursorColor: colorPrimary,
        style: GoogleFonts.poppins(
          fontSize: 14,
          color: h1Color,
        ),
        onChanged: (value) {
          setState(() {
            if (value.length > 2) {
              list = list
                  .where((element) => element
                      .toString()
                      .toLowerCase()
                      .contains(value.toLowerCase()))
                  .toList();
            } else {
              list.clear();
              provider.bankListModel?.response?.banklist?.forEach((element) {
                list.add(element.bankName);
              });
            }
          });
        },
        decoration: InputDecoration(
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          border: const UnderlineInputBorder(
            borderSide: BorderSide(color: kPrimaryColor),
          ),
          hintText: SELECT_BANK,
          helperStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: p1Color,
          ),
          filled: true,
          fillColor: TEXTFIELD_BACKGROUND_COLOR,
          focusColor: kPrimaryColor,
          // focusedBorder: const OutlineInputBorder(
          //   borderSide: BorderSide(color: TEXTFIELD_BORDER_COLOR, width: 0.0),
          // ),
          // enabled: true,
          // enabledBorder: const OutlineInputBorder(
          //   borderSide: BorderSide(color: TEXTFIELD_BORDER_COLOR, width: 0.0),
          // ),
        ),
        inputFormatters: [
          //LengthLimitingTextInputFormatter(10),
          FilteringTextInputFormatter.allow(RegExp("[a-z A-Z]")),
        ],
      ),
    );
  }

  Widget body() {
    return Consumer<BankListVM>(
      builder: (_, provider, __) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          stepContainer(
                            color: kSecondaryColor,
                          ),
                          stepContainer(
                            color: kSecondaryColor,
                          ),
                          stepContainer(
                            color: kSecondaryColor,
                          ),
                          stepContainer(
                            color: kSecondaryColor,
                          ),
                          stepContainer(
                            color: kSecondaryColor,
                          ),
                          stepContainer(
                            color: kPrimaryColor,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        FILL_YOUR_PROFILE_DETAILS,
                        style: GoogleFonts.poppins(
                          color: h1Color,
                          fontWeight: FontWeight.w700,
                          fontSize: 20,
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Text(
                        BANK_DETAIL,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w500,
                          fontSize: 16,
                          color: p1Color,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      //dropDown(),
                      bankName(),
                      isBankListVisible
                          ? Container()
                          : const SizedBox(
                              height: 10,
                            ),
                      isBankListVisible ? bankList() : Container(),
                      isBankListVisible ? Container() : accountHolderName(),
                      isBankListVisible
                          ? Container()
                          : const SizedBox(
                              height: 10,
                            ),
                      isBankListVisible ? Container() : accountNumber(),
                      const SizedBox(
                        height: 10,
                      ),
                      isBankListVisible ? Container() : confirmAccountNumber(),
                      isBankListVisible
                          ? Container()
                          : const SizedBox(
                              height: 10,
                            ),
                      isBankListVisible ? Container() : ifscCode(),
                    ],
                  ),
                ),
              ),
              button(),
            ],
          ),
        ),
      ),
    );
  }
}
