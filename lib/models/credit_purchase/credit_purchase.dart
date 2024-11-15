import 'package:hive_flutter/hive_flutter.dart';

part 'credit_purchase.g.dart';


@HiveType(typeId: 9)
class CreditPurchase {

  @HiveField(0) String receiverName;

  @HiveField(1) String receiverPhoneNumber;

  @HiveField(2) String? receiverEmail;


  CreditPurchase({
    required this.receiverName,
    required this.receiverPhoneNumber,
    this.receiverEmail,
  });

  factory CreditPurchase.create(String receiverName, String receiverPhoneNumber, String? receiverEmail) {
    return CreditPurchase(
      receiverName: receiverName,
      receiverPhoneNumber: receiverPhoneNumber,
      receiverEmail: receiverEmail,
    );
  }

  // Méthode fromJson pour la désérialisation d'un JSON
  factory CreditPurchase.fromJson(Map<String, dynamic> json) {
    return CreditPurchase(
      receiverName: json['receiverName'],
      receiverPhoneNumber: json['receiverPhoneNumber'],
      receiverEmail: json['receiverEmail'],
    );
  }
}
