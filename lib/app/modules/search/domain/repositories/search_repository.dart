import 'package:dartz/dartz.dart';
import 'package:flutter_app_completo/app/modules/search/domain/entities/result_search.dart';
import 'package:flutter_app_completo/app/modules/search/domain/errors/errors.dart';

abstract class SearchRepository {
  Future<Either<FailureSearch, List<ResultSearch>>> search(String searchText);
}
