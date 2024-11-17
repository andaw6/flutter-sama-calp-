import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:wave_odc/enums/transaction/transaction_type.dart';
import 'package:wave_odc/models/transaction/transaction_item.dart';

double convertToDouble(dynamic value) {
  if (value is double) {
    return value;
  } else if (value is int) {
    return value.toDouble();
  } else if (value is String) {
    return double.tryParse(value) ??
        0.0; // retourne 0.0 si la conversion échoue
  } else {
    throw ArgumentError(
        "La valeur fournie n'est pas un nombre valide : $value");
  }
}



String formatDate(DateTime date) {
  return DateFormat('yyyy-MM-dd').format(date);
}


String formatTransactionName(TransactionItem trans) {
  if (trans.user == null && [
    TransactionType.receive,
    TransactionType.send,
    TransactionType.purchase,
    TransactionType.transfer,
  ].contains(trans.type)) {
    return "Informations utilisateur manquantes";
  }

  switch (trans.type) {
    case TransactionType.receive:
      return "De ${trans.user!.name} (${trans.user!.phoneNumber})";
    case TransactionType.deposit:
      return "Dépôt";
    case TransactionType.send:
      return "À ${trans.user!.name} (${trans.user!.phoneNumber})";
    case TransactionType.purchase:
      return "Achat de crédit pour ${trans.user!.phoneNumber}";
    case TransactionType.withdraw:
      return "Retrait";
    case TransactionType.transfer:
      return "Envoi à ${trans.user!.name} (${trans.user!.phoneNumber})";
    default:
      return "Type de transaction inconnu";
  }
}

IconData getTransactionIconData(TransactionType type) {
  switch (type) {
    case TransactionType.deposit: return Icons.account_balance_wallet;
    case TransactionType.withdraw: return Icons.money_off;
    case TransactionType.purchase: return  Icons.shopping_cart;
    case TransactionType.send: return Icons.send;
    case TransactionType.receive: return Icons.call_received;
    case TransactionType.transfer: return Icons.swap_horiz;
    default:
      return Icons.fiber_manual_record;

  }
}

String getTransactionTypeName(TransactionType type) {
  switch (type) {
    case TransactionType.deposit: return "Dépot d'argent";
    case TransactionType.withdraw: return "Retrait d'argent";
    case TransactionType.purchase: return "Achat Crédit";
    case TransactionType.send: return "Envoie d'argent";
    case TransactionType.receive: return "Recoit d'argent";
    case TransactionType.transfer:return "Transfert d'argent";
    default: return "";
  }
}
