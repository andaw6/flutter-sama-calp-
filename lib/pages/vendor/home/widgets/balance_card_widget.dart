import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wave_odc/shared/widgets/action_button_widget.dart';
import 'package:wave_odc/shared/widgets/qr_code_dialog.dart';
import 'package:wave_odc/utils/constants/colors.dart'; // Importer AppColors

class BalanceCard extends StatelessWidget {
  final bool isBalanceVisible;
  final VoidCallback onToggleVisibility;
  final double amount;
  final String currency;
  final String qrCode;

  const BalanceCard({
    super.key,
    required this.isBalanceVisible,
    required this.onToggleVisibility,
    required this.amount,
    required this.qrCode,
    this.currency = "XOF",
  });

  void _showQRCode(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => QRCodeDialog(
        data: qrCode,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat("#,##0.00", "fr_FR");

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryLight,
            AppColors.primaryDark,
          ],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryLight.withOpacity(0.3),
            offset: const Offset(0, 8),
            blurRadius: 24,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                isBalanceVisible
                    ? '${numberFormat.format(amount)} $currency'
                    : '• • • • • •',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.5,
                ),
              ),
              IconButton(
                icon: Icon(
                  isBalanceVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white.withOpacity(0.9),
                  size: 22,
                ),
                onPressed: onToggleVisibility,
              ),
            ],
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: ActionButtonWidget(
                  icon: Icons.account_balance_wallet,
                  label: 'Depot',
                  onTap: () => _showQRCode(context),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ActionButtonWidget(
                  icon: Icons.money_off,
                  label: 'Retrait',
                  onTap: () => _showQRCode(context),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
