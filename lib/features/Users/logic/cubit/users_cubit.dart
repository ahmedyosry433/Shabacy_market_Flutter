import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shabacy_market/features/Users/data/repo/users_repo.dart';

import '../../../../core/helper/shared_preferences_helper.dart';
import '../../data/model/profile_model.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepo _usersRepo;
  UsersCubit(this._usersRepo) : super(UsersInitial());

  List<UserModel> users = [];

  void getAllUsersCubit() async {
    emit(UsersLoading());

    try {
      final String token =
          await SharedPreferencesHelper.getValueForKey('token');

      List<UserModel> response = await _usersRepo.getAllUsersRepo(token: token);

      users = response;

      emit(UsersLoaded());
    } catch (error) {
      emit(UsersError(error.toString()));
    }
  }
}
