class SuppliersModel {
  final String id;
  final String name;
  final String mobile;
  final int credit;
  final int deposits;
  final int debit;

  final String adminName;
  final String adminId;

  SuppliersModel(
    this.id,
    this.name,
    this.mobile,
    this.credit,
    this.deposits,
    this.debit,
    this.adminName,
    this.adminId,
  );

  factory SuppliersModel.fromJson(Map<String, dynamic> json) {
    return SuppliersModel(
      json['id'],
      json['name'],
      json['mobile'],
      json['credit'],
      json['deposits'],
      json['debit'],
      json['admin']['name'],
      json['admin']['id'],
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
      'delegate': adminName,
      'admin': adminId,
    };
  }
}

class ModifySuppliersModel {
  final String name;
  final String mobile;
  final String admin;

  ModifySuppliersModel(this.name, this.mobile, this.admin);

  factory ModifySuppliersModel.fromJson(Map<String, dynamic> json) {
    return ModifySuppliersModel(
      json['name'],
      json['mobile'],
      json['admin'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobile': mobile,
      'admin': admin,
    };
  }
}

class BalanceModel {
  final int balance;

  BalanceModel(this.balance);

  factory BalanceModel.fromJson(Map<String, dynamic> json) {
    return BalanceModel(json['name']);
  }

  Map<String, dynamic> toJson() {
    return {
      'balance': balance,
    };
  }
}
