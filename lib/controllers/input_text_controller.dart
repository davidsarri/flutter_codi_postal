import 'package:flutter/material.dart';
import 'package:postal_codes_app/models/postal_code_request_model.dart';
import 'package:postal_codes_app/services/postal_code_web_service.dart';

class InputTextController {
  final TextEditingController textController = TextEditingController();

  Future<PostalCodeRequestModel?> fetchPostalCodeData(String postalCode) async {
    return await PostalCodeWebService.instance
        .getFromApiWithPostalCode(postalCode);
  }
}
