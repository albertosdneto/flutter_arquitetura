import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_app_completo/app/app_module.dart';
import 'package:flutter_app_completo/app/modules/search/presenter/search/states/search_state.dart';
import 'package:flutter_app_completo/app/modules/search/search_module.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_modular/flutter_modular_test.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_app_completo/app/modules/search/presenter/search/search_controller.dart';
import 'package:mockito/mockito.dart';

import '../../utils/github_response.dart';

class DioMock extends Mock implements Dio {}

main() {
  var dio = DioMock();

  initModule(AppModule(), changeBinds: [
    Bind<Dio>((i) => dio),
  ]);

  initModule(SearchModule());

  when(dio.get(any)).thenAnswer(
      (_) async => Response(data: jsonDecode(githubResult), statusCode: 200));

  test('deve retorna um SuccessState', () async {
    // var store = Modular.get<SearchController>();
    var store = Modular.get<SearchController>();
    var result = await store.makeSearch("text");
    expect(result, isA<SuccessState>());
  });

  test('deve trocar o estado para SuccessState', () async {
    var store = Modular.get<SearchController>();
    await store.stateReaction("text");
    expect(store.state, isA<SuccessState>());
  });
}
