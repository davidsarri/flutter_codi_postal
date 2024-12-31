import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/postal_code_request_model.dart';

class InputTextController {
  final TextEditingController textController = TextEditingController();

  // Valida el codi postal introduït
  String? validatePostalCode(String postalCode) {
    if (postalCode.isEmpty) {
      return 'El camp no pot estar buit.';
    }
    if (postalCode.length != 5 || int.tryParse(postalCode) == null) {
      return 'El codi postal ha de tenir exactament 5 dígits.';
    }
    return null;
  }

  // Fa la crida a l'API per obtenir informació del codi postal
  Future<PostalCodeRequestModel?> fetchPostalCodeData(String postalCode) async {
    try {
      final url = 'https://api.zippopotam.us/es/$postalCode';
      final resposta = await http.get(Uri.parse(url));

      if (resposta.statusCode == 200) {
        return PostalCodeRequestModel.fromJson(jsonDecode(resposta.body));
      } else {
        return null; // Si l'API retorna un error, es gestiona com a "no trobat"
      }
    } catch (e) {
      debugPrint('Error en la crida a l\'API: $e');
      return null;
    }
  }
}
