// ignore_for_file: non_constant_identifier_names, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/helper/shared_preferences_helper.dart';
import '../../../Users/data/model/profile_model.dart';
import '../../data/repo/profile_repo.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ProfileRepo _ProfileRepo;
  ProfileCubit(this._ProfileRepo) : super(ProfileInitial());
  late UserModel currentUser;
  void getUserProfile() async {
    emit(ProfileLoading());
    try {
      final String token =
          await SharedPreferencesHelper.getValueForKey('token');

      final response = await _ProfileRepo.getUserProfileRepo(token: token);
      currentUser = response;
      emit(ProfileLoaded(userProfile: response));
    } catch (e) {
      emit(ProfileError(errorMsg: e.toString()));
    }
  }
}
