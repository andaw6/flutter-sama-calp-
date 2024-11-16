import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_odc/models/transaction/transaction.dart';
import 'package:wave_odc/pages/client/home/widgets/action_button_widget.dart';
import 'package:wave_odc/pages/client/home/widgets/balance_card_widget.dart';
import 'package:wave_odc/pages/client/layouts/layout.dart';
import 'package:wave_odc/pages/shared_pages/transaction/widgets/transaction_list.dart';
import 'package:wave_odc/providers/data_provider.dart';
import 'package:wave_odc/utils/constants/colors.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<Home> {
  bool isBalanceVisible = false;

  final List<Map<String, dynamic>> actions = [
    {
      'icon': Icons.send,
      'color': AppColors.secondaryColor,
      'label': "Transfert",
      'page': const Scaffold(),
    },
    {
      'icon': Icons.receipt_long,
      'color': AppColors.secondaryColor,
      'label': "Paiement",
      'page': const Scaffold(),
    },
    {
      'icon': Icons.account_balance_wallet,
      'color': AppColors.secondaryColor,
      'label': "Crédit",
      'page': const Scaffold(),
    },
    {
      'icon': Icons.qr_code,
      'color': AppColors.secondaryColor,
      'label': "Scanner",
      'page': const Scaffold(),
    },
  ];

  void _navigateTo(Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => page,
      ),
    );
  }

  List<Transaction> _getRecentTransactions(List<Transaction> transactions) {
    transactions.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    return transactions.take(5).toList();
  }

  @override
  Widget build(BuildContext context) {
    return ClientLayout(
      body: Consumer<DataProvider>(
        builder: (context, provider, child) {
          return Container(
            color: Colors.grey[50],
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                // En-tête avec padding
                SliverPadding(
                  padding: const EdgeInsets.only(bottom: 16),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const SizedBox(height: 16),
                          // Carte de solde
                          BalanceCard(
                            isBalanceVisible: isBalanceVisible,
                            currency: provider.context.user.account.currency,
                            amount: provider.context.user.account.balance,
                            qrCode: provider.context.user.id,
                            onToggleVisibility: () {
                              setState(() {
                                isBalanceVisible = !isBalanceVisible;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: actions.map((action) {
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 4),
                              child: ActionButton(
                                icon: action['icon'] as IconData,
                                color: action['color'] as Color,
                                label: action['label'] as String,
                                onPressed: () => _navigateTo(action['page']),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.all(16),
                  sliver: SliverToBoxAdapter(
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Text(
                              'Transactions Récentes',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: TextButton(
                              onPressed: () {},
                              style: TextButton.styleFrom(
                                foregroundColor: AppColors.primaryLight,
                              ),
                              child: const Text(
                                'Voir tout',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                TransactionList(
                  transactions: _getRecentTransactions(provider.context.transactions),
                  user: provider.context.user,
                ),
                const SliverPadding(
                  padding: EdgeInsets.only(bottom: 10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}