import 'package:flutter/material.dart';
import 'package:panditapp/Consts/user_Error.dart';
import 'package:panditapp/Util/Api_collection.dart';
import 'package:panditapp/Util/api_status.dart';
import 'package:panditapp/repo/api_remote_services.dart';
import '../model/Profile_Screen/Bank_Account Details/Bank_List_Model.dart';
import '../model/Profile_Screen/Bank_Account Details/Pandit_Bank_List_Model.dart';
import '../model/Profile_Screen/Bank_Account Details/Store_Bank_Model.dart';
import '../model/Profile_Screen/Bank_Account Details/Update_Bank_Model.dart';
import '../model/Profile_Screen/Settings/Help_Support_Details_Model.dart';
import '../model/Service_Model.dart';

class Store_Bank_VM with ChangeNotifier{
  bool _loading = false;
  StoreBankModel? _storeBankModel;
  UserError? _userError;

  bool get loading => _loading;
  StoreBankModel? get storeBankModel => _storeBankModel;
  UserError? get userError => _userError;

  setLoading(loading){
    _loading = loading;
    notifyListeners();
  }

  setStoreBankModel(StoreBankModel storeBankModel){
    _storeBankModel = storeBankModel;
    notifyListeners();
  }
  setUserError(UserError userError){
    _userError = _userError;
    notifyListeners();
  }

  Store_Bank_APIcall({String? id, String? name,String? bankname,String? ifsccode,String? accountno}) async{
    setLoading(true);
    var data={

      "pandit_id": id,
          "account_holder_name":name,
          "bank_name": bankname,
          "ifsc_code": ifsccode,
          "bank_account_no":accountno
     /* //"bank_id":id,
     // "pandit_id":id,
      "account_holder_name":name,
      "bank_name": bankname,
      "ifsc_code": ifsccode,
      "bank_account_no":accountno*/
    };
    //"pandit_id": "7",
    //     "account_holder_name":"Guddu Tiwari",
    //     "bank_name": "ICICI Bank",
    //     "ifsc_code": "HDFC0123654",
    //     "bank_account_no":"12345678781"

    var response = await ApiRemoteServices.fechingGetApi(
        apiUrl:GET_STOREBANK_API,apiData: data);
    if(response is Success){
      Object data = storeBankModelFromJson(response.response as String);
      print("Govind Store bank ${response.response as String}");
      setStoreBankModel(data as StoreBankModel);
    }
    else if (response is Failure){
      UserError userError  =
      UserError(code: response.code,message: response.errorResponse);
      setUserError(userError);
    }
    setLoading(false);
  }

}