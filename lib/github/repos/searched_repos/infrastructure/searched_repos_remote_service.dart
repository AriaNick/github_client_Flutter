import 'package:repo_viewer/core/infrastructure/remote_response.dart';
import 'package:repo_viewer/github/core/infrastructure/github_repo_dto.dart';
import 'package:repo_viewer/github/core/infrastructure/pagination_config.dart';
import 'package:repo_viewer/github/repos/core/infrastructure/repos_remote_service.dart';

class SearchedReposRemoteService extends ReposRemoteService {
  SearchedReposRemoteService(
    super.dio,
    super.headersCache,
  );

  Future<RemoteResponse<List<GithubRepoDTO>>> getSearchedReposPage(
    String query,
    int page,
  ) async =>
      super.getPage(
        requestUri: Uri.https(
          'api.github.com',
          '/search/repositories',
          {
            'q': query,
            'page': '$page',
            'per_page': PaginationConfig.itemsPerPage.toString(),
          },
        ),
        jsonDataSelector: (json) => json['items'] as List<dynamic>,
        // if our request be type of starred request then our respond from Github should be [{starredItems}]
        // but in search case our respond is ['...','items':{searchedItems}]
      );
}

//Explained in Lesson 145 or 146
