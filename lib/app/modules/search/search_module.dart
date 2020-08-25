import 'presenter/search/search_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter_app_completo/app/modules/search/domain/usecases/search_by_text.dart';
import 'package:flutter_app_completo/app/modules/search/external/datasources/github_datasource.dart';
import 'package:flutter_app_completo/app/modules/search/infra/repositories/search_repository_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'presenter/search/search_page.dart';

class SearchModule extends ChildModule {
  @override
  List<Bind> get binds => [
        $SearchController,
        Bind((i) => Dio()),
        $GithubDatasource,
        $SearchRepositoryImpl,
        $SearchByTextImpl,
      ];

  @override
  List<ModularRouter> get routers => [
        ModularRouter(Modular.initialRoute, child: (_, __) => SearchPage()),
      ];

  static Inject get to => Inject<SearchModule>.of();
}
