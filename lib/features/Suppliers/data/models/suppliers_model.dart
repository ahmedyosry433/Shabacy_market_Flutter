class SuppliersModel {
  final String id;
  final String name;
  final String mobile;
  final int credit;
  final int deposits;
  final int debit;

  final String delegate;

  SuppliersModel(
    this.id,
    this.name,
    this.mobile,
    this.credit,
    this.deposits,
    this.debit,
    this.delegate,
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
      'delegate': delegate
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
