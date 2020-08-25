import 'package:dartz/dartz.dart';
import 'package:flutter_app_completo/app/modules/search/domain/entities/result_search.dart';
import 'package:flutter_app_completo/app/modules/search/domain/errors/errors.dart';
import 'package:flutter_app_completo/app/modules/search/domain/repositories/search_repository.dart';
import 'package:flutter_modular/flutter_modular.dart';

//Adicione esta linha
part 'search_by_text.g.dart';

abstract class SearchByText {
  Future<Either<FailureSearch, List<ResultSearch>>> call(String searchText);
}

//Adicione esta linha
@Injectable(singleton: false)
class SearchByTextImpl implements SearchByText {
  final SearchRepository repository;

  SearchByTextImpl(this.repository);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> call(
      String searchText) async {
    // Retornamos erro caso o texto buscado seja inválido
    if (searchText == null || searchText.isEmpty) {
      return Left(InvalidTextError());
    }

    return repository.search(searchText);
  }
}
