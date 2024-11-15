import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/models/context.dart';
import 'package:wave_odc/models/users/user.dart';
import 'package:wave_odc/providers/cache_provider.dart';
import 'package:wave_odc/services/bill_service.dart';
import 'package:wave_odc/services/company_service.dart';
import 'package:wave_odc/services/contact_service.dart';
import 'package:wave_odc/services/notification_service.dart';
import 'package:wave_odc/services/transaction_service.dart';
import 'package:wave_odc/services/user_service.dart';

class DataProvider with ChangeNotifier {
  bool isOnline = true;
  final logger = Logger();
  final CacheProvider _cache = locator<CacheProvider>();
  final UserService _userService = locator<UserService>();
  final TransactionService _transactionService = locator<TransactionService>();
  final CompanyService _companyService = locator<CompanyService>();
  final ContactService _contactService = locator<ContactService>();
  final BillService _billService = locator<BillService>();
  final NotificationService _notificationService =
      locator<NotificationService>();

  late Context context;

  DataProvider() {
    _initialize();
  }

  void _initialize() {
    Future.microtask(() async => await fetchData());
  }

  void setConnectivity(bool status) async {
    logger.i("Set status connection: initial = $isOnline, new value = $status");

    isOnline = status;
    if (status) {
      await fetchData();
    }
    notifyListeners();
  }

  Future<void> fetchData() async {
    logger.i("Fetch data: status connection: $isOnline");
    if (!isOnline) {
      try {
        final user = await _userService.current();
        final transactions = await _transactionService.getTransactions();
        final bills = await _billService.getBills();
        final companies = await _companyService.getCompanies();
        final contacts = await _contactService.getContacts();
        final notifications = await _notificationService.getNotifications();

        context = Context(
          user: user,
          transactions: transactions,
          bills: bills,
          companies: companies,
          contacts: contacts,
          notifications: notifications,
        );

        await _saveDataToCache(context);
      } catch (e) {
        logger.e("Error fetching online data: $e");
      }
    } else {
      context = await _getDataFromCache();
    }
    notifyListeners();
  }

  Future<void> _saveDataToCache(Context data) async {
    try {
      await _cache.clearTransactions();
      await _cache.clearBills();
      await _cache.clearCompanies();
      await _cache.clearContacts();
      await _cache.saveUser(data.user);
      await _cache.saveTransactions(data.transactions);
      await _cache.saveBills(data.bills);
      await _cache.saveCompanies(data.companies);
      await _cache.saveContacts(data.contacts);
      await _cache.saveNotifications(data.notifications);
    } catch (e) {
      logger.e("Error saving data to cache: $e");
    }
  }

  Future<Context> _getDataFromCache() async {
    try {
      final user = _cache.getUser() ?? User.defaultUser();
      final transactions = _cache.getTransactions();
      final bills = _cache.getBills();
      final companies = _cache.getCompanies();
      final contacts = _cache.getContacts();
      final notifications = _cache.getNotifications();

      return Context(
        user: user,
        transactions: transactions,
        bills: bills,
        companies: companies,
        contacts: contacts,
        notifications: notifications,
      );
    } catch (e) {
      logger.e("Error fetching data from cache: $e");
      return Context(user: User.defaultUser());
    }
  }
}
