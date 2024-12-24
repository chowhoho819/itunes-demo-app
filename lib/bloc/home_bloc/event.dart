part of 'bloc.dart';

sealed class HomeEvent extends Equatable {
  const HomeEvent();
}

class HomeInitialEvent extends HomeEvent {
  const HomeInitialEvent();

  @override
  List<Object?> get props => [];
}

class HomeFetchEvent extends HomeEvent {
  final int? limit;
  final String? path;
  const HomeFetchEvent({this.path, this.limit});

  @override
  List<Object?> get props => [];
}

class HomeSearchEvent extends HomeEvent {
  final String searchText;

  const HomeSearchEvent({required this.searchText});

  @override
  List<Object?> get props => [];
}
