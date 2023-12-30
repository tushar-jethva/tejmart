import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressAndAmountModel {
  final String address;
  final String mobile_no;
  final double a_balance;
  AddressAndAmountModel({
    required this.address,
    required this.mobile_no,
    required this.a_balance,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'address': address,
      'mobile_no': mobile_no,
      'a_balance': a_balance,
    };
  }

  factory AddressAndAmountModel.fromMap(Map<String, dynamic> map) {
    return AddressAndAmountModel(
        address: map['address'] as String,
        mobile_no: map['mobile_no'] as String,
        a_balance: map['a_balance'] as double);
  }

  String toJson() => json.encode(toMap());

  factory AddressAndAmountModel.fromJson(String source) =>
      AddressAndAmountModel.fromMap(
          json.decode(source) as Map<String, dynamic>);
}
