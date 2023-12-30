import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserModel {
  final String id;
  final String name;
  final String email;
  final String password;
  final String mobile_no;
  final String address;
  final double a_balance;
  final String token;

  final String imageUrl;
  UserModel(
      {required this.id,
      required this.name,
      required this.email,
      required this.password,
      required this.mobile_no,
      required this.address,
      required this.a_balance,
      required this.token,
      required this.imageUrl});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'mobile_no': mobile_no,
      'address': address,
      'a_balance': a_balance,
      'token': token,
      'imageUrl': imageUrl
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    String a = map['a_balance'].toString();
    double ab = double.parse(a);
    return UserModel(
      id: map['_id'],
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      mobile_no: map['mobile_no'] as String,
      address: map['address'] as String,
      token: map['token'] as String,
      imageUrl: map['imageUrl'] ?? "",
      a_balance: ab,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
