import 'package:shabacy_market/features/profile/data/models/profile_model.dart';

class SuppliersModel {
  final String id;
  final String name;
  final String mobile;
  final int credit;
  final int deposits;
  final int debit;

  // UserModel admin;

  // final int delegate;

  SuppliersModel(
    this.id,
    this.name,
    this.mobile,
    this.credit,
    this.deposits,
    this.debit,
    // this.admin,
    // this.delegate
  );

  factory SuppliersModel.fromJson(Map<String, dynamic> json) {
    return SuppliersModel(
      json['id'],
      json['name'],
      json['mobile'],
      json['credit'],
      json['deposits'],
      json['debit'],
      // json['admin'],
      // json['admin]['name']
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'credit': credit,
      'deposits': deposits,
      'debit': debit,
      // 'admin': admin.toJson(),
      // 'delegate': delegate
    };
  }
}
