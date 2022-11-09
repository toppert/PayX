import 'package:flutter/material.dart';
import 'package:payx/data/model/response/language_model.dart';
import 'package:payx/util/app_constants.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext context}) {
    return AppConstants.languages;
  }
}
