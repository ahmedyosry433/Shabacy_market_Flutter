class CategoriesModel {
  final String name;
  final String id;
  final String type;
  CategoriesModel({
    required this.name,
    required this.id,
    required this.type,
  });

  factory CategoriesModel.fromJson(Map<String, dynamic> json) {
    return CategoriesModel(
      name: json['name'],
      id: json['id'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'id': id,
      'type': type,
    };
  }
}


class AddCategoriesModel {
  final String name;
  
  AddCategoriesModel({
    required this.name,
    
  });

  factory AddCategoriesModel.fromJson(Map<String, dynamic> json) {
    return AddCategoriesModel(
      name: json['name'],
     
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
   
    };
  }
}


