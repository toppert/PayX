import 'package:payx/controller/image_controller.dart';
import 'package:payx/controller/profile_screen_controller.dart';
import 'package:payx/data/api/api_checker.dart';
import 'package:payx/data/api/api_client.dart';
import 'package:payx/data/model/body/edit_profile_body.dart';
import 'package:payx/data/model/response/response_model.dart';
import 'package:payx/data/repository/auth_repo.dart';
import 'package:payx/view/base/custom_snackbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class EditProfileController extends GetxController implements GetxService{
  final AuthRepo authRepo;
  EditProfileController({@required this.authRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _image ;
  String get image => _image;
  setImage(String image){
    _image = image;
  }

  ///gender
  String _gender;
  String get gender => _gender;

  setGender(String select){
    _gender = select;
    update();
    print(_gender);
  }

  ///occupation
  String _occupation ;
  String get occupation => _occupation;

  Future<bool> updateProfileData(EditProfileBody editProfileBody,List<MultipartBody> multipartBody) async{
    _isLoading = true;
    bool _emailValidation = true;
    bool _isSuccess = false;
    update();
    Map<String, String> _allProfileInfo = {
      'f_name': editProfileBody.fName,
      'l_name': editProfileBody.lName,
      'gender': editProfileBody.gender,
      'occupation': editProfileBody.occupation,
      '_method': 'put',
    };
    if(editProfileBody.email != '') {
      bool _emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(editProfileBody.email);

      if(_emailValid){
        _allProfileInfo.addAll({'email': editProfileBody.email});
      }else{
        _emailValidation = _emailValid;
      }
    }

    if(!_emailValidation) {
      showCustomSnackBar('please_provide_valid_email'.tr);
      _isLoading = false;
      update();
    }else {
      Response response = await authRepo.updateProfile(_allProfileInfo, multipartBody);
      ResponseModel responseModel;
      print('update header : ${response.statusCode}');
      if (response.statusCode == 200) {
        responseModel = ResponseModel(true, response.body['message']);
        _isSuccess = true;
        if(Get.find<ImageController>().getImage != null) {
          Get.find<ImageController>().removeImage();
        }
        Get.find<ProfileController>().profileData(loading: true);
        Get.back();
        print(responseModel.message);
        showCustomSnackBar(responseModel.message, isError: false);
      }
      else {
        ApiChecker.checkApi(response);
      }
      _isLoading = false;
      update();
    }
    return _isSuccess;
  }
}