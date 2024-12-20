import 'package:flutter/material.dart';
import 'package:postal_codes_app/models/postal_code_request_model.dart';
import 'package:postal_codes_app/services/postal_code_web_service.dart';

//https://jsonplaceholder.typicode.com/posts/1

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool _isLoaded = false;
  PostalCodeRequestModel? _postalCodeData;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    _postalCodeData =
        await PostalCodeWebService.instance.getFromApiWithPostalCode();
    _isLoaded = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicació de búsqueda de codis postals'),
      ),
      body: Center(
        child: _isLoaded
            ? ListView.builder(
                itemCount: _postalCodeData?.places.length ?? 0,
                itemBuilder: (context, index) {
                  final place = _postalCodeData!.places[index];
                  return ListTile(
                    title: Text(place.placeName),
                    subtitle: Text(
                        'Country: ${_postalCodeData!.country}, Postcode: ${_postalCodeData!.postCode}'),
                  );
                },
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
