import 'package:flutter/material.dart';
import 'package:wave_odc/pages/client/layouts/layout.dart';
import 'package:wave_odc/pages/shared_pages/transaction/transaction.dart';

class TransactionClient extends StatefulWidget {

  const TransactionClient({super.key,});

  @override
  TransactionClientState createState() => TransactionClientState();
}

class TransactionClientState extends State<TransactionClient> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return const ClientLayout(body: TransactionPage());
  }
}