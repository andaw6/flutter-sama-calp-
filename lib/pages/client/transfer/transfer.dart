import 'package:flutter/material.dart';
import 'package:wave_odc/enums/user/user_role.dart';
import 'package:wave_odc/models/context.dart';
import 'package:wave_odc/models/users/user_info.dart';
import 'package:wave_odc/pages/client/layouts/layout_bottom_nav_bar.dart';
import 'package:wave_odc/pages/client/transfer/widgets/send_money_form.dart';
import 'package:wave_odc/pages/shared_pages/transfer_form_page/transfer_form_page.dart';
import 'package:wave_odc/providers/data_provider.dart';
import 'package:wave_odc/shared/widgets/button_card_widget.dart';

import 'package:fast_contacts/fast_contacts.dart';
import 'package:logger/logger.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class Transfer extends StatefulWidget {
  const Transfer({super.key});

  @override
  TransferState createState() => TransferState();
}

class TransferState extends State<Transfer> {
  List<Contact> _contacts = [];
  List<Contact> _filteredContacts = [];
  late Context appContext;
  final logger = Logger();

  @override
  void initState() {
    super.initState();
    _loadContext();
    _fetchContacts();
  }

  void _loadContext() async {
    appContext = Provider.of<DataProvider>(context, listen: false).context;
  }

  Future<void> _fetchContacts() async {
    if (await Permission.contacts.request().isGranted) {
      final contacts = await FastContacts.getAllContacts();
      setState(() {
        _contacts = contacts;
        _filteredContacts = contacts;
      });
    }
  }

  void _filterContacts(String query) {
    setState(() {
      _filteredContacts = _contacts
          .where((contact) =>
              contact.displayName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  UserInfo _createUserInfo(Contact contact){
    return UserInfo(id: contact.id, name: contact.displayName, phoneNumber: contact.phones.first.number, isActive: true, role: UserRole.client.name);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBottomNavBar(
      body:
      Column(
        children: [
          const SizedBox(height: 50,),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 4,
                ),
              ],
            ),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/client/home");
                  },
                ),
                const Expanded(
                  child: Text(
                    'Envoyer de l\'Argent',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(width: 48),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher une transaction..',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: _filterContacts,
            ),
          ),
          ButtonCard(
            icon: const Icon(Icons.add),
            title: 'Saisir un nouveau numéro',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => const SendMoneyForm(),
              );
            },
          ),
          ButtonCard(
            icon: const Icon(Icons.qr_code_scanner),
            title: "Scanner pour envoyer",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Scaffold()),
              );
            },
          ),
          ButtonCard(
            icon: const Icon(Icons.person_add_alt_1),
            title: "Envoyer à plusieurs personnes",
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Scaffold()),
              );
            },
          ),
          const SizedBox(height: 24),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Contacts',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredContacts.length,
              itemBuilder: (context, index) {
                final contact = _filteredContacts[index];
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue,
                        child: Text(
                          contact.displayName.isNotEmpty
                              ? contact.displayName[0].toUpperCase()
                              : '',
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                      title: Text(
                        contact.displayName,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        contact.phones.isNotEmpty
                            ? contact.phones.first as String
                            : '',
                        style: const TextStyle(fontSize: 12),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => TransferFormPage(userInfo:_createUserInfo(contact)),
                          ),
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}


