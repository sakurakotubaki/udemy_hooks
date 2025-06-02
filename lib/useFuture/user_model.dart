class UserModel {
  final int id;
  final String name;

  UserModel({required this.name, required this.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(id: json['id'] as int, name: json['name'] as String);
  }
}
