
import 'package:hive_flutter/hive_flutter.dart';
import 'package:wave_odc/enums/bill/bill_status.dart';
import 'package:wave_odc/enums/notification/notification_status.dart';
import 'package:wave_odc/enums/transaction/transaction_status.dart';
import 'package:wave_odc/enums/transaction/transaction_type.dart';
import 'package:wave_odc/enums/user/user_role.dart';
import 'package:wave_odc/models/account/account.dart';
import 'package:wave_odc/models/bill/bill.dart';
import 'package:wave_odc/models/company/company.dart';
import 'package:wave_odc/models/contact/contact.dart';
import 'package:wave_odc/models/credit_purchase/credit_purchase.dart';
import 'package:wave_odc/models/notification/notification.dart';
import 'package:wave_odc/models/transaction/transaction.dart';
import 'package:wave_odc/models/transaction/transaction_base.dart';
import 'package:wave_odc/models/transaction/transaction_item.dart';
import 'package:wave_odc/models/users/user.dart';
import 'package:wave_odc/models/users/user_info.dart';

Future<void> hiveConfig() async {
  await Hive.initFlutter();
  Hive.registerAdapter(BillStatusAdapter());
  Hive.registerAdapter(NotificationStatusAdapter());
  Hive.registerAdapter(TransactionStatusAdapter());
  Hive.registerAdapter(TransactionTypeAdapter());
  Hive.registerAdapter(UserRoleAdapter());
  Hive.registerAdapter(AccountAdapter());
  Hive.registerAdapter(BillAdapter());
  Hive.registerAdapter(CompanyAdapter());
  Hive.registerAdapter(ContactAdapter());
  Hive.registerAdapter(CreditPurchaseAdapter());
  Hive.registerAdapter(NotificationAdapter());
  Hive.registerAdapter(TransactionBaseAdapter());
  Hive.registerAdapter(TransactionItemAdapter());
  Hive.registerAdapter(TransactionAdapter());
  Hive.registerAdapter(UserInfoAdapter());
  Hive.registerAdapter(UserAdapter());
}
