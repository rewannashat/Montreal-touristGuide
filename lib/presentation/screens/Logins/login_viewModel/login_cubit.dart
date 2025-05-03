import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'login_states.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  static LoginCubit get(context) => BlocProvider.of<LoginCubit>(context);

  int currentPage = 0;

  void changePage(int index) {
    currentPage = index;
    emit(OnboardingPageChanged());
  }

  void nextPage(int totalPages) {
    if (currentPage < totalPages - 1) {
      currentPage++;
      emit(OnboardingPageChanged());
    } else {
      emit(OnboardingCompleted());
    }
  }

  void skip() {
    emit(OnboardingSkipped());
  }
}
