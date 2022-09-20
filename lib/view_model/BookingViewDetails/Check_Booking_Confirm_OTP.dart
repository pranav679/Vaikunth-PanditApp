import 'package:flutter/cupertino.dart';
import 'package:panditapp/Consts/user_Error.dart';
import 'package:panditapp/Util/api_status.dart';
import 'package:panditapp/repo/api_remote_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Util/Api_collection.dart';
import '../../model/Booking_View_Details/Check_booking_OTP_Model.dart';

class Check_Booking_Confirm_OTP_View_Model with ChangeNotifier {
  bool _loading = false;
  CheckBookingConfirmOtpModel? _bookingConfirmOtpModel;
  UserError? _userError;

  bool get loading => _loading;

  CheckBookingConfirmOtpModel? get getcheckBookingConfirmOtpModel =>
      _bookingConfirmOtpModel;

  UserError? get userError => _userError;

  setLoading(bool loading) {
    _loading = loading;
    notifyListeners();
  }

  setGetCheckBookingConfirmOtpModel(
      CheckBookingConfirmOtpModel checkBookingConfirmOtpModel) {
    _bookingConfirmOtpModel = checkBookingConfirmOtpModel;
    notifyListeners();
  }

  setUserError(UserError userError) {
    _userError = userError;
    notifyListeners();
  }

  Future<bool> getCheckBookingConfirm(
      {required dynamic userBooking_id, otpcode}) async {
    setLoading(true);
    bool valueReturn = true;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("pandit_id");
    print("Pandit App user Id = ${userId}");
    Map<String, dynamic> data = {
      "pandit_id": userId,
      "booking_id": userBooking_id.toString(),
      "code": otpcode
    };
    print("OTP AAGYA H ${otpcode}");
    print("BOOKING ID H Y ${userBooking_id}");
    var response = await ApiRemoteServices.fechingGetApi(
        apiUrl: GET_CHECK_BOOKING_OTP, apiData: data);
    if (response is Success) {
      print("Booking OTP ${response.response}");
      Object data =
          checkBookingConfirmOtpModelFromJson(response.response as String);
      setGetCheckBookingConfirmOtpModel(data as CheckBookingConfirmOtpModel);
      valueReturn =  true;
      notifyListeners();
    } else if (response is Failure) {
      UserError userError =
          UserError(code: response.code, message: response.errorResponse);
      setUserError(userError);
      valueReturn =  false;
      notifyListeners();
    }
    setLoading(false);
    return valueReturn;
  }

}
