import 'package:wave_odc/models/bill/bill.dart';
import 'package:wave_odc/models/company/company.dart';
import 'package:wave_odc/models/contact/contact.dart';
import 'package:wave_odc/models/notification/notification.dart';
import 'package:wave_odc/models/transaction/transaction.dart';
import 'package:wave_odc/models/users/user.dart';

class Context {
  User user;
  List<Transaction> transactions;
  List<Bill> bills;
  List<Company> companies;
  List<Contact> contacts;
  List<Notification> notifications;

  Context({
    required this.user,
    this.transactions = const [],
    this.bills = const [],
    this.companies = const [],
    this.contacts = const [],
    this.notifications = const [],
  });
}
