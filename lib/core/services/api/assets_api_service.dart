import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import '../../exceptions/fail_fetch_data_exception.dart';
import 'i_api_service.dart';

class AssetsApiService implements IApiService {
  @override
  Future<Map<String, dynamic>> fetchData(String url) async {
    // Simulador de falha de conexão
    // Literalmente rolar um 1 natural kkkk
    if (Random().nextInt(20) == 1) {
      throw FailFetchDataException(
        message:
            'Não foi possível recuperar os dados, você rolou um 1 natural.',
      );
    }

    // Simulador de espera da rede
    await Future.delayed(Duration(seconds: Random().nextInt(5)));

    return json.decode(await rootBundle.loadString(url));
  }
}
