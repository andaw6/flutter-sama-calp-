import 'package:flutter/material.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/transaction/transaction.dart';
import 'package:wave_odc/models/transaction/transaction_item.dart';
import 'package:wave_odc/models/users/user.dart';
import 'package:wave_odc/pages/shared_pages/transaction/widgets/transaction_item.dart';
import 'package:wave_odc/services/transaction_service.dart';

class TransactionList extends StatefulWidget {
  final List<Transaction> transactions;
  final User user;

  const TransactionList(
      {super.key, required this.transactions, required this.user});

  @override
  TransactionListState createState() => TransactionListState();
}

class TransactionListState extends State<TransactionList> {
  late List<TransactionItem> transactionsItem;

  @override
  void initState() {
    super.initState();
    transactionsItem = locator<TransactionService>()
        .getTransactionsItem(widget.transactions, widget.user);
  }

  @override
  Widget build(BuildContext context) {
    return SliverList(
        delegate: SliverChildListDelegate([
      ...transactionsItem.map((e) => TransactionItemWidget(transaction: e)),
    ]));
  }
}
