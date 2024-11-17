import 'package:wave_odc/enums/transaction/transaction_type.dart';
import 'package:wave_odc/models/transaction/transaction_item.dart';
import 'package:flutter/material.dart';
import 'package:wave_odc/pages/shared_pages/transaction_details/transaction_details.dart';
import 'package:wave_odc/utils/constants/colors.dart';
import 'package:wave_odc/utils/other/functions.dart';

class TransactionItemWidget extends StatelessWidget {
  final TransactionItem transaction;

  final List<Map<TransactionType, IconData>> icons = [
      {TransactionType.deposit: Icons.account_balance_wallet},
    {TransactionType.withdraw: Icons.money_off},
    {TransactionType.purchase: Icons.shopping_cart},
    {TransactionType.send: Icons.arrow_upward},
    {TransactionType.receive: Icons.arrow_downward},
    {TransactionType.transfer: Icons.swap_horiz},
  ];

  TransactionItemWidget({
    super.key,
    required this.transaction
  });

  IconData _getIconTransaction(TransactionType type) {
    final iconEntry = icons.firstWhere(
          (map) => map.containsKey(type),
      orElse: () => {type: Icons.help},
    );
    return iconEntry[type]!;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Naviguer vers la page de détails de la transaction
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetails(transaction: transaction),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.cardBackground,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(16),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: transaction.amount > 0 ? AppColors.success : AppColors.error,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(_getIconTransaction(transaction.type), color: AppColors.textPrimary),
          ),
          title: Text(
            formatTransactionName(transaction),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.textSecondary,
            ),
          ),
          subtitle: Text(
            formatDate(transaction.createdAt),
            style: TextStyle(
              color: AppColors.textSecondary.withOpacity(0.6),
            ),
          ),
          trailing: Text(
            '${transaction.amount > 0 ? '+' : ''}${transaction.amount} ${transaction.currency}',
            style: TextStyle(
              color: transaction.amount > 0 ? AppColors.success : AppColors.error,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
