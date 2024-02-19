// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shabacy_market/features/DailyPurchases/data/repo/daily_purchases_repo.dart';

part 'daily_purchases_state.dart';

class DailyPurchasesCubit extends Cubit<DailyPurchasesState> {
  DailyPurchasesCubit(this.dailyPurchasesRepo) : super(DailyPurchasesInitial());
  DailyPurchasesRepo dailyPurchasesRepo;
}
