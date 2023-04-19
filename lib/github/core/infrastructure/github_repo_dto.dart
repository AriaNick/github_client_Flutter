import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:repo_viewer/github/core/infrastructure/user_dto.dart';

import '../domain/github_repo.dart';

part 'github_repo_dto.freezed.dart';
part 'github_repo_dto.g.dart';

String _descriptionFromJson(Object? json) {
  return (json as String?) ?? '';
  // some repositories has no description and the description fields is null in this situation
  // if the description field is null when converting json object to dart object in the dart object
  // the description field would be an empty String like : ''
}

@freezed
class GithubRepoDTO with _$GithubRepoDTO {
  const GithubRepoDTO._();
  const factory GithubRepoDTO({
    required UserDTO owner,
    required String name,
    @JsonKey(fromJson: _descriptionFromJson/*has no paranthesis because we don't want to call this method*/) required String description,
    @JsonKey(name: 'stargazers_count') required int stargazersCount, // JsonKey use because in json response the stargazersCount is equal to stargazers_count
  }) = _GithubRepoDTO;

  factory GithubRepoDTO.fromJson(Map<String, dynamic> json) => _$GithubRepoDTOFromJson(json);

  factory GithubRepoDTO.fromDomain(GithubRepo _) {
    return GithubRepoDTO(
      owner: UserDTO.fromDomain(_.owner),
      name: _.name,
      description: _.description,
      stargazersCount: _.stargazersCount,
    );
  }

  GithubRepo toDomain() {
    return GithubRepo(
      owner: owner.toDomain(),
      name: name,
      description: description,
      stargazersCount: stargazersCount,
    );
  }
}
