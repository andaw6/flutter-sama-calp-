import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wave_odc/pages/shared_pages/transaction/widgets/transaction_list.dart';
import 'package:wave_odc/providers/data_provider.dart';
import 'package:wave_odc/utils/constants/colors.dart';

class TransactionPage extends StatefulWidget {

  const TransactionPage({super.key,});

  @override
  TransactionPageState createState() => TransactionPageState();
}

class TransactionPageState extends State<TransactionPage> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<DataProvider>(
        builder: (context, provider, child) {
          return Container(
              color: Colors.grey[50],
              child: CustomScrollView(
                  physics: const BouncingScrollPhysics(),
                  slivers: [
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  'Tous les transactions',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textSecondary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    TransactionList(
                      transactions: provider.context.transactions,
                      user: provider.context.user,
                    ),
                    const SliverPadding(
                      padding: EdgeInsets.only(bottom: 10),
                    ),
                  ]
              )
          );
        });
  }
}