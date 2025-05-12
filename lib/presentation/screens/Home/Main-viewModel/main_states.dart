
abstract class MainState {}

class MainInitial extends MainState {}

/// selected
class MainCategoryChanged extends MainState {}

///Get Data
class MainLoading extends MainState {}
class MainSuccess extends MainState {}
class MainError extends MainState {
  String error ;

  MainError(this.error);
}

/// Map

class MapLoading extends MainState {}
class MapSuccess extends MainState {}
class MapError extends MainState {
  String error ;

  MapError(this.error);
}

/// Search
class MainSearchUpdated extends MainState {}
