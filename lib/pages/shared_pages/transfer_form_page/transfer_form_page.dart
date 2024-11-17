import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wave_odc/config/app_provider.dart';
import 'package:wave_odc/enums/user/user_role.dart';
import 'package:wave_odc/models/transaction/transaction.dart';
import 'package:wave_odc/models/users/user.dart';
import 'package:wave_odc/models/users/user_info.dart';
import 'package:wave_odc/pages/shared_pages/transfer_form_page/widgets/transfer_form_header.dart';
import 'package:wave_odc/pages/shared_pages/transfer_form_page/widgets/transfer_form_personal_info.dart';
import 'package:wave_odc/providers/data_provider.dart';
import 'package:wave_odc/services/transaction/transaction_service.dart';
import 'package:wave_odc/shared/ui/dialog.dart';
import 'package:wave_odc/utils/constants/colors.dart';

class TransferFormPage extends StatefulWidget {
  final UserInfo? userInfo;
  const TransferFormPage({super.key, this.userInfo});

  @override
  TransferFormPageState createState() => TransferFormPageState();
}

class TransferFormPageState extends State<TransferFormPage> {
  late User user;

  final _formKey = GlobalKey<FormState>();
  int? amount;
  double transactionFeePercent = 0.01; // 1%
  String? errorMessage;
  late int accountAmount;
  final transactionService = locator<TransactionService>();

  int get transactionFee => ((amount ?? 0) * transactionFeePercent).round();
  int get totalAmount => (amount ?? 0) - transactionFee;

  @override
  void initState() {
    super.initState();
    _loadContext();
  }

  void _loadContext() async {
    user = Provider.of<DataProvider>(context, listen: false).context.user;
    accountAmount = user.account.balance.toInt();
  }

  void _confirmTransaction() async{
    if (amount! > 5 && amount! < accountAmount) {
      dialog(
          context: context,
          content: const Text("Transfert en cours..."),
          background: AppColors.primaryDark
      );
      try{
        final Transaction? transaction = await transactionService.transfert(phone:widget.userInfo!.phoneNumber, amount: amount!, feeAmount: transactionFeePercent);
        if(mounted){
          if(transaction != null){
            dialog(
                context: context,
                content: const Text("Transfert réussie !"),
                background: AppColors.success
            );
            await Provider.of<DataProvider>(context, listen: false).fetchData();
          }else{
            dialog(
                context: context,
                content: const Text("Échec du transfert !"),
                background: AppColors.error
            );
          }
        }
      }catch(e){
        if(mounted){
          dialog(
              context: context,
              content: const Text("Une erreur c'est produite"),
              background: AppColors.error
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String navigation = "/client/transfer";
    if(user.role == UserRole.vendor.name){
      navigation = "/vendor/home";
    }
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pushReplacementNamed(context, navigation),
        ),
        title: const Text(
          'Transfert d\'argent',
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const TransferFormHeader(),
                  const SizedBox(height: 24),
                  TransferFormPersonalInfo(user: widget.userInfo!),
                  const SizedBox(height: 24),
                  // Champ du montant
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Montant à envoyer',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextFormField(
                          style: const TextStyle(fontSize: 16),
                          decoration: InputDecoration(
                            hintText: '0 FCFA',
                            prefixIcon: Icon(
                              Icons.payments_outlined,
                              color: Colors.blue.shade500,
                              size: 20,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.grey.shade200),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide:
                                  BorderSide(color: Colors.blue.shade500),
                            ),
                            filled: true,
                            fillColor: Colors.grey[50],
                            errorText: errorMessage,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 12),
                          ),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          onChanged: (value) {
                            setState(() {
                              amount = int.tryParse(value) ?? 0;
                              errorMessage = (amount! < 5)
                                  ? "Le montant minimum pour un transfert est 5 F"
                                  : (amount! > accountAmount)
                                      ? "Votre solde est insuffissant"
                                      : null;
                            });
                          },
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Veuillez entrer le montant';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Résumé des frais
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.1),
                          spreadRadius: 1,
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Résumé de la transaction',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Total à payer',
                                style: TextStyle(fontSize: 15)),
                            Text('${amount ?? 0} FCFA',
                                style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text('Frais de transaction',
                                style: TextStyle(fontSize: 15)),
                            Text('$transactionFee FCFA',
                                style: const TextStyle(fontSize: 15)),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Montant Reçu',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '$totalAmount FCFA',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Bouton d'envoi
                  ElevatedButton(
                    onPressed: _confirmTransaction,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2),
                    child: const Text(
                      'Confirmer le transfert',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
