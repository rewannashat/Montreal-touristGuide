
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

