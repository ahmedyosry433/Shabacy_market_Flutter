class DailyPurchasesRequestModel {
  String adminId;
  String category;
  String date;
  int paid;
  String period;
  int price;
  int quantity;
  String userId;
  DailyPurchasesRequestModel({
    required this.adminId,
    required this.category,
    required this.date,
    required this.paid,
    required this.period,
    required this.price,
    required this.quantity,
    required this.userId,
  });

  factory DailyPurchasesRequestModel.fromJson(Map<String, dynamic> json) {
    return DailyPurchasesRequestModel(
      adminId: json['adminId'],
      category: json['category'],
      date: json['date'],
      paid: json['paid'],
      period: json['period'],
      price: json['price'],
      quantity: json['quantity'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminId': adminId,
      'category': category,
      'date': date,
      'paid': paid,
      'period': period,
      'price': price,
      'quantity': quantity,
      'userId': userId,
    };
  }
}

class GetDailyPurchasesModel {
  String adminId;
  String category;
  String date;
  int paid;
  String period;
  int price;
  int quantity;
  int remains;
  int total;
  String supplierName;
  int totalBalance;
  GetDailyPurchasesModel({
    required this.adminId,
    required this.category,
    required this.date,
    required this.paid,
    required this.period,
    required this.price,
    required this.quantity,
    required this.remains,
    required this.total,
    required this.supplierName,
    required this.totalBalance,
  });

  factory GetDailyPurchasesModel.fromJson(Map<String, dynamic> json) {
    return GetDailyPurchasesModel(
      adminId: json['admin'],
      category: json['category'],
      date: json['date'],
      paid: json['paid'],
      period: json['period'],
      price: json['price'],
      quantity: json['quantity'],
      remains: json['remains'],
      total: json['total'],
      supplierName: json['user']['name'],
      totalBalance: json['user']['deposits'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminId': adminId,
      'category': category,
      'date': date,
      'paid': paid,
      'period': period,
      'price': price,
      'quantity': quantity,
      'remains': remains,
      'total': total,
      'name': supplierName,
      'totalBalance': totalBalance,
    };
  }
}
