import 'package:http/http.dart' as http;
import 'package:postal_codes_app/models/postal_code_request_model.dart';

class PostalCodeWebService {
  static final PostalCodeWebService instance = PostalCodeWebService._internal();
  PostalCodeWebService._internal();

  num? postalCode;

  Future<PostalCodeRequestModel> getFromApiWithPostalCode() async {
    http.Response resposta =
        await http.get(Uri.parse('https://api.zippopotam.us/es/25240'));
    final postalCodeRequestModel = postalCodeRequestFromJson(resposta.body);
    return postalCodeRequestModel;
  }
}
