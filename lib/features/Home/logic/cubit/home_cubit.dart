// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/shared_preferences_helper.dart';
import '../../../Users/data/model/user_model.dart';
import '../../data/repo/home_repo.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo _homeRepo;
  HomeCubit(this._homeRepo) : super(HomeInitial());
  UserModel? currentUser;
  void getCurrentUser() async {
    emit(HomeLoading());
    try {
      final String token =
          await SharedPreferencesHelper.getValueForKey('token');

      final response = await _homeRepo.getCurrentUserRepo(token: token);
      currentUser = response;

      emit(HomeLoaded(response));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}
