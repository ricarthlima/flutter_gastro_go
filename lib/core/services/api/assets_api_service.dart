import 'dart:convert';
import 'dart:math';

import 'package:flutter/services.dart';
import 'package:flutter_gastro_go/core/exceptions/fail_fetch_data_exception.dart';
import 'package:flutter_gastro_go/core/services/api/i_api_service.dart';

class AssetsApiService implements IApiService {
  @override
  Future<Map<String, dynamic>> fetchData(String url) async {
    // Simulador de falha de conexão
    // Literalmente rolar um 1 natural kkkk
    if (Random().nextInt(20) == 1) {
      throw FailFetchDataException(
        message: 'Não foi possível recuperar os dados',
      );
    }
    return json.decode(await rootBundle.loadString(url));
  }
}
