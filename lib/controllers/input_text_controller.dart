import 'package:flutter/material.dart';
import 'package:postal_codes_app/models/postal_code_request_model.dart';
import 'package:postal_codes_app/services/postal_code_web_service.dart';

class InputTextController {
  final TextEditingController textController = TextEditingController();

  String? validatePostalCode(String postalCode) {
    if (postalCode.isEmpty) {
      return 'El camp no pot estar buit.';
    }
    if (postalCode.length != 5 || int.tryParse(postalCode) == null) {
      return 'El codi postal ha de tenir exactament 5 dígits.';
    }
    return null;
  }

  Future<PostalCodeRequestModel?> fetchPostalCodeData(String postalCode) async {
    return await PostalCodeWebService.instance
        .getFromApiWithPostalCode(postalCode);
  }
}
