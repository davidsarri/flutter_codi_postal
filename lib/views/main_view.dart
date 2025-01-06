import 'package:flutter/material.dart';
import 'package:postal_codes_app/controllers/input_text_controller.dart';
import 'package:postal_codes_app/models/postal_code_request_model.dart';

final InputTextController _inputController = InputTextController();

class MainView extends StatefulWidget {
  const MainView({super.key});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  bool _isLoaded = false;
  bool _isLoading = false;
  PostalCodeRequestModel? _postalCodeData;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _inputController.textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    _inputController.textController.removeListener(_onTextChanged);
    _inputController.textController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    final postalCode = _inputController.textController.text;

    if (postalCode.length == 5 && int.tryParse(postalCode) != null) {
      _fetchPostalCodeData(postalCode);
    }
  }

  Future<void> _fetchPostalCodeData(String postalCode) async {
    setState(() {
      _isLoading = true;
      _isLoaded = false;
      _errorMessage = null;
    });

    final result = await _inputController.fetchPostalCodeData(postalCode);
    setState(() {
      _isLoading = false;
      if (result != null) {
        _postalCodeData = result;
        _isLoaded = true;
      } else {
        _postalCodeData = null;
        _isLoaded = true;
        _errorMessage = "No s'ha trobat informacio del codi postal";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aplicació de búsqueda de codis postals'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _inputController.textController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Introdueix el codi postal',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            // Error
            if (_errorMessage != null)
              Text(
                _errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            Expanded(
              child: _isLoading
                  ? Center(
                      child:
                          CircularProgressIndicator()) // Mostra el loader si està carregant
                  : _isLoaded
                      ? (_postalCodeData != null
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
                          : Center(
                              child:
                                  Text('EL codi postal introduit no es válid'),
                            ))
                      : Center(
                          child: Text(
                            'Introdueix un codi postal per començar',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
            ),
          ],
        ),
      ),
    );
  }
}
