import 'package:dartz/dartz.dart';
import 'package:flutter_app_completo/app/modules/search/domain/entities/result_search.dart';
import 'package:flutter_app_completo/app/modules/search/domain/errors/errors.dart';
import 'package:flutter_app_completo/app/modules/search/domain/repositories/search_repository.dart';
import 'package:flutter_app_completo/app/modules/search/domain/usecases/search_by_text.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

// Aqui mocamos a classe SearchRepository para que possamos instanciar
// uma busca.
class SearchRepositoryMock extends Mock implements SearchRepository {}

main() {
  // Instanciamos um mock de um repositório
  final repository = SearchRepositoryMock();
  final usecase = SearchByTextImpl(repository);

  test('deve retornar uma lista de ResultSearch', () async {
    // Ao chamar repository.search teremos como retorno uma lista
    // de ResultSearch
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    final result = await usecase("albertosd");
    expect(result | null, isA<List<ResultSearch>>());
  });

  test('deve retornar um exception caso o texto seja inválido', () async {
    when(repository.search(any))
        .thenAnswer((_) async => Right(<ResultSearch>[]));

    // Quando enviamos null para busca devemos receber erro de texto invpalido
    var result = await usecase(null);
    expect(result.fold(id, id), isA<InvalidTextError>());

    // Quando buscamos por string vazia também devemos receber erro.
    result = await usecase("");
    expect(result.fold(id, id), isA<InvalidTextError>());
  });
}
