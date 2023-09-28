class UserModel {
  int? id;
  String? name;
  String? username;
  String? password;

  UserModel({
    this.id,
    this.name,
    this.username,
    this.password,
  });

  UserMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id ?? null;
    mapping['name'] = name!;
    mapping['username'] = username!;
    mapping['password'] = password!;
    return mapping;
  }
}
