import 'package:dio/dio.dart';
import 'package:flutter_app_completo/app/modules/search/domain/errors/errors.dart';
import 'package:flutter_app_completo/app/modules/search/infra/datasources/search_datasource.dart';
import 'package:flutter_app_completo/app/modules/search/infra/models/result_search_model.dart';
import 'package:flutter_modular/flutter_modular.dart';

part 'github_datasource.g.dart';

@Injectable(singleton: false)
class GithubDatasource implements SearchDatasource {
  final Dio dio;

  GithubDatasource(this.dio);

  @override
  Future<List<ResultSearchModel>> getSearch(String searchText) async {
    final response = await dio.get(
        "https://api.github.com/search/users?q=${searchText.trim().replaceAll(' ', '+')}");
    if (response.statusCode == 200) {
      final list = (response.data['items'] as List)
          .map((e) => ResultSearchModel.fromMap(e))
          .toList();

      return list;
    } else {
      throw DatasourceError();
    }
  }
}
