import 'package:flutter/material.dart';
import 'package:panditapp/Consts/user_Error.dart';
import 'package:panditapp/Util/Api_collection.dart';
import 'package:panditapp/Util/api_status.dart';
import 'package:panditapp/repo/api_remote_services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/Earnings/Earnings_Home_Model.dart';

class Earnings_Home_VM with ChangeNotifier{
  bool _loading = false;
  EarningsHomeModel? _earningsHomeModel;
  UserError? _userError;

  bool get loading => _loading;
  EarningsHomeModel? get earningsHomeModel => _earningsHomeModel;
  UserError? get userError => _userError;

  setLoading(loading){
    _loading = loading;
    notifyListeners();
  }

  setEarningsHomeModel(EarningsHomeModel earningsHomeModel){
    _earningsHomeModel=earningsHomeModel;
    notifyListeners();
  }
  setUserError(UserError userError){
    _userError = _userError;
    notifyListeners();
  }



  earningshomeAPIcall() async{
    setLoading(true);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString("pandit_id");

    Map<String , dynamic> data={
      "pandit_id": userId,
      // "pandit_id": "7",
    };

    var response = await ApiRemoteServices.fechingGetApi(
        apiUrl:GET_EARNINGSHOME_API,apiData: data);
    if(response is Success){
      Object data = earningsHomeModelFromJson(response.response as String);

      setEarningsHomeModel(data as EarningsHomeModel);
      notifyListeners();
    }
    else if (response is Failure){
      UserError userError  =
      UserError(code: response.code,message: response.errorResponse);
      setUserError(userError);
    }
    setLoading(false);
  }

}