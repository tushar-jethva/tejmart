import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class SalesExecutive {
  final String id;
  final String name;
  final String email;
  final String password;
  final String shop_name;
  final String mobile_no;

  SalesExecutive({
    required this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.shop_name,
    required this.mobile_no,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id':id,
      'name': name,
      'email': email,
      'password': password,
      'shop_name': shop_name,
      'mobile_no': mobile_no,
    };
  }

  factory SalesExecutive.fromMap(Map<String, dynamic> map) {
    return SalesExecutive(
      id:map['_id'],
      name: map['name'] as String,
      email: map['email'] as String,
      password: map['password'] as String,
      shop_name: map['shop_name'] as String,
      mobile_no: map['mobile_no'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesExecutive.fromJson(String source) =>
      SalesExecutive.fromMap(json.decode(source) as Map<String, dynamic>);
}
