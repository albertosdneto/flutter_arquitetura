import 'package:dartz/dartz.dart';
import 'package:flutter_app_completo/app/modules/search/domain/entities/result_search.dart';
import 'package:flutter_app_completo/app/modules/search/domain/errors/errors.dart';
import 'package:flutter_app_completo/app/modules/search/domain/repositories/search_repository.dart';
import 'package:flutter_app_completo/app/modules/search/infra/datasources/search_datasource.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'search_repository_impl.g.dart';

@Injectable(singleton: false)
class SearchRepositoryImpl implements SearchRepository {
  final SearchDatasource datasource;

  SearchRepositoryImpl(this.datasource);

  @override
  Future<Either<FailureSearch, List<ResultSearch>>> search(
      String searchText) async {
    try {
      final result = await datasource.getSearch(searchText);
      return Right(result);
    } on DatasourceError catch (e) {
      return Left(e);
    } catch (e) {
      return Left(DatasourceError());
    }
  }
}
