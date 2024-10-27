abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {}

class SeeMoreEvent extends HomeEvent {}

class SeeLessEvent extends HomeEvent {}

class SearchEvent extends HomeEvent {
  final String query;  
  SearchEvent(this.query);
}
