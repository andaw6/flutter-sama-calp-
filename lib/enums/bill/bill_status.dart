import 'package:hive_flutter/hive_flutter.dart';


part 'bill_status.g.dart';

@HiveType(typeId: 0)
enum BillStatus {
  @HiveField(0)
  pending,

  @HiveField(1)
  paid,
  
  @HiveField(2)
  overdue,
}

extension BillStatusExtension on BillStatus {
  String get name {
    switch (this) {
      case BillStatus.pending:
        return 'PENDING';
      case BillStatus.paid:
        return 'PAID';
      case BillStatus.overdue:
        return 'OVERDUE';
    }
  }

  static BillStatus fromString(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return BillStatus.pending;
      case 'PAID':
        return BillStatus.paid;
      case 'OVERDUE':
        return BillStatus.overdue;
      default:
        throw ArgumentError('Invalid BillStatus value: $status');
    }
  }
}

