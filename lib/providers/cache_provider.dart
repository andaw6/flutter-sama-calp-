import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';
import 'package:wave_odc/models/bill/bill.dart';
import 'package:wave_odc/models/company/company.dart';
import 'package:wave_odc/models/notification/notification.dart';
import 'package:wave_odc/models/transaction/transaction.dart';
import 'package:wave_odc/models/users/user.dart';
import 'package:wave_odc/models/contact/contact.dart';

class CacheProvider {
  final String _userKey = 'current_user';
  late final Box<User> _userBox;
  late final Box<Transaction> _transactionBox;
  late final Box<Bill> _billBox;
  late final Box<Contact> _contactBox;
  late final Box<Company> _companyBox;
  late final Box<Notification> _notificationBox;
  final logger = Logger();

  CacheProvider() {
    _initBoxes();
  }

  Future<void> _initBoxes() async {
    try {
      _userBox = await _openBox<User>('userBox');
      _transactionBox = await _openBox<Transaction>('transactionBox');
      _billBox = await _openBox<Bill>('billBox');
      _contactBox = await _openBox<Contact>('contactBox');
      _companyBox = await _openBox<Company>('companyBox');
      _notificationBox = await _openBox<Notification>('notificationBox');
    } catch (e) {
      logger.e("Error initializing Hive boxes: $e");
    }
  }

  Future<Box<T>> _openBox<T>(String boxName) async {
    try {
      return await Hive.openBox<T>(boxName);
    } catch (e) {
      throw Exception("Failed to open box $boxName: $e");
    }
  }

  // Save single item
  Future<void> _saveItem<T>(Box<T> box, dynamic key, T item) async {
    try {
      await box.put(key, item);
    } catch (e) {
      logger.e("Error saving item to box: $e");
    }
  }

  // Save multiple items
  Future<void> _saveItems<T>(
      Box<T> box, List<T> items, dynamic Function(T) keyExtractor) async {
    try {
      for (var item in items) {
        await _saveItem(box, keyExtractor(item), item);
      }
    } catch (e) {
      logger.e("Error saving items to box: $e");
    }
  }

  // Delete single item by ID
  Future<void> _deleteItem<T>(Box<T> box, dynamic key) async {
    try {
      await box.delete(key);
    } catch (e) {
      logger.e("Error deleting item from box: $e");
    }
  }

  // Delete all items
  Future<void> _deleteAll<T>(Box<T> box) async {
    try {
      await box.clear();
    } catch (e) {
      logger.e("Error clearing box: $e");
    }
  }

  // Search for an item by ID
  T? _findById<T>(Box<T> box, dynamic key) {
    try {
      return box.get(key);
    } catch (e) {
      logger.e("Error retrieving item by ID: $e");
      return null;
    }
  }

  Future<void> saveUser(User user) async {
    try {
      await _userBox.put(_userKey, user); // Utilisation de la clé fixe
      logger.i("User saved successfully");
    } catch (e) {
      logger.e("Error saving user: $e");
    }
  }

  User? getUser() {
    try {
      return _userBox.get(_userKey); // Récupération par la clé fixe
    } catch (e) {
      logger.e("Error retrieving user: $e");
      return null;
    }
  }

  Future<void> deleteUser() async {
    try {
      await _userBox.delete(_userKey); // Suppression par la clé fixe
      logger.i("User deleted successfully");
    } catch (e) {
      logger.e("Error deleting user: $e");
    }
  }


  // Company-specific methods
  Future<void> saveCompany(Company company) async =>
      await _saveItem(_companyBox, company.id, company);
  Future<void> saveCompanies(List<Company> companies) async =>
      await _saveItems(_companyBox, companies, (company) => company.id);
  Company? getCompany(String companyId) => _findById(_companyBox, companyId);
  Future<void> deleteCompany(String companyId) async =>
      await _deleteItem(_companyBox, companyId);
  List<Company> getCompanies() => _companyBox.values.toList();

  // Transaction-specific methods
  Future<void> saveTransaction(Transaction transaction) async =>
      await _saveItem(_transactionBox, transaction.id, transaction);
  Future<void> saveTransactions(List<Transaction> transactions) async =>
      await _saveItems(
          _transactionBox, transactions, (transaction) => transaction.id);
  Transaction? getTransaction(String transactionId) =>
      _findById(_transactionBox, transactionId);
  Future<void> deleteTransaction(String transactionId) async =>
      await _deleteItem(_transactionBox, transactionId);
  List<Transaction> getTransactions() => _transactionBox.values.toList();

  // Bill-specific methods
  Future<void> saveBills(List<Bill> bills) async =>
      await _saveItems(_billBox, bills, (bill) => bill.id);
  Bill? getBill(String billId) => _findById(_billBox, billId);
  Future<void> deleteBill(String billId) async =>
      await _deleteItem(_billBox, billId);
  List<Bill> getBills() => _billBox.values.toList();

  // Contact-specific methods
  Future<void> saveContacts(List<Contact> contacts) async =>
      await _saveItems(_contactBox, contacts, (contact) => contact.id);
  Contact? getContact(String contactId) => _findById(_contactBox, contactId);
  Future<void> deleteContact(String contactId) async =>
      await _deleteItem(_contactBox, contactId);
  List<Contact> getContacts() => _contactBox.values.toList();

  // Contact-specific methods
  Future<void> saveNotifications(List<Notification> notifications) async =>
      await _saveItems(
          _notificationBox, notifications, (notification) => notification.id);
  Notification? getNotification(String notificationId) =>
      _findById(_notificationBox, notificationId);
  Future<void> deleteNotification(String notificationId) async =>
      await _deleteItem(_notificationBox, notificationId);
  List<Notification> getNotifications() => _notificationBox.values.toList();

  // Clear all data in a specific box
  Future<void> clearUsers() async => await _deleteAll(_userBox);
  Future<void> clearTransactions() async => await _deleteAll(_transactionBox);
  Future<void> clearBills() async => await _deleteAll(_billBox);
  Future<void> clearContacts() async => await _deleteAll(_contactBox);
  Future<void> clearCompanies() async => await _deleteAll(_companyBox);
  Future<void> clearNotifications() async => await _deleteAll(_notificationBox);

  void clear() async {
    await clearContacts();
    await clearNotifications();
    await clearTransactions();
    await clearUsers();
    await clearBills();
  }
}
