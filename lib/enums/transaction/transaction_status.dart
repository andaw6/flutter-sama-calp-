import 'package:hive_flutter/hive_flutter.dart';

part 'transaction_status.g.dart';

@HiveType(typeId: 2)
enum TransactionStatus{
  @HiveField(0)
  completed,

  @HiveField(1)
  pending,

  @HiveField(2)
  failed,

  @HiveField(3)
  cancelled,
}

extension TransactionStatusExtension on TransactionStatus{
  String get name {
    switch (this) {
      case TransactionStatus.completed:
        return 'COMPLETED';
      case TransactionStatus.pending:
        return 'PENDING';
      case TransactionStatus.cancelled:
        return 'CANCELLED';
      case TransactionStatus.failed:
        return 'FAILED';
    }
  }

  // Méthode pour transformer un String en enum TransactionStatus
  static TransactionStatus fromString(String status) {
    switch (status.toUpperCase()) {
      case 'COMPLETED':
        return TransactionStatus.completed;
      case 'PENDING':
        return TransactionStatus.pending;
      case 'CANCELLED':
        return TransactionStatus.cancelled;
      case 'FAILED':
        return TransactionStatus.failed;
      default:
        throw ArgumentError('Invalid TransactionStatus value: $status');
    }
  }
}