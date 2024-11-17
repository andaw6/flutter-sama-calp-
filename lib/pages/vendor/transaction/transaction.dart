import 'package:flutter/material.dart';
import 'package:wave_odc/pages/shared_pages/transaction/transaction.dart';
import 'package:wave_odc/pages/vendor/layouts/layout.dart';

class TransactionVendor extends StatefulWidget {

  const TransactionVendor({super.key,});

  @override
  TransactionVendorState   createState() => TransactionVendorState();
}

class TransactionVendorState extends State<TransactionVendor> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return const VendorLayout(body: TransactionPage());
  }
}