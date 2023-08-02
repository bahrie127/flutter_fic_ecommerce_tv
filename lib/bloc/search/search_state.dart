part of 'search_bloc.dart';

@freezed
class SearchState with _$SearchState {
  const factory SearchState.initial() = _Initial;
  const factory SearchState.loading() = _Loading;
  const factory SearchState.loaded(ListProductResponseModel data) = _Loaded;
  const factory SearchState.error() = _Error;
}
