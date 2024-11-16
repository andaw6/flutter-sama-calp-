import 'package:logger/logger.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/enums/transaction/transaction_type.dart';
import 'package:wave_odc/models/api_reponse.dart';
import 'package:wave_odc/models/transaction/transaction.dart';
import 'package:wave_odc/models/transaction/transaction_item.dart';
import 'package:wave_odc/models/users/user.dart';
import 'package:wave_odc/models/users/user_info.dart';
import 'package:wave_odc/services/provider/interfaces/IApiService.dart';

class TransactionService {
  final logger = Logger();
  final IApiService _apiService;

  TransactionService()
      : _apiService = locator<IApiService>(param1: "/transactions");

  TransactionItem mapToTransactionItem(Transaction transaction, bool isSender) {
    TransactionType transactionType = (transaction.type.toString() ==
            TransactionType.transfer.toString())
        ? (isSender ? TransactionType.send : TransactionType.receive)
        : transaction.type;

    double amount = transaction.amount;
    if (transactionType == TransactionType.withdraw ||
        transactionType == TransactionType.send ||
        transactionType == TransactionType.purchase) {
      amount = -amount;
    }
    final baseTransaction = TransactionItem(
      id: transaction.id,
      amount: amount,
      feeAmount: transaction.feeAmount,
      currency: transaction.currency,
      type: transactionType,
      status: transaction.status,
      createdAt: transaction.createdAt,
      user: transaction.creditPurchase != null
          ? UserInfo(
              id: transaction.id,
              name: transaction.creditPurchase!.receiverName,
              email: transaction.creditPurchase!.receiverEmail,
              phoneNumber: transaction.creditPurchase!.receiverPhoneNumber,
              isActive: true,
              role: transaction.sender?.role ?? '',
            )
          : (isSender ? transaction.receiver : transaction.sender),
    );

    return baseTransaction;
  }

  List<TransactionItem> getTransactionsItem(
      List<Transaction> transactions, User user) {
    return transactions
        .map((transaction) =>
            mapToTransactionItem(transaction, transaction.sender!.id == user.id))
        .toList();
  }

  Future<List<Transaction>> getTransactions() async {
    final ApiResponse<Map<String, dynamic>> response = await _apiService
        .get("/current", fromJsonT: (json) => json as Map<String, dynamic>);
    if (response.success) {
      return response.dataList!.map((e) => Transaction.fromJson(e)).toList();
    } else {
      throw Exception("Erreur lors de la récupération de l'utilisateur");
    }
  }

  Future<Transaction?> _performTransaction(
      {required String endpoint, required Map<String, dynamic> data}) async {
    final ApiResponse<Map<String, dynamic>> response = await _apiService.post(
      endpoint,
      data,
      fromJsonT: (json) => json as Map<String, dynamic>,
    );

    if (response.success) {
      return Transaction.fromJson(response.data!);
    }
    return null;
  }

  Future<Transaction?> transfert(
      {required String phone, required int amount, double feeAmount = 0}) {
    return _performTransaction(
      endpoint: "/transfer",
      data: {"phone": phone, "amount": amount, "feeAmount": feeAmount},
    );
  }

  Future<Transaction?> retrait(
      {required String phone, required int amount, double feeAmount = 0}) {
    return _performTransaction(
      endpoint: "/withdraw",
      data: {"phone": phone, "amount": amount, "feeAmount": feeAmount},
    );
  }

  Future<Transaction?> depot(
      {required String phone, required int amount, double feeAmount = 0}) {
    return _performTransaction(
      endpoint: "/deposit",
      data: {"phone": phone, "amount": amount, "feeAmount": feeAmount},
    );
  }

  Future<Transaction?> credit(
      {required String phone,
      required int amount,
      required String name,
      double feeAmount = 0}) {
    return _performTransaction(
      endpoint: "/purchase",
      data: {
        "phone": phone,
        "amount": amount,
        "name": name,
        "feeAmount": feeAmount
      },
    );
  }
}
